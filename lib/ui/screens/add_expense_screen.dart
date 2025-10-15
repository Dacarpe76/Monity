import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';

class AddExpenseScreen extends ConsumerStatefulWidget {
  const AddExpenseScreen({super.key});

  @override
  ConsumerState<AddExpenseScreen> createState() => _AddExpenseScreenState();
}

class _AddExpenseScreenState extends ConsumerState<AddExpenseScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _conceptController = TextEditingController();
  int? _editingExpenseId;

  double? _cantidad;
  String? _concepto;
  int? _selectedCategoriaId;
  int? _selectedCuentaId;
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

  void _populateFormForEdit(TransaccionProgramada expense) {
    setState(() {
      _editingExpenseId = expense.id;
      _amountController.text = expense.cantidad.toString();
      _conceptController.text = expense.descripcion;
      _selectedCategoriaId = expense.idCategoria;
      _selectedCuentaId = expense.idCuentaOrigen;
      _selectedDate = expense.fechaInicio;
      _isRecurring = true;
      _frequency = expense.frecuencia;
      _endDate = expense.fechaFin;
      _dayOfMonth = expense.diaDelMes ?? 1;
      _dayOfWeek = expense.diaDeLaSemana ?? 1;
    });
  }

  void _clearForm() {
    _formKey.currentState?.reset();
    setState(() {
      _editingExpenseId = null;
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
    final categoriesProvider = ref.watch(sortedCategoriesProvider);
    final scheduledExpensesProvider =
        ref.watch(transaccionesProgramadasDaoProvider).watchAllTransaccionesProgramadas();

    return Scaffold(
      appBar: AppBar(
        title: Text(_editingExpenseId == null ? 'Añadir Gasto' : 'Editar Gasto'),
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
                    categoriesProvider.when(
                      data: (categoriesWithUsage) {
                        final expenseCategories = categoriesWithUsage
                            .where((c) => c.categoria.tipo == TipoCategoria.gasto)
                            .map((c) => c.categoria)
                            .toList();
                        return DropdownButtonFormField<int>(
                          initialValue: _selectedCategoriaId,
                          decoration: const InputDecoration(labelText: 'Categoría'),
                          items: expenseCategories.map((cat) {
                            return DropdownMenuItem(value: cat.id, child: Text(cat.nombre));
                          }).toList(),
                          onChanged: (value) =>
                              setState(() => _selectedCategoriaId = value),
                          validator: (value) =>
                              value == null ? 'Seleccione una categoría' : null,
                        );
                      },
                      loading: () => const CircularProgressIndicator(),
                      error: (error, stack) => Text('Error: $error'),
                    ),
                    const SizedBox(height: 16),
                    StreamBuilder<List<Cuenta>>(
                      stream: cuentasStream,
                      builder: (context, snapshot) {
                        if (!snapshot.hasData) return const CircularProgressIndicator();
                        return DropdownButtonFormField<int>(
                          initialValue: _selectedCuentaId,
                          decoration:
                              const InputDecoration(labelText: 'Cuenta de Origen'),
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
                              'Fecha de inicio: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                        ),
                        TextButton(
                          onPressed: _presentDatePicker,
                          child: const Text('Seleccionar fecha'),
                        ),
                      ],
                    ),
                    const SizedBox(height: 16),
                    SwitchListTile(
                      title: const Text('Gasto periódico'),
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
                          onPressed: _submitForm,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.orange,
                            foregroundColor: Colors.white,
                          ),
                          child: Text(_editingExpenseId == null ? 'Guardar Gasto' : 'Actualizar Gasto'),
                        ),
                        if (_editingExpenseId != null)
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
              child: Text('Gastos Periódicos', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            ),
            Expanded(
              child: StreamBuilder<List<TransaccionProgramada>>(
                stream: scheduledExpensesProvider,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay gastos periódicos.'));
                  }
                  final scheduledExpenses = snapshot.data!.where((t) => t.tipo == TipoTransaccion.gasto).toList();

                  return ListView.builder(
                    itemCount: scheduledExpenses.length,
                    itemBuilder: (context, index) {
                      final expense = scheduledExpenses[index];
                      return ListTile(
                        title: Text(expense.descripcion),
                        subtitle: Text('${expense.cantidad.toStringAsFixed(2)} € - ${expense.frecuencia.toString().split('.').last}'),
                        onTap: () => _populateFormForEdit(expense),
                        trailing: IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            ref.read(transaccionesProgramadasDaoProvider).deleteTransaccionProgramada(expense.id);
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

      if (_editingExpenseId != null) {
        await financeService.agregarGastoProgramado(
          _cantidad!,
          _concepto!,
          _selectedCategoriaId!,
          _selectedCuentaId!,
          _selectedDate,
          _frequency,
          _endDate,
          diaDelMes: _frequency == Frecuencia.mensual ? _dayOfMonth : null,
          diaDeLaSemana: _frequency == Frecuencia.semanal ? _dayOfWeek : null,
          id: _editingExpenseId,
        );
      } else {
        if (_isRecurring) {
          await financeService.agregarGastoProgramado(
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
          final success = await financeService.agregarGasto(
            _cantidad!,
            _concepto!,
            _selectedCategoriaId!,
            _selectedCuentaId!,
            _selectedDate,
          );

          if (mounted) {
            if (success) {
              Navigator.of(context).pop();
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text(
                      'No hay saldo suficiente en las cuentas para cubrir el gasto.'),
                  backgroundColor: Colors.red,
                ),
              );
            }
          }
        }
      }

      _clearForm();
    }
  }
}