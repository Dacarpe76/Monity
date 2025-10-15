import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:intl/intl.dart';
import 'package:monity/ui/screens/add_scheduled_transaction_screen.dart';

class ScheduledTransactionsScreen extends ConsumerWidget {
  const ScheduledTransactionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final scheduledTransactionsStream = ref
        .watch(transaccionesProgramadasDaoProvider)
        .watchAllTransaccionesProgramadas();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Transacciones Programadas'),
      ),
      body: StreamBuilder<List<TransaccionProgramada>>(
        stream: scheduledTransactionsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
                child: Text('No hay transacciones programadas.'));
          }

          final transactions = snapshot.data!;
          return ListView.builder(
            itemCount: transactions.length,
            itemBuilder: (context, index) {
              final transaction = transactions[index];
              return ListTile(
                title: Text(transaction.descripcion),
                subtitle: Text(
                    '${transaction.cantidad.toStringAsFixed(2)}€ - ${transaction.frecuencia.toString().split('.').last} - Próxima: ${DateFormat.yMd().format(transaction.proximaEjecucion)}'),
                trailing: IconButton(
                  icon: const Icon(Icons.delete, color: Colors.red),
                  onPressed: () => _showDeleteConfirmationDialog(
                      context, ref, transaction.id),
                ),
                onTap: () {},
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
                builder: (context) => const AddScheduledTransactionScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Future<void> _showDeleteConfirmationDialog(
      BuildContext context, WidgetRef ref, int transactionId) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext dialogContext) {
        return AlertDialog(
          title: const Text('Confirmar eliminación'),
          content: const Text(
              '¿Estás seguro de que quieres eliminar esta transacción programada?'),
          actions: <Widget>[
            TextButton(
              child: const Text('Cancelar'),
              onPressed: () {
                Navigator.of(dialogContext).pop();
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                foregroundColor: Theme.of(context).colorScheme.error,
              ),
              child: const Text('Eliminar'),
              onPressed: () {
                ref
                    .read(transaccionesProgramadasDaoProvider)
                    .deleteTransaccionProgramada(transactionId);
                Navigator.of(dialogContext).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
