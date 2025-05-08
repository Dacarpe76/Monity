import 'package:flutter/material.dart';
import '../models/account.dart';
import '../services/database_helper.dart';

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback onTap;

  const AccountCard({
    super.key,
    required this.account,
    required this.onTap,
  });

  // Método para calcular el color del saldo según el porcentaje de gasto mensual
  Future<Color> getBalanceColor(String accountId, double limitSpend) async {
    if (limitSpend == 0) return Colors.green; // Evitar división por cero.

    final dbHelper = DatabaseHelper();
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    // Obtener transacciones del mes actual para la cuenta específica.
    final transactionsBox = await dbHelper.transactionsBox;
    final transactions = transactionsBox.values.where((transaction) =>
        transaction.accountId == accountId &&
        !transaction.isIncome && // Solo considerar gastos.
        transaction.date.isAfter(firstDayOfMonth) &&
        transaction.date.isBefore(lastDayOfMonth));

    // Calcular el gasto acumulado del mes.
    final monthlySpent =
        transactions.fold(0.0, (sum, transaction) => sum + transaction.amount);

    // Calcular el porcentaje del gasto acumulado.
    final percentage = (monthlySpent / limitSpend) * 100;

    if (percentage < 90) {
      return Colors.green; // Verde si el gasto es inferior al 90%.
    } else if (percentage < 99) {
      return Colors.blue; // Azul si el gasto está entre el 90% y el 99%.
    } else {
      return Colors.red; // Rojo si el gasto es igual o superior al 100%.
    }
  }

  // Método para calcular el porcentaje de gasto mensual
  Future<String> getMonthlySpentPercentage(
      String accountId, double limitSpend) async {
    if (limitSpend == 0) return "(0%)"; // Evitar división por cero.

    final dbHelper = DatabaseHelper();
    final now = DateTime.now();
    final firstDayOfMonth = DateTime(now.year, now.month, 1);
    final lastDayOfMonth = DateTime(now.year, now.month + 1, 0);

    // Obtener transacciones del mes actual para la cuenta específica.
    final transactionsBox = await dbHelper.transactionsBox;
    final transactions = transactionsBox.values.where((transaction) =>
        transaction.accountId == accountId &&
        !transaction.isIncome && // Solo considerar gastos.
        transaction.date.isAfter(firstDayOfMonth) &&
        transaction.date.isBefore(lastDayOfMonth));

    // Calcular el gasto acumulado del mes.
    final monthlySpent =
        transactions.fold(0.0, (sum, transaction) => sum + transaction.amount);

    // Calcular el porcentaje del gasto acumulado.
    final percentage = (monthlySpent / limitSpend) * 100;

    return "(${percentage.toStringAsFixed(0)}%)";
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Color>(
      future: getBalanceColor(
          account.id, account.limitSpend), // Usar limitSpend aquí.
      builder: (context, colorSnapshot) {
        return FutureBuilder<String>(
          future: getMonthlySpentPercentage(
              account.id, account.limitSpend), // Usar limitSpend aquí.
          builder: (context, percentageSnapshot) {
            if (colorSnapshot.connectionState == ConnectionState.waiting ||
                percentageSnapshot.connectionState == ConnectionState.waiting) {
              return const Card(
                child: ListTile(
                  title: Text("Cargando..."),
                ),
              );
            } else if (colorSnapshot.hasError || percentageSnapshot.hasError) {
              return Card(
                child: ListTile(
                  title: Text(
                      "Error: ${colorSnapshot.error ?? percentageSnapshot.error}"),
                ),
              );
            } else {
              final balanceColor = colorSnapshot.data ?? Colors.green;
              final monthlySpentPercentage = percentageSnapshot.data ?? "(0%)";

              return Card(
                margin: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: onTap,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Nombre de la cuenta
                        Text(
                          account.name,
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),

                        // Saldo con color dinámico y porcentaje de gasto
                        Text(
                          '\$${account.balance.toStringAsFixed(2)} $monthlySpentPercentage',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                            color: balanceColor,
                          ),
                        ),

                        // Espacio reservado para la gráfica (imagen temporal)
                        Image.asset(
                          'assets/screens/donut.jpg', // Ruta de la imagen.
                          width: 50, // Ancho de la imagen.
                          height: 50, // Alto de la imagen.
                          fit: BoxFit.cover, // Ajustar la imagen al contenedor.
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }
          },
        );
      },
    );
  }
}
