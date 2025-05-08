import 'package:flutter/material.dart';
import 'package:monity/models/account.dart';
import 'package:monity/services/database_helper.dart';
import 'package:uuid/uuid.dart';
import 'package:provider/provider.dart';
import 'package:monity/providers/currency_provider.dart';

class AddEditAccountScreen extends StatefulWidget {
  final Account? account; // Null si es para añadir, con valor si es para editar

  const AddEditAccountScreen({super.key, this.account});

  @override
  State<AddEditAccountScreen> createState() => _AddEditAccountScreenState();
}

class _AddEditAccountScreenState extends State<AddEditAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  late String _name;
  late double _initialBalance;
  late double _limitSpend;
  late double _monthlyLimit;
  late int _order;

  bool _isEditing = false;
  String _appBarTitle = 'Añadir Cuenta';
  String _submitButtonText = 'Crear Cuenta';

  final _dbHelper = DatabaseHelper();

  @override
  void initState() {
    super.initState();
    if (widget.account != null) {
      _isEditing = true;
      _appBarTitle = 'Editar Cuenta';
      _submitButtonText = 'Guardar Cambios';
      _name = widget.account!.name;
      _initialBalance =
          widget.account!.balance; // En edición, el balance es el actual
      _limitSpend = widget.account!.limitSpend;
      _monthlyLimit = widget.account!.monthlyLimit;
      _order = widget.account!.order;
    } else {
      // Valores por defecto para una nueva cuenta
      _name = '';
      _initialBalance = 0.0;
      _limitSpend = 0.0;
      _monthlyLimit = 0.0;
      _order = 0; // Podrías obtener el siguiente número de orden disponible
      _fetchNextOrderNumber();
    }
  }

  Future<void> _fetchNextOrderNumber() async {
    if (!_isEditing) {
      final accounts = await _dbHelper.getAccountsOrdered();
      setState(() {
        _order = accounts.length;
      });
    }
  }

  Future<void> _saveForm() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      Account accountToSave;

      if (_isEditing) {
        accountToSave = widget.account!.copyWith(
          name: _name,
          balance:
              _initialBalance, // El balance se mantiene, no se resetea a inicial
          limitSpend: _limitSpend,
          monthlyLimit: _monthlyLimit,
          order: _order,
          // transactions no se modifica aquí
        );
      } else {
        accountToSave = Account(
          id: const Uuid().v4(),
          name: _name,
          balance: _initialBalance, // Este es el saldo inicial
          limitSpend: _limitSpend,
          monthlyLimit: _monthlyLimit,
          order: _order,
        );
      }

      await _dbHelper.addAccount(accountToSave);

      if (mounted) {
        Navigator.of(context)
            .pop(true); // Devuelve true para indicar que se guardó algo
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final currencyProvider =
        Provider.of<CurrencyProvider>(context, listen: false);

    return Scaffold(
      appBar: AppBar(
        title: Text(_appBarTitle),
        actions: [
          IconButton(
            icon: const Icon(Icons.save),
            onPressed: _saveForm,
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: <Widget>[
              TextFormField(
                initialValue: _name,
                decoration:
                    const InputDecoration(labelText: 'Nombre de la Cuenta'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Por favor, introduce un nombre.';
                  }
                  return null;
                },
                onSaved: (value) => _name = value!,
              ),
              TextFormField(
                initialValue: _initialBalance.toStringAsFixed(2),
                decoration: InputDecoration(
                    labelText:
                        'Saldo ${_isEditing ? "Actual" : "Inicial"} (${currencyProvider.currencySymbol})'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce un saldo.';
                  }
                  if (double.tryParse(value) == null) return 'Número inválido.';
                  return null;
                },
                onSaved: (value) => _initialBalance = double.parse(value!),
              ),
              TextFormField(
                initialValue: _limitSpend.toStringAsFixed(2),
                decoration: InputDecoration(
                    labelText:
                        'Límite de Gasto Mensual (${currencyProvider.currencySymbol})'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce un límite.';
                  }
                  final val = double.tryParse(value);
                  if (val == null) return 'Número inválido.';
                  if (val < 0) return 'El límite no puede ser negativo.';
                  return null;
                },
                onSaved: (value) => _limitSpend = double.parse(value!),
              ),
              TextFormField(
                initialValue: _monthlyLimit.toStringAsFixed(2),
                decoration: InputDecoration(
                    labelText:
                        'Límite de Ingreso Mensual (${currencyProvider.currencySymbol})'),
                keyboardType:
                    const TextInputType.numberWithOptions(decimal: true),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Introduce un límite.';
                  }
                  final val = double.tryParse(value);
                  if (val == null) return 'Número inválido.';
                  if (val < 0) return 'El límite no puede ser negativo.';
                  return null;
                },
                onSaved: (value) {
                  if (value != null && value.isNotEmpty) {
                    try {
                      _monthlyLimit = double.parse(value);
                    } catch (e) {
                      // Manejar el error de conversión aquí
                      //print('Error al convertir el límite mensual: $e');
                      // Puedes mostrar un mensaje de error al usuario si lo deseas
                    }
                  }
                },
              ),
              // Podrías añadir un campo para el 'order' si quieres que el usuario lo edite
              // TextFormField(
              //   initialValue: _order.toString(),
              //   decoration: const InputDecoration(labelText: 'Orden de Visualización'),
              //   keyboardType: TextInputType.number,
              //   validator: (value) {
              //     if (value == null || value.isEmpty) return 'Introduce un orden.';
              //     if (int.tryParse(value) == null) return 'Número inválido.';
              //     return null;
              //   },
              //   onSaved: (value) => _order = int.parse(value!),
              // ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _saveForm,
                child: Text(_submitButtonText),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
