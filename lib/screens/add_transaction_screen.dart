import 'package:flutter/material.dart';
import '../models/account.dart';
import '../models/transaction.dart';
//import '../models/category.dart';
import '../services/database_helper.dart';

class AddTransactionScreen extends StatefulWidget {
  final Account? account; // Hacer el parámetro opcional.

  const AddTransactionScreen({
    super.key,
    this.account, // Parámetro opcional.
  });

  @override
  AddTransactionScreenState createState() => AddTransactionScreenState();
}

class AddTransactionScreenState extends State<AddTransactionScreen> {
  final _formKey = GlobalKey<FormState>();
  final _amountController = TextEditingController();
  final _descriptionController = TextEditingController();
  DateTime _selectedDate = DateTime.now();
  String _selectedCategory = ''; // Cargar dinámicamente
  String _transactionType = 'Gasto'; // Tipo de transacción inicial
  List<String> _categories = []; // Lista de categorías
  Account? _selectedAccount; // Cuenta seleccionada
  List<Account> _accounts = []; // Lista de cuentas disponibles

  @override
  void initState() {
    super.initState();
    _loadAccounts(); // Cargar cuentas al iniciar
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
      print("Error al cargar las cuentas: $e");
    }
  }

  // Método para cargar categorías desde la base de datos
  Future<void> _loadCategories() async {
    final dbHelper = DatabaseHelper();
    try {
      final categories =
          await dbHelper.getCategories(_transactionType == 'Ingreso');
      setState(() {
        _categories = categories.map((category) => category.name).toList();
        _selectedCategory =
            _categories.isNotEmpty ? _categories.first : 'Sin categoría';
      });
    } catch (e) {
      print("Error al cargar las categorías: $e");
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
        category: _selectedCategory,
        description: _descriptionController.text,
        isIncome: _transactionType == 'Ingreso',
        accountId: _selectedAccount!.id, // Usa la cuenta seleccionada.
      );

      // Guardar la transacción en la base de datos.
      final dbHelper = DatabaseHelper();
      dbHelper.addTransaction(transaction);

      Navigator.pop(context); // Volver a la pantalla anterior.
    }
  }

  // Cambiar el tipo de transacción
  void _onTransactionTypeChanged(String type) {
    setState(() {
      _transactionType = type;
    });
    _loadCategories(); // Recargar categorías según el tipo.
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

                // Selector de tipo de transacción (Gasto/Ingreso)
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.blueGrey[100],
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tipo de Transacción:',
                        style: TextStyle(fontSize: 16),
                      ),
                      Row(
                        children: [
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _transactionType == 'Gasto'
                                  ? Colors.red
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () => _onTransactionTypeChanged('Gasto'),
                            child: const Text('Gasto'),
                          ),
                          const SizedBox(width: 8),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: _transactionType == 'Ingreso'
                                  ? Colors.green
                                  : Colors.grey,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            onPressed: () =>
                                _onTransactionTypeChanged('Ingreso'),
                            child: const Text('Ingreso'),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 16),

                // Selector de categoría
                DropdownButtonFormField<String>(
                  value:
                      _selectedCategory.isNotEmpty ? _selectedCategory : null,
                  decoration: InputDecoration(
                    labelText: 'Categoría',
                    border: OutlineInputBorder(),
                  ),
                  items: _categories.map((String category) {
                    return DropdownMenuItem<String>(
                      value: category,
                      child: Text(category),
                    );
                  }).toList(),
                  onChanged: (String? newValue) {
                    setState(() {
                      _selectedCategory = newValue!;
                    });
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
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
