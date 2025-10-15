import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:drift/drift.dart' hide Column;

class AddScheduledTransactionScreen extends ConsumerStatefulWidget {
  const AddScheduledTransactionScreen({super.key});

  @override
  ConsumerState<AddScheduledTransactionScreen> createState() =>
      _AddScheduledTransactionScreenState();
}

class _AddScheduledTransactionScreenState
    extends ConsumerState<AddScheduledTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _descripcionController = TextEditingController();
  final _cantidadController = TextEditingController();

  TipoTransaccion _selectedTipo = TipoTransaccion.gasto;
  int? _selectedCategoriaId;
  int? _selectedCuentaOrigenId;
  int? _selectedCuentaDestinoId;
  Frecuencia _selectedFrecuencia = Frecuencia.mensual;
  DateTime _fechaInicio = DateTime.now();
  DateTime _proximaEjecucion = DateTime.now();
  DateTime? _fechaFin;

  @override
  void dispose() {
    _descripcionController.dispose();
    _cantidadController.dispose();
    super.dispose();
  }

  void _presentDatePicker(Function(DateTime) onDateSelected) {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      onDateSelected(pickedDate);
    });
  }

  void _calculateNextExecutionDate() {
    // Simple calculation for now, can be improved for more complex rules
    DateTime nextDate = _fechaInicio;
    switch (_selectedFrecuencia) {
      case Frecuencia.diaria:
        nextDate = nextDate.add(const Duration(days: 1));
        break;
      case Frecuencia.semanal:
        nextDate = nextDate.add(const Duration(days: 7));
        break;
      case Frecuencia.mensual:
        nextDate = DateTime(nextDate.year, nextDate.month + 1, nextDate.day);
        break;
      case Frecuencia.anual:
        nextDate = DateTime(nextDate.year + 1, nextDate.month, nextDate.day);
        break;
    }
    setState(() {
      _proximaEjecucion = nextDate;
    });
  }

  @override
  Widget build(BuildContext context) {
    final categoriasStream =
        ref.watch(categoriasDaoProvider).watchAllCategorias();
    final cuentasStream = ref.watch(cuentasDaoProvider).watchAllCuentas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Transacción Programada'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _descripcionController,
                decoration: const InputDecoration(labelText: 'Descripción'),
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _cantidadController,
                decoration: const InputDecoration(labelText: 'Cantidad'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty) return 'Campo requerido';
                  if (double.tryParse(value) == null) return 'Número inválido';
                  return null;
                },
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<TipoTransaccion>(
                initialValue: _selectedTipo,
                decoration:
                    const InputDecoration(labelText: 'Tipo de Transacción'),
                items: TipoTransaccion.values.map((type) {
                  return DropdownMenuItem(
                      value: type,
                      child: Text(type.toString().split('.').last));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedTipo = value!;
                    _selectedCategoriaId =
                        null; // Reset category when type changes
                    _selectedCuentaDestinoId =
                        null; // Reset destination account for non-transfers
                  });
                },
              ),
              const SizedBox(height: 16),
              // Category dropdown
              StreamBuilder<List<Categoria>>(
                stream: categoriasStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  List<Categoria> filteredCategories = [];
                  if (_selectedTipo == TipoTransaccion.ingreso) {
                    filteredCategories = snapshot.data!
                        .where((c) => c.tipo == TipoCategoria.ingreso)
                        .toList();
                  } else if (_selectedTipo == TipoTransaccion.gasto) {
                    filteredCategories = snapshot.data!
                        .where((c) => c.tipo == TipoCategoria.gasto)
                        .toList();
                  }
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedCategoriaId,
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    items: filteredCategories.map((cat) {
                      return DropdownMenuItem(
                          value: cat.id, child: Text(cat.nombre));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedCategoriaId = value),
                    validator: (value) {
                      if (_selectedTipo != TipoTransaccion.transferencia &&
                          value == null) {
                        return 'Seleccione una categoría';
                      }
                      return null;
                    },
                  );
                },
              ),
              const SizedBox(height: 16),
              // Source Account dropdown
              StreamBuilder<List<Cuenta>>(
                stream: cuentasStream,
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const CircularProgressIndicator();
                  }
                  return DropdownButtonFormField<int>(
                    initialValue: _selectedCuentaOrigenId,
                    decoration:
                        const InputDecoration(labelText: 'Cuenta de Origen'),
                    items: snapshot.data!.map((cuenta) {
                      return DropdownMenuItem(
                          value: cuenta.id, child: Text(cuenta.nombre));
                    }).toList(),
                    onChanged: (value) =>
                        setState(() => _selectedCuentaOrigenId = value),
                    validator: (value) => value == null
                        ? 'Seleccione una cuenta de origen'
                        : null,
                  );
                },
              ),
              const SizedBox(height: 16),
              // Destination Account dropdown (only for transfers)
              if (_selectedTipo == TipoTransaccion.transferencia)
                StreamBuilder<List<Cuenta>>(
                  stream: cuentasStream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return const CircularProgressIndicator();
                    }
                    final filteredCuentas = snapshot.data!
                        .where((c) => c.id != _selectedCuentaOrigenId)
                        .toList();
                    return DropdownButtonFormField<int>(
                      initialValue: _selectedCuentaDestinoId,
                      decoration:
                          const InputDecoration(labelText: 'Cuenta de Destino'),
                      items: filteredCuentas.map((cuenta) {
                        return DropdownMenuItem(
                            value: cuenta.id, child: Text(cuenta.nombre));
                      }).toList(),
                      onChanged: (value) =>
                          setState(() => _selectedCuentaDestinoId = value),
                      validator: (value) => value == null
                          ? 'Seleccione una cuenta de destino'
                          : null,
                    );
                  },
                ),
              const SizedBox(height: 16),
              // Frequency dropdown
              DropdownButtonFormField<Frecuencia>(
                initialValue: _selectedFrecuencia,
                decoration: const InputDecoration(labelText: 'Frecuencia'),
                items: Frecuencia.values.map((freq) {
                  return DropdownMenuItem(
                      value: freq,
                      child: Text(freq.toString().split('.').last));
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedFrecuencia = value!;
                    _calculateNextExecutionDate();
                  });
                },
              ),
              const SizedBox(height: 16),
              // Start Date
              ListTile(
                title: Text(
                    'Fecha de Inicio: ${DateFormat('dd/MM/yyyy').format(_fechaInicio)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _presentDatePicker((date) {
                  setState(() {
                    _fechaInicio = date;
                    _calculateNextExecutionDate();
                  });
                }),
              ),
              const SizedBox(height: 16),
              // Next Execution Date
              ListTile(
                title: Text(
                    'Próxima Ejecución: ${DateFormat('dd/MM/yyyy').format(_proximaEjecucion)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _presentDatePicker((date) {
                  setState(() {
                    _proximaEjecucion = date;
                  });
                }),
              ),
              const SizedBox(height: 16),
              // End Date (Optional)
              ListTile(
                title: Text(
                    'Fecha Fin (Opcional): ${_fechaFin == null ? 'Nunca' : DateFormat('dd/MM/yyyy').format(_fechaFin!)}'),
                trailing: const Icon(Icons.calendar_today),
                onTap: () => _presentDatePicker((date) {
                  setState(() {
                    _fechaFin = date;
                  });
                }),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Guardar Transacción Programada'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      final cantidad = double.parse(_cantidadController.text);

      final transaccionProgramada = TransaccionesProgramadasCompanion.insert(
        descripcion: _descripcionController.text,
        cantidad: cantidad,
        tipo: _selectedTipo,
        idCategoria: Value(_selectedCategoriaId),
        idCuentaOrigen: Value(_selectedCuentaOrigenId!),
        idCuentaDestino: Value(_selectedCuentaDestinoId),
        frecuencia: _selectedFrecuencia,
        fechaInicio: _fechaInicio,
        proximaEjecucion: _proximaEjecucion,
        fechaFin: Value(_fechaFin),
        isTransferencia: Value(_selectedTipo == TipoTransaccion.transferencia),
      );

      ref
          .read(transaccionesProgramadasDaoProvider)
          .upsertTransaccionProgramada(transaccionProgramada);
      Navigator.of(context).pop();
    }
  }
}
