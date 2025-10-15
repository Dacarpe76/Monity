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

Color getGastoProgressColor(double percentage) {
  // Asegurarse de que el porcentaje no sea negativo
  percentage = percentage.clamp(0.0, double.infinity);

  if (percentage < 0.5) {
    // De 0% a 49.9...% es verde
    return Colors.green;
  } else if (percentage < 0.8) {
    // De 50% a 79.9...% transiciona de verde a azul
    // Normalizamos el valor de t entre 0.0 y 1.0 para el rango [0.5, 0.8)
    final t = (percentage - 0.5) / (0.8 - 0.5);
    return Color.lerp(Colors.green, Colors.blue, t)!;
  } else if (percentage <= 1.0) {
    // De 80% a 100% transiciona de azul a rojo
    // Normalizamos el valor de t entre 0.0 y 1.0 para el rango [0.8, 1.0]
    final t = (percentage - 0.8) / (1.0 - 0.8);
    return Color.lerp(Colors.blue, Colors.red, t)!;
  } else {
    // Más de 100% es rojo
    return Colors.red;
  }
}