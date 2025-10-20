import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:monity/widgets/custom_dialogs.dart';

class BudgetsScreen extends ConsumerWidget {
  const BudgetsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final cuentas = ref.watch(cuentasProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Límites de Gasto por Cuenta'),
      ),
      body: cuentas.when(
        data: (data) {
          if (data.isEmpty) {
            return const Center(
              child: Text('No hay cuentas para mostrar.'),
            );
          }
          return ListView.builder(
            itemCount: data.length,
            itemBuilder: (context, index) {
              final cuenta = data[index];
              return AccountBudgetCard(cuenta: cuenta);
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (err, stack) => Center(child: Text('Error: $err')),
      ),
    );
  }
}

class AccountBudgetCard extends ConsumerWidget {
  final Cuenta cuenta;

  const AccountBudgetCard({super.key, required this.cuenta});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ratio = cuenta.limiteGastoMensual > 0
        ? cuenta.gastoAcumuladoMes / cuenta.limiteGastoMensual
        : 0;

    return Card(
      margin: const EdgeInsets.all(8.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  cuenta.nombre,
                  style: Theme.of(context).textTheme.headlineSmall,
                ),
                IconButton(
                  icon: const Icon(Icons.edit),
                  onPressed: () =>
                      _showEditLimitDialog(context, ref, cuenta),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Text(
              'Límite de Gasto Mensual: ${cuenta.limiteGastoMensual.toStringAsFixed(2)} €',
            ),
            const SizedBox(height: 8),
            Text(
              'Gasto Acumulado del Mes: ${cuenta.gastoAcumuladoMes.toStringAsFixed(2)} €',
            ),
            const SizedBox(height: 16),
            LinearProgressIndicator(
              value: ratio.clamp(0, 1).toDouble(),
              minHeight: 10,
            ),
            const SizedBox(height: 8),
            Text('${(ratio * 100).toStringAsFixed(1)}% del límite gastado'),
          ],
        ),
      ),
    );
  }

  void _showEditLimitDialog(
      BuildContext context, WidgetRef ref, Cuenta cuenta) {
    final TextEditingController controller =
        TextEditingController(text: cuenta.limiteGastoMensual.toString());

    showDialog(
      context: context,
      builder: (context) {
        return CustomAlertDialog(
          title: 'Editar Límite de Gasto',
          content: TextField(
            controller: controller,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            decoration: const InputDecoration(
              labelText: 'Nuevo límite',
              prefixText: '€',
            ),
          ),
          actions: [
            TextButton(
              child: const Text('Cancelar',
                  style: TextStyle(color: Colors.white70)),
              onPressed: () => Navigator.of(context).pop(),
            ),
            TextButton(
              child: const Text('Guardar'),
              onPressed: () {
                final newLimit =
                    double.tryParse(controller.text.replaceAll(',', '.'));
                if (newLimit != null && newLimit >= 0) {
                  final database = ref.read(databaseProvider);
                  final updatedCuenta = cuenta.copyWith(limiteGastoMensual: newLimit);
                  database.cuentasDao
                      .upsertCuenta(updatedCuenta.toCompanion(true));
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }
}