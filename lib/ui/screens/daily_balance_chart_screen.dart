import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:monity/data/database.dart';
import 'package:monity/providers.dart';
import 'package:syncfusion_flutter_charts/charts.dart';
import 'package:intl/intl.dart';

class DailyBalanceChartScreen extends ConsumerWidget {
  final Cuenta? cuenta;

  const DailyBalanceChartScreen({super.key, this.cuenta});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final title = cuenta == null ? 'Saldo diario total' : 'Saldo diario de ${cuenta!.nombre}';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        centerTitle: true,
      ),
      body: SafeArea(
        child: cuenta == null
            ? _buildTotalChart(ref)
            : _buildAccountChart(ref, cuenta!),
      ),
    );
  }

  Widget _buildTotalChart(WidgetRef ref) {
    final allTransaccionesStream = ref.watch(transaccionesDaoProvider).watchAllDetailedTransacciones();
    final allCuentasStream = ref.watch(cuentasDaoProvider).watchAllCuentas();

    return StreamBuilder<List<Cuenta>>(
      stream: allCuentasStream,
      builder: (context, cuentasSnapshot) {
        if (cuentasSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (cuentasSnapshot.hasError) {
          return Center(child: Text('Error: ${cuentasSnapshot.error}'));
        }
        final allCuentas = cuentasSnapshot.data ?? [];
        final totalBalance = allCuentas.fold<double>(0.0, (sum, cuenta) => sum + cuenta.saldoActual);

        return StreamBuilder<List<DetailedTransaction>>(
          stream: allTransaccionesStream,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            }
            if (snapshot.hasError) {
              return Center(child: Text('Error: ${snapshot.error}'));
            }

            final allTransactions = snapshot.data ?? [];

            if (allTransactions.isEmpty) {
              return const Center(
                child: Text('No hay transacciones.'),
              );
            }

            // Calculate daily balances
            final dailyBalances = _calculateDailyBalances(allTransactions, totalBalance);

            return _buildChart(dailyBalances);
          },
        );
      },
    );
  }

  Widget _buildAccountChart(WidgetRef ref, Cuenta cuenta) {
    final transaccionesStream = ref.watch(transaccionesDaoProvider).watchDetailedTransaccionesForCuenta(cuenta.id);

    return StreamBuilder<List<DetailedTransaction>>(
      stream: transaccionesStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final transactions = snapshot.data ?? [];

        if (transactions.isEmpty) {
          return const Center(
            child: Text('No hay transacciones para esta cuenta.'),
          );
        }

        // Calculate daily balances
        final dailyBalances = _calculateDailyBalances(transactions, cuenta.saldoActual);

        return _buildChart(dailyBalances);
      },
    );
  }

  Widget _buildChart(List<_ChartData> dailyBalances) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SfCartesianChart(
        primaryXAxis: DateTimeAxis(
          dateFormat: DateFormat.MMMd(),
          intervalType: DateTimeIntervalType.days,
        ),
        primaryYAxis: NumericAxis(
          numberFormat: NumberFormat.currency(locale: 'es_ES', symbol: '€'),
        ),
        series: <CartesianSeries>[
          CandleSeries<_ChartData, DateTime>(
            dataSource: dailyBalances,
            xValueMapper: (_ChartData data, _) => data.x,
            lowValueMapper: (_ChartData data, _) => data.low,
            highValueMapper: (_ChartData data, _) => data.high,
            openValueMapper: (_ChartData data, _) => data.open,
            closeValueMapper: (_ChartData data, _) => data.close,
            name: 'Saldo',
          )
        ],
        tooltipBehavior: TooltipBehavior(enable: true),
      ),
    );
  }

  List<_ChartData> _calculateDailyBalances(List<DetailedTransaction> transactions, double currentBalance) {
    if (transactions.isEmpty) {
      return [];
    }

    transactions.sort((a, b) => a.transaccion.fecha.compareTo(b.transaccion.fecha));

    double initialBalance = currentBalance;
    for (var t in transactions.reversed) {
      initialBalance -= t.transaccion.cantidad;
    }

    final Map<DateTime, List<DetailedTransaction>> dailyTransactions = {};
    for (var t in transactions) {
      final date = DateTime(t.transaccion.fecha.year, t.transaccion.fecha.month, t.transaccion.fecha.day);
      dailyTransactions.update(date, (value) {
        value.add(t);
        return value;
      }, ifAbsent: () => [t]);
    }

    final List<_ChartData> chartData = [];
    if (dailyTransactions.isEmpty) {
      return chartData;
    }
    
    final sortedDates = dailyTransactions.keys.toList()..sort();
    DateTime currentDate = sortedDates.first;
    final endDate = DateTime.now();
    
    double lastClose = initialBalance;

    while(currentDate.isBefore(endDate) || currentDate.isAtSameMomentAs(endDate)){
      if (dailyTransactions.containsKey(currentDate)) {
        final dayTransactions = dailyTransactions[currentDate]!;
        dayTransactions.sort((a,b) => a.transaccion.fecha.compareTo(b.transaccion.fecha));

        final open = lastClose;
        double high = open;
        double low = open;
        double current = open;

        for(var t in dayTransactions){
          current += t.transaccion.cantidad;
          if(current > high) high = current;
          if(current < low) low = current;
        }
        final close = current;
        chartData.add(_ChartData(currentDate, open, high, low, close));
        lastClose = close;
      } else {
        // No transactions on this day, carry over the previous day's close
        chartData.add(_ChartData(currentDate, lastClose, lastClose, lastClose, lastClose));
      }
      currentDate = currentDate.add(const Duration(days: 1));
    }

    return chartData;
  }
}

class _ChartData {
  _ChartData(this.x, this.open, this.high, this.low, this.close);

  final DateTime x;
  final double open;
  final double high;
  final double low;
  final double close;
}