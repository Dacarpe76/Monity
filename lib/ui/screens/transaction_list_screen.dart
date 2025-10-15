import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:monity/ui/screens/account_statistics_screen.dart';

class TransactionListScreen extends ConsumerWidget {
  final Cuenta cuenta;

  const TransactionListScreen({super.key, required this.cuenta});

  Color _safeParseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final transaccionesStream = ref
        .watch(transaccionesDaoProvider)
        .watchDetailedTransaccionesForCuenta(cuenta.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transacciones de ${cuenta.nombre}'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.bar_chart),
            onPressed: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => AccountStatisticsScreen(cuenta: cuenta),
                ),
              );
            },
          ),
        ],
      ),
      body: StreamBuilder<List<DetailedTransaction>>(
        stream: transaccionesStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(
              child: Text('No hay transacciones para esta cuenta.'),
            );
          }

          final transacciones = snapshot.data!;
          // Sort transactions by date in descending order
          transacciones.sort(
              (a, b) => b.transaccion.fecha.compareTo(a.transaccion.fecha));

          // Calculate running balances
          final balances = <double>[];
          var runningBalance = cuenta.saldoActual;
          for (final t in transacciones) {
            balances.add(runningBalance);
            runningBalance -= t.transaccion.cantidad;
          }

          return Column(
            children: [
              // Header
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Expanded(
                        flex: 2,
                        child: Text('Fecha',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(
                        flex: 3,
                        child: Text('Concepto',
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(
                        flex: 2,
                        child: Text('Cantidad',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const Expanded(
                        flex: 2,
                        child: Text('Saldo',
                            textAlign: TextAlign.right,
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    const SizedBox(width: 48), // For delete icon spacing
                  ],
                ),
              ),
              const Divider(height: 1),
              // List
              Expanded(
                child: ListView.separated(
                  itemCount: transacciones.length,
                  separatorBuilder: (context, index) => const Divider(height: 1),
                  itemBuilder: (context, index) {
                    final detailedTransaccion = transacciones[index];
                    final transaccion = detailedTransaccion.transaccion;
                    final gasto = detailedTransaccion.gasto;
                    final categoria = detailedTransaccion.categoria;
                    final saldo = balances[index];

                    final formattedDate =
                        DateFormat('dd/MM/yy').format(transaccion.fecha);
                    final formattedAmount = NumberFormat.currency(
                            locale: 'es_ES', symbol: '€')
                        .format(transaccion.cantidad);
                    final formattedSaldo =
                        NumberFormat.currency(locale: 'es_ES', symbol: '€')
                            .format(saldo);

                    String concepto = 'Transacción';
                    if (transaccion.tipo == TipoTransaccion.gasto) {
                      concepto = gasto?.concepto ?? categoria?.nombre ?? 'Gasto';
                    } else if (transaccion.tipo == TipoTransaccion.ingreso) {
                      concepto = categoria?.nombre ?? 'Ingreso';
                    } else if (transaccion.tipo ==
                        TipoTransaccion.transferencia) {
                      concepto = 'Transferencia';
                    }

                    final color = categoria != null ? _safeParseColor(categoria.color) : null;

                    return Padding(
                      padding: const EdgeInsets.fromLTRB(16, 8, 8, 8),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(flex: 2, child: Text(formattedDate, style: TextStyle(color: color))),
                          Expanded(
                              flex: 3,
                              child: Text(concepto,
                                  overflow: TextOverflow.ellipsis, style: TextStyle(color: color))),
                          Expanded(
                            flex: 2,
                            child: Text(
                              formattedAmount,
                              textAlign: TextAlign.right,
                              style: TextStyle(
                                color: transaccion.cantidad < 0
                                    ? Colors.red
                                    : Colors.green,
                              ),
                            ),
                          ),
                          Expanded(
                              flex: 2,
                              child: Text(formattedSaldo,
                                  textAlign: TextAlign.right)),
                          SizedBox(
                            width: 48,
                            child: IconButton(
                              icon: const Icon(Icons.delete, color: Colors.grey),
                              onPressed: () {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Eliminar Transacción'),
                                    content: const Text(
                                        '¿Estás seguro de que quieres eliminar esta transacción?'),
                                    actions: [
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(context).pop(),
                                        child: const Text('Cancelar'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          ref
                                              .read(transaccionesDaoProvider)
                                              .deleteTransaccion(transaccion.id);
                                          Navigator.of(context).pop();
                                        },
                                        child: const Text('Eliminar'),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
