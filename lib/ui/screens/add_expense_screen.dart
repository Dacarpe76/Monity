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
  double? _cantidad;
  String? _concepto;
  int? _selectedCategoriaId;
  int? _selectedCuentaId;
  DateTime _selectedDate = DateTime.now();

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

  @override
  Widget build(BuildContext context) {
    final cuentasStream = ref.watch(cuentasDaoProvider).watchAllCuentas();
    final categoriesProvider = ref.watch(sortedCategoriesProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Añadir Gasto'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text('Fecha: ${DateFormat('dd/MM/yyyy').format(_selectedDate)}'),
                  ),
                  TextButton(
                    onPressed: _presentDatePicker,
                    child: const Text('Seleccionar fecha'),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              TextFormField(
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
                    decoration: const InputDecoration(labelText: 'Categoría'),
                    items: expenseCategories.map((cat) {
                      return DropdownMenuItem(value: cat.id, child: Text(cat.nombre));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCategoriaId = value),
                    validator: (value) => value == null ? 'Seleccione una categoría' : null,
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
                    decoration: const InputDecoration(labelText: 'Cuenta de Origen'),
                    items: snapshot.data!.map((acc) {
                      return DropdownMenuItem(value: acc.id, child: Text(acc.nombre));
                    }).toList(),
                    onChanged: (value) => setState(() => _selectedCuentaId = value),
                    validator: (value) => value == null ? 'Seleccione una cuenta' : null,
                  );
                },
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _submitForm,
                child: const Text('Guardar Gasto'),
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
      ref.read(financeServiceProvider).agregarGasto(
        _cantidad!,
        _concepto!,
        _selectedCategoriaId!,
        _selectedCuentaId!,
        _selectedDate,
      );
      Navigator.of(context).pop();
    }
  }
}
