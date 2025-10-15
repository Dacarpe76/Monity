import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

class TransactionListScreen extends ConsumerStatefulWidget {
  final Cuenta cuenta;

  const TransactionListScreen({super.key, required this.cuenta});

  @override
  ConsumerState<TransactionListScreen> createState() =>
      _TransactionListScreenState();
}

class _TransactionListScreenState extends ConsumerState<TransactionListScreen> {
  int _visualizationType = 0; // 0: List, 1: Categories, 2: Bars, 3: Circle
  int _timeRange = 0; // 0: Monthly, 1: Annual, 2: Total

  Color _safeParseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final transaccionesStream = ref
        .watch(transaccionesDaoProvider)
        .watchDetailedTransaccionesForCuenta(widget.cuenta.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Transacciones de ${widget.cuenta.nombre}'),
        centerTitle: true,
      ),
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  ToggleButtons(
                    isSelected: [
                      _visualizationType == 0,
                      _visualizationType == 1,
                      _visualizationType == 2,
                      _visualizationType == 3,
                    ],
                    onPressed: (index) {
                      setState(() {
                        _visualizationType = index;
                      });
                    },
                    children: const [
                      Icon(Icons.list),
                      Icon(Icons.category),
                      Icon(Icons.bar_chart),
                      Icon(Icons.pie_chart),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ToggleButtons(
                    isSelected: [
                      _timeRange == 0,
                      _timeRange == 1,
                      _timeRange == 2,
                    ],
                    onPressed: (index) {
                      setState(() {
                        _timeRange = index;
                      });
                    },
                    children: const [
                      Text('Mensual'),
                      Text('Anual'),
                      Text('Total'),
                    ],
                  ),
                ],
              ),
            ),
            Expanded(
              child: StreamBuilder<List<DetailedTransaction>>(
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

                  final allTransactions = snapshot.data!;
                  List<DetailedTransaction> filteredTransactions;

                  final now = DateTime.now();
                  if (_timeRange == 0) { // Monthly
                    filteredTransactions = allTransactions
                        .where((t) =>
                            t.transaccion.fecha.year == now.year &&
                            t.transaccion.fecha.month == now.month)
                        .toList();
                  } else if (_timeRange == 1) { // Annual
                    filteredTransactions = allTransactions
                        .where((t) => t.transaccion.fecha.year == now.year)
                        .toList();
                  } else { // Total
                    filteredTransactions = allTransactions;
                  }

                  if (_visualizationType == 0) {
                    return _buildTransactionList(filteredTransactions);
                  } else {
                    return _buildStatisticsView(filteredTransactions);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTransactionList(List<DetailedTransaction> transacciones) {
    // Sort transactions by date in descending order
    transacciones.sort(
        (a, b) => b.transaccion.fecha.compareTo(a.transaccion.fecha));

    // Calculate running balances
    final balances = <double>[];
    var runningBalance = widget.cuenta.saldoActual;
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
            padding: const EdgeInsets.only(bottom: 16),
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
  }

  Widget _buildStatisticsView(List<DetailedTransaction> filteredTransactions) {
    final expenses = filteredTransactions
        .where((t) => t.transaccion.tipo == TipoTransaccion.gasto)
        .toList();

    if (expenses.isEmpty) {
      return const Center(
        child: Text('No hay gastos para esta cuenta en el período seleccionado.'),
      );
    }

    final Map<Categoria, double> categoryExpenses = {};
    for (var expense in expenses) {
      if (expense.categoria != null) {
        final categoria = expense.categoria!;
        final amount = expense.transaccion.cantidad.abs();
        categoryExpenses.update(categoria, (value) => value + amount,
            ifAbsent: () => amount);
      }
    }

    if (categoryExpenses.isEmpty) {
      return const Center(
        child: Text('No hay gastos categorizados para esta cuenta en el período seleccionado.'),
      );
    }

    final totalExpense = categoryExpenses.values.fold(0.0, (prev, amount) => prev + amount);

    final sortedCategories = categoryExpenses.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    if (_visualizationType == 1) {
      return _buildCategoryListView(sortedCategories, totalExpense);
    } else {
      return _buildChart(sortedCategories, totalExpense, _visualizationType);
    }
  }

  Widget _buildCategoryListView(List<MapEntry<Categoria, double>> sortedCategories, double totalExpense) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Row(
            children: const [
              Expanded(
                flex: 3,
                child: Text("Categoría", style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("Total", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Expanded(
                flex: 2,
                child: Text("%", textAlign: TextAlign.right, style: TextStyle(fontWeight: FontWeight.bold)),
              ),
            ],
          ),
        ),
        const Divider(height: 1),
        Expanded(
          child: ListView.separated(
            padding: const EdgeInsets.only(bottom: 16),
            itemCount: sortedCategories.length,
            separatorBuilder: (context, index) => const Divider(height: 1),
            itemBuilder: (context, index) {
              final entry = sortedCategories[index];
              final categoria = entry.key;
              final amount = entry.value;
              final percentage = totalExpense > 0 ? (amount / totalExpense) * 100 : 0.0;

              final color = _safeParseColor(categoria.color);
              final formattedAmount = NumberFormat.currency(locale: 'es_ES', symbol: '€').format(amount);
              final formattedPercentage = '${percentage.toStringAsFixed(1)}%';

              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
                child: Row(
                  children: [
                    Expanded(
                      flex: 3,
                      child: Text(
                        categoria.nombre,
                        style: TextStyle(color: color, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        formattedAmount,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: color, fontWeight: FontWeight.bold),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Text(
                        formattedPercentage,
                        textAlign: TextAlign.right,
                        style: TextStyle(color: color, fontWeight: FontWeight.bold),
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
  }

  Widget _buildChart(List<MapEntry<Categoria, double>> sortedCategories, double totalExpense, int visualizationType) {
    final List<_ChartData> chartData = sortedCategories
        .map((entry) => _ChartData(entry.key.nombre, entry.value, _safeParseColor(entry.key.color)))
        .toList();

    if (visualizationType == 2) {
      return Column(
        children: [
          Expanded(
            child: SfCartesianChart(
              primaryXAxis: CategoryAxis(isVisible: false),
              primaryYAxis: NumericAxis(numberFormat: NumberFormat.currency(locale: 'es_ES', symbol: '€')),
              series: <CartesianSeries<_ChartData, String>>[
                BarSeries<_ChartData, String>(
                  dataSource: chartData,
                  xValueMapper: (_ChartData data, _) => data.x,
                  yValueMapper: (_ChartData data, _) => data.y,
                  pointColorMapper: (_ChartData data, _) => data.color,
                  dataLabelSettings: const DataLabelSettings(
                    isVisible: false,
                  ),
                )
              ],
              isTransposed: true,
            ),
          ),
          _buildChartLegend(sortedCategories, totalExpense),
        ],
      );
    } else {
      return Column(
        children: [
          Expanded(
            child: Center(
              child: FractionallySizedBox(
                heightFactor: 0.75,
                widthFactor: 0.75,
                child: SfCircularChart(
                  series: <CircularSeries<_ChartData, String>>[
                    PieSeries<_ChartData, String>(
                      dataSource: chartData,
                      xValueMapper: (_ChartData data, _) => data.x,
                      yValueMapper: (_ChartData data, _) => data.y,
                      pointColorMapper: (_ChartData data, _) => data.color,
                      dataLabelSettings: const DataLabelSettings(
                        isVisible: false,
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
          _buildChartLegend(sortedCategories, totalExpense),
        ],
      );
    }
  }

  Widget _buildChartLegend(List<MapEntry<Categoria, double>> sortedCategories, double totalExpense) {
    return SizedBox(
      height: 150, // Adjust height as needed
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 16.0).copyWith(bottom: 16),
        children: sortedCategories.map((entry) {
          final categoria = entry.key;
          final amount = entry.value;
          final percentage = totalExpense > 0 ? (amount / totalExpense) * 100 : 0.0;
          final color = _safeParseColor(categoria.color);
          final formattedAmount = NumberFormat.currency(locale: 'es_ES', symbol: '€').format(amount);

          return Padding(
            padding: const EdgeInsets.symmetric(vertical: 4.0),
            child: Row(
              children: [
                Container(
                  width: 16,
                  height: 16,
                  color: color,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    categoria.nombre,
                    style: TextStyle(color: color, fontWeight: FontWeight.bold),
                  ),
                ),
                Text(
                  '$formattedAmount (${percentage.toStringAsFixed(1)}%)',
                  style: TextStyle(color: color, fontWeight: FontWeight.bold),
                ),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}
