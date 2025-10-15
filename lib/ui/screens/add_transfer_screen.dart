import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';

class AddTransferScreen extends ConsumerStatefulWidget {
  const AddTransferScreen({super.key});

  @override
  ConsumerState<AddTransferScreen> createState() => _AddTransferScreenState();
}

class _AddTransferScreenState extends ConsumerState<AddTransferScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _conceptController = TextEditingController();
  int? _editingTransferId;

  Cuenta? _sourceAccount;
  Cuenta? _destinationAccount;
  DateTime _selectedDate = DateTime.now();
  bool _isRecurring = false;
  Frecuencia _frequency = Frecuencia.mensual;
  DateTime? _endDate;
  int _dayOfMonth = 1;
  int _dayOfWeek = 1; // Monday

  @override
  void dispose() {
    _amountController.dispose();
    _conceptController.dispose();
    super.dispose();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  void _presentEndDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now().add(const Duration(days: 30)),
      firstDate: DateTime.now(),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _endDate = pickedDate;
      });
    });
  }

  void _populateFormForEdit(TransaccionProgramada transfer) async {
    final cuentas = await ref.read(cuentasDaoProvider).allCuentas;
    setState(() {
      _editingTransferId = transfer.id;
      _amountController.text = transfer.cantidad.toString();
      _conceptController.text = transfer.descripcion;
      _sourceAccount = cuentas.firstWhere((c) => c.id == transfer.idCuentaOrigen);
      _destinationAccount = cuentas.firstWhere((c) => c.id == transfer.idCuentaDestino);
      _selectedDate = transfer.fechaInicio;
      _isRecurring = true;
      _frequency = transfer.frecuencia;
      _endDate = transfer.fechaFin;
      _dayOfMonth = transfer.diaDelMes ?? 1;
      _dayOfWeek = transfer.diaDeLaSemana ?? 1;
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _editingTransferId = null;
      _amountController.clear();
      _conceptController.clear();
      _sourceAccount = null;
      _destinationAccount = null;
      _selectedDate = DateTime.now();
      _isRecurring = false;
      _frequency = Frecuencia.mensual;
      _endDate = null;
      _dayOfMonth = 1;
      _dayOfWeek = 1;
    });
  }

  void _saveTransfer() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      if (_sourceAccount == null || _destinationAccount == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content: Text(
                  'Por favor, selecciona las cuentas de origen y destino')),
        );
        return;
      }

      if (_sourceAccount!.id == _destinationAccount!.id) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
              content:
                  Text('La cuenta de origen y destino no pueden ser la misma')),
        );
        return;
      }

      final amount = double.parse(_amountController.text);
      final concept = _conceptController.text;

      final financeService = ref.read(financeServiceProvider);

      if (_editingTransferId != null) {
        await financeService.agregarTransferenciaProgramada(
          amount,
          concept,
          _sourceAccount!.id,
          _destinationAccount!.id,
          _selectedDate,
          _frequency,
          _endDate,
          diaDelMes: _frequency == Frecuencia.mensual ? _dayOfMonth : null,
          diaDeLaSemana: _frequency == Frecuencia.semanal ? _dayOfWeek : null,
          id: _editingTransferId,
        );
      } else {
        if (_isRecurring) {
          await financeService.agregarTransferenciaProgramada(
            amount,
            concept,
            _sourceAccount!.id,
            _destinationAccount!.id,
            _selectedDate,
            _frequency,
            _endDate,
            diaDelMes: _frequency == Frecuencia.mensual ? _dayOfMonth : null,
            diaDeLaSemana: _frequency == Frecuencia.semanal ? _dayOfWeek : null,
          );
        } else {
          final success = await financeService.agregarTransferencia(
            amount,
            _sourceAccount!.id,
            _destinationAccount!.id,
            _selectedDate,
            concepto: concept,
          );

          if (mounted) {
            if (!success) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'No hay saldo suficiente para realizar la transferencia.'),
                  backgroundColor: Colors.red,
                ),
              );
              return;
            }
          }
        }
      }

      _clearForm();
      if (mounted && !_isRecurring && _editingTransferId == null) {
        Navigator.of(context).pop();
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final cuentasStream = ref.watch(cuentasDaoProvider).watchAllCuentas();
    final scheduledTransfersProvider =
        ref.watch(transaccionesProgramadasDaoProvider).watchAllTransaccionesProgramadas();

    return Scaffold(
      appBar: AppBar(
        title: Text(_editingTransferId == null
            ? 'Transferencia entre cuentas'
            : 'Editar Transferencia'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    StreamBuilder<List<Cuenta>>(
                      stream: cuentasStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final cuentas = snapshot.data!;
                        return DropdownButtonFormField<Cuenta>(
                          initialValue: _sourceAccount,
                          decoration:
                              const InputDecoration(labelText: 'Cuenta de origen'),
                          items: cuentas.map((cuenta) {
                            return DropdownMenuItem(
                              value: cuenta,
                              child: Text(cuenta.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _sourceAccount = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Campo requerido' : null,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<List<Cuenta>>(
                      stream: cuentasStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) {
                          return const Center(child: CircularProgressIndicator());
                        }
                        final cuentas = snapshot.data!;
                        return DropdownButtonFormField<Cuenta>(
                          initialValue: _destinationAccount,
                          decoration:
                              const InputDecoration(labelText: 'Cuenta de destino'),
                          items: cuentas.map((cuenta) {
                            return DropdownMenuItem(
                              value: cuenta,
                              child: Text(cuenta.nombre),
                            );
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _destinationAccount = value;
                            });
                          },
                          validator: (value) =>
                              value == null ? 'Campo requerido' : null,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Importe'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce un importe';
                        }
                        if (double.tryParse(value) == null) {
                          return 'Introduce un número válido';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _conceptController,
                      decoration: const InputDecoration(labelText: 'Concepto'),
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Por favor, introduce un concepto';
                        }
                        return null;
                      },
                    ),
                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                              'Fecha: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                        ),
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: const Text('Seleccionar fecha'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Transferencia periódica'),
                      value: _isRecurring,
                      onChanged: (value) {
                        setState(() {
                          _isRecurring = value;
                        });
                      },
                    ),
                    if (_isRecurring) ...[
                      const SizedBox(height: 16),
                      DropdownButtonFormField<Frecuencia>(
                        decoration: const InputDecoration(labelText: 'Frecuencia'),
                        initialValue: _frequency,
                        items: Frecuencia.values.map((f) {
                          return DropdownMenuItem(
                              value: f, child: Text(f.toString().split('.').last));
                        }).toList(),
                        onChanged: (value) {
                          setState(() {
                            _frequency = value!;
                          });
                        },
                      ),
                      if (_frequency == Frecuencia.mensual) ...[
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          decoration: const InputDecoration(labelText: 'Día del mes'),
                          initialValue: _dayOfMonth,
                          items: List.generate(31, (index) => index + 1).map((day) {
                            return DropdownMenuItem(
                                value: day, child: Text(day.toString()));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dayOfMonth = value!;
                            });
                          },
                        ),
                      ],
                      if (_frequency == Frecuencia.semanal) ...[
                        const SizedBox(height: 16),
                        DropdownButtonFormField<int>(
                          decoration:
                              const InputDecoration(labelText: 'Día de la semana'),
                          initialValue: _dayOfWeek,
                          items: List.generate(7, (index) => index + 1).map((day) {
                            return DropdownMenuItem(
                                value: day,
                                child: Text(DateFormat.EEEE('es')
                                    .format(DateTime(2023, 1, 1 + day))));
                          }).toList(),
                          onChanged: (value) {
                            setState(() {
                              _dayOfWeek = value!;
                            });
                          },
                        ),
                      ],
                      const SizedBox(height: 16),
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                                'Fecha de finalización: ${_endDate == null ? 'Ninguna' : DateFormat('dd/MM/yyyy').format(_endDate!)}'),
                          ),
                          TextButton(
                            onPressed: _presentEndDatePicker,
                            child: const Text('Seleccionar fecha'),
                          ),
                        ],
                      ),
                    ],
                    const SizedBox(height: 32),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: _saveTransfer,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_editingTransferId == null
                              ? 'Guardar Transferencia'
                              : 'Actualizar Transferencia'),
                        ),
                        if (_editingTransferId != null)
                          ElevatedButton(
                            onPressed: _clearForm,
                            style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.grey),
                            child: const Text('Cancelar'),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const Divider(),
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: Text('Transferencias Periódicas',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: StreamBuilder<List<TransaccionProgramada>>(
                stream: scheduledTransfersProvider,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(
                        child: Text('No hay transferencias periódicas.'));
                  }
                  final scheduledTransfers = snapshot.data!
                      .where((t) => t.tipo == TipoTransaccion.transferencia)
                      .toList();

                  return ListView.builder(
                    itemCount: scheduledTransfers.length,
                    itemBuilder: (context, index) {
                      final transfer = scheduledTransfers[index];
                      return ListTile(
                        title: Text(transfer.descripcion),
                        subtitle: Text(
                            '${transfer.cantidad.toStringAsFixed(2)} € - ${transfer.frecuencia.toString().split('.').last}'),
                        onTap: () => _populateFormForEdit(transfer),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref
                                .read(transaccionesProgramadasDaoProvider)
                                .deleteTransaccionProgramada(transfer.id);
                          },
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}