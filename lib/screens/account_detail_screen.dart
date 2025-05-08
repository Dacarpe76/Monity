import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/database_helper.dart';
import '../models/transaction.dart'; // Asegúrate de que esta línea esté presente.
import '../screens/add_transaction_screen.dart'; // Importa AddTransactionScreen.

class AccountDetailScreen extends StatelessWidget {
  final Account account;

  const AccountDetailScreen({super.key, required this.account});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(account.name),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Saldo: \$${account.balance.toStringAsFixed(2)}'),
            Text(
                'Límite mensual: \$${account.monthlyLimit.toStringAsFixed(2)}'),
            const SizedBox(height: 16),
            const Text('Movimientos:'),
            Expanded(
              child: FutureBuilder<List<Transaction>>(
                future: DatabaseHelper().getTransactions(account.id),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (!snapshot.hasData || snapshot.data!.isEmpty) {
                    return const Center(child: Text('No hay movimientos.'));
                  }
                  final transactions = snapshot.data!;
                  return ListView.builder(
                    itemCount: transactions.length,
                    itemBuilder: (context, index) {
                      final transaction = transactions[index];
                      return ListTile(
                        title: Text(
                            '${transaction.category}: \$${transaction.amount.toStringAsFixed(2)}'),
                        subtitle: Text(transaction.description),
                        trailing: Text(transaction.date
                            .toLocal()
                            .toString()
                            .split(' ')[0]),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final dbHelper = DatabaseHelper();
          final accounts = await dbHelper.getAccountsOrdered();
          if (accounts.isNotEmpty) {
            if (context.mounted) {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AddTransactionScreen(
                      account: account), // Preseleccionar la cuenta.
                ),
              );
            }
          }
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
