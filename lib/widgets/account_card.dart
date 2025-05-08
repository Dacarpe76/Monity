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

    Color
        balanceDisplayColor; // Color para el texto del saldo (basado en gasto actual)
    Color projectionColor; // Color para la barra de proyección

    final now = DateTime.now();
    double monthlySpendingSoFar =
        account.getMonthlySpending(now.month, now.year);
    double projectedSpending = 0;

    if (account.limitSpend > 0) {
      final daysInMonth = DateUtils.getDaysInMonth(now.year, now.month);
      final currentDayOfMonth = now.day;

      if (currentDayOfMonth > 0 && monthlySpendingSoFar > 0) {
        double averageDailySpending = monthlySpendingSoFar / currentDayOfMonth;
        projectedSpending = averageDailySpending * daysInMonth;
      } else if (monthlySpendingSoFar > 0 && currentDayOfMonth == 0) {
        projectedSpending = monthlySpendingSoFar * daysInMonth;
      }
    }

    // Nueva lógica de color basada en el límite de gasto mensual (account.limitSpend)

    if (account.limitSpend > 0) {
      if (monthlySpendingSoFar > account.limitSpend) {
        balanceDisplayColor = Colors.red;
      } else if (monthlySpendingSoFar >= account.limitSpend * 0.8) {
        balanceDisplayColor = Colors.blue;
      } else {
        balanceDisplayColor = Colors.green;
      }
    } else {
      // Lógica de color de fallback si no hay límite de gasto mensual definido
      // o si es cero o negativo.
      if (account.balance < 0) {
        balanceDisplayColor = Colors.red.shade700; // Saldo negativo
      } else {
        balanceDisplayColor = Colors
            .green; // Saldo positivo o cero (o usa Colors.black para neutro)
      }
    }
    // Lógica de color para la BARRA DE PROYECCIÓN (basado en gasto PROYECTADO)
    if (account.limitSpend > 0) {
      if (projectedSpending > account.monthlyLimit &&
          account.monthlyLimit > 0) {
        // Asumiendo monthlyLimit es el límite de ingreso
        projectionColor = Colors.red; // Proyección supera el límite de ingreso
      } else if (projectedSpending > account.limitSpend) {
        projectionColor = Colors
            .orange; // Proyección supera el límite de gasto pero no el de ingreso
      } else if (projectedSpending >= account.limitSpend * 0.8) {
        projectionColor =
            Colors.blue; // Proyección entre 80% y 100% del límite de gasto
      } else {
        projectionColor =
            Colors.green; // Proyección por debajo del 80% del límite de gasto
      }
    } else {
      projectionColor =
          Colors.grey; // Color por defecto si no hay límite de gasto
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
        child: Container(
          // Cambiado de Padding a Container para poder usar CrossAxisAlignment.stretch en la Column
          padding: const EdgeInsets.all(16.0),
          child: Column(
            // Columna principal para Nombre+Saldo y luego la gráfica
            crossAxisAlignment: CrossAxisAlignment
                .stretch, // Para que la barra de progreso ocupe el ancho
            children: [
              Row(
                // Fila para el nombre y el saldo
                mainAxisAlignment: MainAxisAlignment
                    .spaceBetween, // Espacio entre nombre y saldo
                crossAxisAlignment: CrossAxisAlignment
                    .start, // Alinear arriba si los textos tienen alturas diferentes
                children: <Widget>[
                  Expanded(
                    // Para que el nombre no desborde si es muy largo
                    child: Text(
                      account.name,
                      style: const TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow
                          .ellipsis, // Añadir elipsis si el nombre es muy largo
                    ),
                  ),
                  const SizedBox(
                      width: 8), // Pequeño espacio entre nombre y saldo
                  Text(
                    currencyFormat.format(account.balance),
                    style: TextStyle(
                      fontSize: 18.0, // Ajustar tamaño si es necesario
                      fontWeight: FontWeight.w600,
                      color: balanceDisplayColor, // Color del saldo dinámico
                    ),
                  ),
                ],
              ),
              const SizedBox(
                  height: 12.0), // Espacio antes de la gráfica de tendencia

              // Gráfica de tendencia (personalizada)
              if (account.limitSpend > 0) ...[
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Mostrar el gasto acumulado
                    Text(
                      'Gasto actual: ${currencyFormat.format(monthlySpendingSoFar)}',
                      style: TextStyle(fontSize: 11.0, color: Colors.grey[700]),
                    ),
                    const SizedBox(height: 4.0),
                    LayoutBuilder(
                      // Usamos LayoutBuilder para obtener el ancho disponible para la barra
                      builder: (context, constraints) {
                        double maxWidth = constraints.maxWidth;
                        // El "universo" de la barra será el mayor entre limitSpend y monthlyLimit, o la proyección si es aún mayor
                        double barUniverse = account.monthlyLimit > 0
                            ? account.monthlyLimit
                            : account.limitSpend;

                        if (barUniverse == 0) {
                          barUniverse =
                              1; // Evitar división por cero si todos los límites son 0
                        }
                        if (projectedSpending > barUniverse) {
                          // Mover esta condición después de la inicialización de barUniverse
                          barUniverse = projectedSpending;
                        }
                        double spendingWidth =
                            (monthlySpendingSoFar / barUniverse * maxWidth)
                                .clamp(0, maxWidth);
                        double limitSpendMarkerPos =
                            (account.limitSpend / barUniverse * maxWidth)
                                .clamp(0, maxWidth);
                        double monthlyLimitMarkerPos =
                            (account.monthlyLimit / barUniverse * maxWidth)
                                .clamp(0, maxWidth);

                        return SizedBox(
                          height: 20, // Altura de la barra gráfica
                          child: Stack(
                            children: [
                              // Barra de fondo
                              Container(
                                decoration: BoxDecoration(
                                  color: projectionColor.withAlpha((255 * 0.3)
                                      .round()), // Usar projectionColor con opacidad para el fondo
                                  // Si projectionColor es Colors.grey, esto lo hará un gris más claro.
                                  // Si es verde, azul, etc., será un tono pastel de ese color.
                                  borderRadius: BorderRadius.circular(5),
                                ),
                              ),
                              // Barra de gasto actual (coloreada por proyección)
                              Positioned(
                                left: 0,
                                top: 0,
                                bottom: 0,
                                child: Container(
                                  width: spendingWidth,
                                  decoration: BoxDecoration(
                                    color: HSLColor.fromColor(projectionColor)
                                        .withLightness(
                                            (HSLColor.fromColor(projectionColor)
                                                        .lightness -
                                                    0.2)
                                                .clamp(0.0, 1.0))
                                        .toColor(),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                ),
                              ),
                              // Marcador para Límite de Gasto
                              if (account.limitSpend > 0 &&
                                  limitSpendMarkerPos <= maxWidth &&
                                  limitSpendMarkerPos > 0)
                                Positioned(
                                  left: limitSpendMarkerPos -
                                      1, // -1 para centrar el marcador de 2px
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                      width: 2, color: Colors.black54),
                                ),
                              // Marcador para Límite de Ingreso (monthlyLimit)
                              if (account.monthlyLimit > 0 &&
                                  monthlyLimitMarkerPos <= maxWidth &&
                                  monthlyLimitMarkerPos > 0)
                                Positioned(
                                  left: monthlyLimitMarkerPos -
                                      1, // -1 para centrar el marcador de 2px
                                  top: 0,
                                  bottom: 0,
                                  child: Container(
                                      width: 2, color: Colors.purpleAccent),
                                ),
                            ],
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ] else ...[
                // Este else corresponde al if (account.limitSpend > 0)
                const Text(
                  'No hay límite de gasto mensual definido.',
                  style: TextStyle(
                      fontSize: 12.0,
                      color: Colors.grey,
                      fontStyle: FontStyle.italic),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
