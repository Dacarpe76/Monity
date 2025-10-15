import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/transaction_list_screen.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:monity/ui/utils/color_utils.dart';

class AccountCard extends ConsumerWidget {
  final Cuenta cuenta;
  final bool showAmounts;

  const AccountCard({super.key, required this.cuenta, required this.showAmounts});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currencyFormatter = NumberFormat.currency(
        locale: 'es_MX', symbol: '€', customPattern: '#,##0.00 ¤');
    final appSettings = ref.watch(appSettingsProvider);

    final now = DateTime.now();
    final diasDelMes = DateUtils.getDaysInMonth(now.year, now.month);
    final diaActual = now.day;

    double porcentajeProyectado = 0;
    if (cuenta.gastoAcumuladoMes > 0 &&
        diaActual > 0 &&
        cuenta.limiteGastoMensual > 0) {
      final gastoProyectado =
          (cuenta.gastoAcumuladoMes / diaActual) * diasDelMes;
      porcentajeProyectado = gastoProyectado / cuenta.limiteGastoMensual;
    }

    Color projectionColor;
    if (porcentajeProyectado > 1.0) {
      projectionColor = Colors.red.shade900;
    } else if (porcentajeProyectado >= 0.8) {
      projectionColor = Colors.blue.shade900;
    } else {
      projectionColor = Colors.green.shade900;
    }

    final double porcentajeGastado = cuenta.limiteGastoMensual > 0
        ? cuenta.gastoAcumuladoMes / cuenta.limiteGastoMensual
        : 0;

    Color budgetColor;
    if (porcentajeGastado >= 1.0) {
      budgetColor = Colors.red.shade900;
    } else if (porcentajeGastado >= 0.8) {
      budgetColor = Colors.blue.shade900;
    } else {
      budgetColor = Colors.green.shade900;
    }

    final bool isDepleted = cuenta.saldoActual <= 0;
    final bool isZero = cuenta.saldoActual == 0;
    final Color mainTextColor = isDepleted ? Colors.white : budgetColor;

    return InkWell(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => TransactionListScreen(cuenta: cuenta),
          ),
        );
      },
      child: Card(
        elevation: 0.0,
        margin: const EdgeInsets.symmetric(vertical: 8.0),
        color: isZero ? Colors.black : getGastoProgressColor(porcentajeGastado).withAlpha((255 * 0.2).round()),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: Colors.black, width: 1),
        ),
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
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                  Text(
                    showAmounts ? currencyFormatter.format(cuenta.saldoActual) : '***',
                    style: GoogleFonts.roboto(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: mainTextColor,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Visibility(
                visible: appSettings.asData?.value.showBudgetLimit ?? true,
                child: Text(
                  showAmounts ? 'Objetivo: ${currencyFormatter.format(cuenta.limiteGastoMensual)}' : 'Objetivo: ***',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: mainTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Visibility(
                visible: appSettings.asData?.value.showMaxBalance ?? true,
                child: Text(
                  showAmounts ? 'Límite: ${currencyFormatter.format(cuenta.saldoMaximoMensual)}' : 'Límite: ***',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: mainTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Visibility(
                visible: appSettings.asData?.value.showMonthlySpending ?? true,
                child: Text(
                  showAmounts ? 'Gastado mes: ${currencyFormatter.format(cuenta.gastoAcumuladoMes)}' : 'Gastado mes: ***',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.normal,
                    color: mainTextColor,
                  ),
                ),
              ),
              const SizedBox(height: 4),
              Visibility(
                visible: appSettings.asData?.value.showProjection ?? true,
                child: Text(
                  showAmounts ? 'Proyección a fin de mes: ${(porcentajeProyectado * 100).toStringAsFixed(1)}%' : 'Proyección a fin de mes: ***',
                  style: GoogleFonts.roboto(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: isDepleted ? Colors.white : projectionColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
