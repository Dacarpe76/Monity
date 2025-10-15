import 'package:flutter/material.dart';

Color getSaldoTextColor(double gastoAcumulado, double limiteGasto) {
  if (limiteGasto == 0) {
    return Colors.green.shade900; // Changed to even darker green
  }
  final ratio = gastoAcumulado / limiteGasto;
  if (ratio > 1.0) {
    return Colors.red.shade900; // Changed to even darker red
  }
  if (ratio >= 0.8) {
    return Colors.blue.shade900; // Changed to even darker blue
  }
  return Colors.green.shade900; // Changed to even darker green
}

Color getCardBackgroundColor(double gastoAcumulado, double limiteGasto) {
  final now = DateTime.now();
  final diasDelMes = DateUtils.getDaysInMonth(now.year, now.month);
  final diaActual = now.day;

  if (gastoAcumulado == 0 || diaActual == 0 || limiteGasto == 0) {
    return Colors.green.shade200;
  }

  final gastoProyectado = (gastoAcumulado / diaActual) * diasDelMes;
  final porcentajeProyectado = gastoProyectado / limiteGasto;

  if (porcentajeProyectado > 1.0) {
    return Colors.red.shade200;
  }
  if (porcentajeProyectado >= 0.8) {
    return Colors.blue.shade200;
  }
  return Colors.green.shade200;
}