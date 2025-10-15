import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:intl/intl.dart';
import 'package:syncfusion_flutter_charts/charts.dart';

final visualizationTypeProvider = StateProvider<int>((ref) => 0); // 0: List, 1: Bars, 2: Circle
final timeRangeProvider = StateProvider<int>((ref) => 0); // 0: Monthly, 1: Annual, 2: Total

class AccountStatisticsScreen extends ConsumerWidget {
  final Cuenta cuenta;

  const AccountStatisticsScreen({super.key, required this.cuenta});

  Color _safeParseColor(String colorString) {
    try {
      return Color(int.parse(colorString.replaceFirst('#', '0xff')));
    } catch (e) {
      return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final visualizationType = ref.watch(visualizationTypeProvider);
    final timeRange = ref.watch(timeRangeProvider);

    final allTransaccionesStream = ref
        .watch(transaccionesDaoProvider)
        .watchDetailedTransaccionesForCuenta(cuenta.id);

    return Scaffold(
      appBar: AppBar(
        title: Text('Estadísticas de ${cuenta.nombre}'),
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
                      visualizationType == 0,
                      visualizationType == 1,
                      visualizationType == 2,
                    ],
                    onPressed: (index) {
                      ref.read(visualizationTypeProvider.notifier).state = index;
                    },
                    children: const [
                      Icon(Icons.list),
                      Icon(Icons.bar_chart),
                      Icon(Icons.pie_chart),
                    ],
                  ),
                  const SizedBox(height: 8),
                  ToggleButtons(
                    isSelected: [
                      timeRange == 0,
                      timeRange == 1,
                      timeRange == 2,
                    ],
                    onPressed: (index) {
                      ref.read(timeRangeProvider.notifier).state = index;
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
                stream: allTransaccionesStream,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error: ${snapshot.error}'));
                  }

                  final allTransactions = snapshot.data ?? [];
                  List<DetailedTransaction> filteredTransactions;

                  final now = DateTime.now();
                  if (timeRange == 0) { // Monthly
                    filteredTransactions = allTransactions.where((t) => t.transaccion.fecha.year == now.year && t.transaccion.fecha.month == now.month).toList();
                  } else if (timeRange == 1) { // Annual
                    filteredTransactions = allTransactions.where((t) => t.transaccion.fecha.year == now.year).toList();
                  } else { // Total
                    filteredTransactions = allTransactions;
                  }

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

                  if (visualizationType == 0) {
                    return _buildListView(sortedCategories, totalExpense);
                  } else {
                    return _buildChart(sortedCategories, totalExpense, visualizationType);
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildListView(List<MapEntry<Categoria, double>> sortedCategories, double totalExpense) {
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

    if (visualizationType == 1) {
      return SfCartesianChart(
        primaryXAxis: CategoryAxis(isVisible: false),
        primaryYAxis: NumericAxis(numberFormat: NumberFormat.currency(locale: 'es_ES', symbol: '€')),
        series: <CartesianSeries<_ChartData, String>>[
          BarSeries<_ChartData, String>(
            dataSource: chartData,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            pointColorMapper: (_ChartData data, _) => data.color,
            dataLabelSettings: DataLabelSettings(
              isVisible: true,
              builder: (dynamic data, dynamic point, dynamic series, int pointIndex, int seriesIndex) {
                return Text(
                  '${data.x}\n${NumberFormat.currency(locale: 'es_ES', symbol: '€').format(data.y)}',
                  style: const TextStyle(fontSize: 10),
                  textAlign: TextAlign.center,
                );
              },
            ),
          )
        ],
        isTransposed: true,
      );
    } else {
      return SfCircularChart(
        series: <CircularSeries<_ChartData, String>>[
          PieSeries<_ChartData, String>(
            dataSource: chartData,
            xValueMapper: (_ChartData data, _) => data.x,
            yValueMapper: (_ChartData data, _) => data.y,
            pointColorMapper: (_ChartData data, _) => data.color,
            dataLabelMapper: (_ChartData data, _) => '${data.x}\n${(data.y / totalExpense * 100).toStringAsFixed(1)}%',
            dataLabelSettings: const DataLabelSettings(
              isVisible: true,
              labelPosition: ChartDataLabelPosition.outside,
            ),
          )
        ],
      );
    }
  }
}

class _ChartData {
  _ChartData(this.x, this.y, this.color);

  final String x;
  final double y;
  final Color color;
}