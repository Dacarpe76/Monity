import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
import '../models/category.dart';
import '../services/database_helper.dart';

class AddTransactionScreen extends StatefulWidget {
  final Account? account; // Hacer el parámetro opcional.

  const AddTransactionScreen({
    super.key,
    this.account, // Parámetro opcional.
  });

  @override
  _AddTransactionScreenState createState() => _AddTransactionScreenState();
}

class _AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  Account? _selectedAccount; // Cuenta seleccionada
  List<Account> _accounts = []; // Lista de cuentas disponibles
  List<Category> _categories = [];
  Category? _selectedCategory;
  bool _isIncome = false;

  @override
  void initState() {
    super.initState();
    _loadAccounts(); // Cargar cuentas al iniciar
    _loadCategories(); // Cargar categorías al iniciar
    if (widget.account != null) {
      _selectedAccount = widget.account; // Preseleccionar la cuenta.
    }
  }

  // Método para cargar cuentas desde la base de datos
  Future<void> _loadAccounts() async {
    final dbHelper = DatabaseHelper();
    try {
      final accounts = await dbHelper.getAccountsOrdered();
      setState(() {
        _accounts = accounts;
        if (_accounts.isNotEmpty && _selectedAccount == null) {
          _selectedAccount =
              _accounts.first; // Selecciona la primera cuenta por defecto.
        }
      });
    } catch (e) {
      //print("Error al cargar las cuentas: $e");
    }
  }

  // Método para cargar categorías desde la base de datos
  Future<void> _loadCategories() async {
    try {
      final categories = await DatabaseHelper().getCategories(_isIncome);
      setState(() {
        _categories = categories;
        _selectedCategory = null; // Reset selection
      });
    } catch (e) {
      debugPrint('Error cargando categorías: $e');
    }
  }

  // Método para seleccionar la fecha
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  // Método para enviar la transacción
  void _submitTransaction() {
    if (_formKey.currentState!.validate() && _selectedAccount != null) {
      final transaction = Transaction(
        id: DateTime.now().toString(),
        amount: double.parse(_amountController.text),
        date: _selectedDate,
        category: _selectedCategory?.name ?? 'Sin categoría',
        description: _descriptionController.text,
        isIncome: _isIncome,
        accountId: _selectedAccount!.id, // Usa la cuenta seleccionada.
      );

      // Guardar la transacción en la base de datos.
      final dbHelper = DatabaseHelper();
      dbHelper.addTransaction(transaction);

      Navigator.pop(context); // Volver a la pantalla anterior.
    }
  }

  // Cambiar el tipo de transacción
  void _onTransactionTypeChanged(bool isIncome) {
    setState(() {
      _isIncome = isIncome;
      _selectedCategory = null; // Reset selection
    });
    _loadCategories(); // Recargar categorías según el nuevo tipo
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Agregar Transacción'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Selector de cuenta
                DropdownButtonFormField<Account>(
                  value: _selectedAccount,
                  decoration: InputDecoration(
                    labelText: 'Cuenta',
                    border: OutlineInputBorder(),
                  ),
                  items: _accounts.map((Account account) {
                    return DropdownMenuItem<Account>(
                      value: account,
                      child: Text(account.name),
                    );
                  }).toList(),
                  onChanged: (Account? newValue) {
                    setState(() {
                      _selectedAccount = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona una cuenta';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de monto
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Monto',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Por favor ingresa un monto';
                    }
                    if (double.tryParse(value) == null) {
                      return 'Por favor ingresa un número válido';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Switch para tipo de transacción
                Row(
                  children: [
                    const Text('Tipo:'),
                    Switch(
                      value: _isIncome,
                      onChanged: _onTransactionTypeChanged,
                    ),
                    Text(_isIncome ? 'Ingreso' : 'Gasto'),
                  ],
                ),
                const SizedBox(height: 16),

                // Dropdown de categorías
                DropdownButtonFormField<Category>(
                  value: _selectedCategory,
                  hint: const Text('Seleccionar categoría'),
                  isExpanded: true,
                  items: _categories.map((Category category) {
                    return DropdownMenuItem<Category>(
                      value: category,
                      child: Text(category.name),
                    );
                  }).toList(),
                  onChanged: (Category? newValue) {
                    setState(() {
                      _selectedCategory = newValue;
                    });
                  },
                  validator: (value) {
                    if (value == null) {
                      return 'Por favor selecciona una categoría';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                // Campo de descripción
                TextFormField(
                  controller: _descriptionController,
                  decoration: InputDecoration(
                    labelText: 'Descripción',
                    border: OutlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 16),

                // Selector de fecha
                Row(
                  children: [
                    Text('Fecha: ${_selectedDate.toLocal()}'.split(' ')[0]),
                    const SizedBox(width: 16),
                    ElevatedButton(
                      onPressed: () => _selectDate(context),
                      child: const Text('Seleccionar fecha'),
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Botón para enviar la transacción
                Center(
                  child: ElevatedButton(
                    onPressed: _submitTransaction,
                    child: const Text('Agregar Transacción'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
