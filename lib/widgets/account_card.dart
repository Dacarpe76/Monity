import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:monity/models/account.dart';
import 'package:monity/providers/currency_provider.dart';
import 'package:provider/provider.dart';
import '../screens/add_edit_account_screen.dart'; // Importar la nueva pantalla

class AccountCard extends StatelessWidget {
  final Account account;
  final VoidCallback? onTap;

  const AccountCard({super.key, required this.account, this.onTap});

  @override
  Widget build(BuildContext context) {
    final currencyProvider = Provider.of<CurrencyProvider>(context);
    final NumberFormat currencyFormat = currencyProvider.currencyFormat;

    Color balanceColor;
    final now = DateTime.now();

    // Nueva lógica de color basada en el límite de gasto mensual (account.limitSpend)
    // y las transacciones dentro de la cuenta.
    if (account.limitSpend > 0) {
      // Solo aplicar si hay un límite de gasto positivo definido
      double monthlySpending = account.getMonthlySpending(now.month, now.year);

      if (monthlySpending > account.limitSpend) {
        balanceColor = Colors.red; // Gasto > 100% del límite
      } else if (monthlySpending >= account.limitSpend * 0.8) {
        balanceColor = Colors.blue; // 80% <= Gasto <= 100% del límite
      } else {
        balanceColor = Colors.green; // Gasto < 80% del límite
      }
    } else {
      // Lógica de color de fallback si no hay límite de gasto mensual definido
      // o si es cero o negativo.
      if (account.balance < 0) {
        balanceColor = Colors.red.shade700; // Saldo negativo
      } else {
        balanceColor = Colors
            .green; // Saldo positivo o cero (o usa Colors.black para neutro)
      }
    }

    return Card(
      elevation: 2.0,
      margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
      ),
      child: InkWell(
        onTap: onTap ??
            () {
              // Si onTap es null (no se proporciona desde HomeScreen), navega a editar
              Navigator.of(context)
                  .push(
                MaterialPageRoute(
                  builder: (context) => AddEditAccountScreen(account: account),
                ),
              )
                  .then((result) {
                // Aquí podrías refrescar la lista de cuentas si 'result' es true
                // y si no estás usando un ValueListenableBuilder que lo haga automáticamente.
                // Por ejemplo, si usas Provider, podrías llamar a un método de tu provider.
                if (result == true) {
                  // Opcional: forzar un refresco si es necesario, aunque con Hive y ValueListenableBuilder
                  // a menudo no se requiere.
                }
              });
            },
        borderRadius: BorderRadius.circular(10.0),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                account.name,
                style: const TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                ),
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 8.0),
              Text(
                currencyFormat.format(account.balance),
                style: TextStyle(
                  fontSize: 22.0,
                  fontWeight: FontWeight.w600,
                  color: balanceColor, // Color del saldo dinámico
                ),
              ),
              if (account.limitSpend > 0) ...[
                const SizedBox(height: 8.0),
                Text(
                  'Límite gasto: ${currencyFormat.format(account.limitSpend)}',
                  style: TextStyle(
                    fontSize: 12.0,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
