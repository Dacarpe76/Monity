import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';

class AddIncomeScreen extends ConsumerStatefulWidget {
  const AddIncomeScreen({super.key});

  @override
  ConsumerState<AddIncomeScreen> createState() => _AddIncomeScreenState();
}

class _AddIncomeScreenState extends ConsumerState<AddIncomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _conceptController = TextEditingController();
  int? _editingIncomeId;

  double? _cantidad;
  String? _concepto;
  int? _selectedCuentaId;
  int? _selectedCategoriaId;
  DateTime _selectedDate = DateTime.now();
  bool _isRecurring = false;
  Frecuencia _frequency = Frecuencia.mensual;
  DateTime? _endDate;
  int _dayOfMonth = 1;
  int _dayOfWeek = 1; // Monday

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

  void _populateFormForEdit(TransaccionProgramada income) {
    setState(() {
      _editingIncomeId = income.id;
      _amountController.text = income.cantidad.toString();
      _conceptController.text = income.descripcion;
      _selectedCategoriaId = income.idCategoria;
      _selectedCuentaId = income.idCuentaDestino;
      _selectedDate = income.fechaInicio;
      _isRecurring = true;
      _frequency = income.frecuencia;
      _endDate = income.fechaFin;
      _dayOfMonth = income.diaDelMes ?? 1;
      _dayOfWeek = income.diaDeLaSemana ?? 1;
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _editingIncomeId = null;
      _amountController.clear();
      _conceptController.clear();
      _selectedCategoriaId = null;
      _selectedCuentaId = null;
      _selectedDate = DateTime.now();
      _isRecurring = false;
      _frequency = Frecuencia.mensual;
      _endDate = null;
      _dayOfMonth = 1;
      _dayOfWeek = 1;
    });
  }

  @override
  Widget build(BuildContext context) {
    final cuentasStream = ref.watch(cuentasDaoProvider).watchAllCuentas();
    final categoriasStream = ref.watch(categoriasDaoProvider).watchAllCategorias();
    final scheduledIncomesProvider =
        ref.watch(transaccionesProgramadasDaoProvider).watchAllTransaccionesProgramadas();

    return Scaffold(
      appBar: AppBar(
        title: Text(_editingIncomeId == null ? 'Añadir Ingreso' : 'Editar Ingreso'),
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
                    TextFormField(
                      controller: _amountController,
                      decoration: const InputDecoration(labelText: 'Cantidad'),
                      keyboardType: TextInputType.number,
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo requerido';
                        if (double.tryParse(value) == null) return 'Número inválido';
                        return null;
                      },
                      onSaved: (value) => _cantidad = double.parse(value!),
                    ),
                    const SizedBox(height: 16),
                    TextFormField(
                      controller: _conceptController,
                      decoration: const InputDecoration(labelText: 'Concepto'),
                      validator: (value) {
                        if (value == null || value.isEmpty) return 'Campo requerido';
                        return null;
                      },
                      onSaved: (value) => _concepto = value,
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<List<Categoria>>(
                      stream: categoriasStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const CircularProgressIndicator();
                        final incomeCategories =
                            snapshot.data!.where((c) => c.tipo == TipoCategoria.ingreso).toList();
                        return DropdownButtonFormField<int>(
                          initialValue: _selectedCategoriaId,
                          decoration: const InputDecoration(labelText: 'Categoría'),
                          items: incomeCategories.map((cat) {
                            return DropdownMenuItem(value: cat.id, child: Text(cat.nombre));
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedCategoriaId = value),
                          validator: (value) =>
                              value == null ? 'Seleccione una categoría' : null,
                        );
                      },
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<List<Cuenta>>(
                      stream: cuentasStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const CircularProgressIndicator();
                        return DropdownButtonFormField<int>(
                          initialValue: _selectedCuentaId,
                          decoration:
                              const InputDecoration(labelText: 'Cuenta de Destino'),
                          items: snapshot.data!.map((acc) {
                            return DropdownMenuItem(value: acc.id, child: Text(acc.nombre));
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedCuentaId = value),
                          validator: (value) =>
                              value == null ? 'Seleccione una cuenta' : null,
                        );
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
                      title: const Text('Ingreso periódico'),
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
                            final weekday = DateFormat.EEEE('es')
                                .format(DateTime(2023, 1, 1 + day));
                            return DropdownMenuItem(value: day, child: Text(weekday));
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
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_editingIncomeId == null ? 'Guardar Ingreso' : 'Actualizar Ingreso'),
                        ),
                        if (_editingIncomeId != null)
                          ElevatedButton(
                            onPressed: _clearForm,
                            style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
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
              child: Text('Ingresos Periódicos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: StreamBuilder<List<TransaccionProgramada>>(
                stream: scheduledIncomesProvider,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay ingresos periódicos.'));
                  }
                  final scheduledIncomes = snapshot.data!.where((t) => t.tipo == TipoTransaccion.ingreso).toList();

                  return ListView.builder(
                    itemCount: scheduledIncomes.length,
                    itemBuilder: (context, index) {
                      final income = scheduledIncomes[index];
                      return ListTile(
                        title: Text(income.descripcion),
                        subtitle: Text('${income.cantidad.toStringAsFixed(2)} € - ${income.frecuencia.toString().split('.').last}'),
                        onTap: () => _populateFormForEdit(income),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref.read(transaccionesProgramadasDaoProvider).deleteTransaccionProgramada(income.id);
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

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      final financeService = ref.read(financeServiceProvider);

      if (_editingIncomeId != null) {
        await financeService.agregarIngresoProgramado(
          _cantidad!,
          _concepto!,
          _selectedCategoriaId!,
          _selectedCuentaId!,
          _selectedDate,
          _frequency,
          _endDate,
          diaDelMes: _frequency == Frecuencia.mensual ? _dayOfMonth : null,
          diaDeLaSemana: _frequency == Frecuencia.semanal ? _dayOfWeek : null,
          id: _editingIncomeId,
        );
      } else {
        if (_isRecurring) {
          await financeService.agregarIngresoProgramado(
            _cantidad!,
            _concepto!,
            _selectedCategoriaId!,
            _selectedCuentaId!,
            _selectedDate,
            _frequency,
            _endDate,
            diaDelMes: _frequency == Frecuencia.mensual ? _dayOfMonth : null,
            diaDeLaSemana: _frequency == Frecuencia.semanal ? _dayOfWeek : null,
          );
        } else {
          await financeService.agregarIngreso(
            _cantidad!,
            _selectedCategoriaId!,
            _selectedCuentaId!,
            _selectedDate,
          );
        }
      }

      _clearForm();
      if (mounted && !_isRecurring && _editingIncomeId == null) {
        Navigator.of(context).pop();
      }
    }
  }
}