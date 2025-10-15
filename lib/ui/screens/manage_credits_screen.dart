import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/ui/screens/add_credit_screen.dart';

class ManageCreditsScreen extends ConsumerWidget {
  const ManageCreditsScreen({super.key});

  // Eliminada la lógica de aportación extra

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final db = ref.watch(databaseProvider);

    Future<void> deleteCredit(int id) async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Eliminar crédito'),
          content: const Text(
              '¿Seguro que quieres eliminar este crédito? Esta acción no se puede deshacer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('Cancelar'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child:
                  const Text('Eliminar', style: TextStyle(color: Colors.red)),
            ),
          ],
        ),
      );
      if (confirm == true) {
        await db.creditosDao.deleteCredito(id);
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Gestionar Créditos'),
      ),
      body: StreamBuilder<List<Credito>>(
        stream: db.creditosDao.watchAllCreditos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final creditos = snapshot.data ?? [];

          if (creditos.isEmpty) {
            return const Center(
              child: Text('No tienes créditos añadidos.'),
            );
          }

          return ListView.builder(
            itemCount: creditos.length,
            itemBuilder: (context, index) {
              final credito = creditos[index];
              return ListTile(
                title: Text(credito.name),
                subtitle: Text(
                    'Plazo: ${credito.plazoEnMeses} meses - Pendiente: ${credito.remainingAmount.toStringAsFixed(2)} €'),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.delete),
                      tooltip: 'Eliminar',
                      onPressed: () => deleteCredit(credito.id),
                    ),
                    IconButton(
                      icon: const Icon(Icons.edit),
                      tooltip: 'Editar',
                      onPressed: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) =>
                                AddCreditScreen(credit: credito),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(builder: (context) => const AddCreditScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
