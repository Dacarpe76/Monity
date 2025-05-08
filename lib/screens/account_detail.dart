import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/database_helper.dart';
import '../models/transaction.dart';

class AccountDetailScreen extends StatefulWidget {
  final Account account;

  const AccountDetailScreen({super.key, required this.account});

  @override
  AccountDetailScreenState createState() => AccountDetailScreenState();
}

class AccountDetailScreenState extends State<AccountDetailScreen> {
  late TextEditingController _limitSpendController;
  late TextEditingController _monthlyLimitController;

  @override
  void initState() {
    super.initState();
    // Inicializar los controladores con los valores actuales de los límites.
    _limitSpendController =
        TextEditingController(text: widget.account.limitSpend.toString());
    _monthlyLimitController =
        TextEditingController(text: widget.account.monthlyLimit.toString());
  }

  @override
  void dispose() {
    _limitSpendController.dispose();
    _monthlyLimitController.dispose();
    super.dispose();
  }

  // Método para actualizar los límites
  Future<void> _updateLimits() async {
    final newLimitSpend = double.tryParse(_limitSpendController.text);
    final newMonthlyLimit = double.tryParse(_monthlyLimitController.text);

    if (newLimitSpend == null || newMonthlyLimit == null) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Por favor, ingresa valores válidos')),
      );
      return;
    }

    final dbHelper = DatabaseHelper();
    final box = await dbHelper.accountsBox;

    final updatedAccount = widget.account.copyWith(
      limitSpend: newLimitSpend,
      monthlyLimit: newMonthlyLimit,
    );

    await box.put(updatedAccount.id, updatedAccount);
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Límites actualizados correctamente')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.account.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Saldo
            Text(
              'Saldo: \$${widget.account.balance.toStringAsFixed(2)}',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // Límite de Gasto Mensual (limitSpend)
            Text(
              'Límite de Gasto Mensual:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _limitSpendController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nuevo Límite de Gasto Mensual',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 8),

            // Límite Máximo de Ingreso (monthlyLimit)
            Text(
              'Límite Máximo de Ingreso:',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            TextField(
              controller: _monthlyLimitController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Nuevo Límite Máximo de Ingreso',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 16),

            // Botón para actualizar los límites
            ElevatedButton(
              onPressed: _updateLimits,
              child: const Text('Actualizar Límites'),
            ),
            const SizedBox(height: 16),

            // Movimientos (transacciones)
            const Text(
              'Movimientos:',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Expanded(
              child: FutureBuilder<List<Transaction>>(
                future: _fetchTransactions(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  } else if (snapshot.data == null || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay movimientos'));
                  } else {
                    final transactions = snapshot.data!;
                    // Ordenar transacciones por fecha (de la más reciente a la más antigua).
                    transactions.sort((a, b) => b.date.compareTo(a.date));

                    return ListView.builder(
                      itemCount: transactions.length,
                      itemBuilder: (context, index) {
                        final transaction = transactions[index];
                        final isIncome = transaction.isIncome;
                        final amountColor =
                            isIncome ? Colors.green : Colors.red;

                        return ListTile(
                          title: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Categoría y Comentario
                              Expanded(
                                child: Text(
                                  '${transaction.category}${transaction.originalCategory != null ? ' (${transaction.originalCategory})' : ''} - ${transaction.description}',
                                  style: TextStyle(
                                      fontSize: 14, color: Colors.black),
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ),

                              // Importe y Fecha
                              Text(
                                '${isIncome ? '+' : '-'}\$${transaction.amount.toStringAsFixed(2)} - ${transaction.date.toLocal().toString().split(' ')[0]}',
                                style:
                                    TextStyle(fontSize: 14, color: amountColor),
                              ),
                            ],
                          ),
                        );
                      },
                    );
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Método para cargar las transacciones de la cuenta
  Future<List<Transaction>> _fetchTransactions() async {
    final dbHelper = DatabaseHelper();
    return await dbHelper.getTransactions(widget.account.id);
  }
}
