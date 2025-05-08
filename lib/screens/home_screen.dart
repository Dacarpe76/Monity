// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../widgets/account_card.dart';
import '../screens/add_transaction_screen.dart';
import '../screens/account_detail.dart';
import '../services/database_helper.dart';
import '../models/account.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final DatabaseHelper dbHelper = DatabaseHelper();

  // Método para mostrar un diálogo de confirmación antes de vaciar las transacciones
  Future<void> _showClearTransactionsDialog() async {
    return showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Vaciar Transacciones'),
        content: const Text(
            '¿Estás seguro de que deseas eliminar todas las transacciones? Esta acción no se puede deshacer.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context), // Cancelar
            child: const Text('Cancelar'),
          ),
          ElevatedButton(
            onPressed: () async {
              await dbHelper.clearAllTransactions(); // Vaciar transacciones
              if (!mounted) return; // Verificar si el widget está montado
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                    content:
                        Text('Todas las transacciones han sido eliminadas')),
              );
              // Verificar mounted antes de usar context después de un await
              if (!mounted) return;
              Navigator.pop(context); // Cerrar el diálogo
            },
            child: const Text('Aceptar'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Monity'),
      ),
      body: ValueListenableBuilder<Box<Account>>(
        valueListenable: Hive.box<Account>('accounts').listenable(),
        builder: (context, box, _) {
          final accounts = box.values.toList();
          if (accounts.isEmpty) {
            return const Center(child: Text('No hay cuentas disponibles.'));
          }
          return ListView.builder(
            itemCount: accounts.length,
            itemBuilder: (context, index) {
              final account = accounts[index];
              return AccountCard(
                account: account,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          AccountDetailScreen(account: account),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
            onPressed: () async {
              final accounts = await dbHelper.getAccountsOrdered();
              if (accounts.isNotEmpty) {
                if (!mounted) return;
                final firstAccount = accounts.first;
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        AddTransactionScreen(account: firstAccount),
                  ),
                );
              }
            },
            child: const Icon(Icons.add),
          ),
          const SizedBox(height: 16), // Espacio entre los botones
          FloatingActionButton(
            onPressed:
                _showClearTransactionsDialog, // Mostrar diálogo de confirmación
            backgroundColor: Colors.red, // Color rojo para indicar peligro
            child: const Icon(Icons.delete_forever),
          ),
        ],
      ),
    );
  }
}
