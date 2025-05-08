import 'package:flutter/foundation.dart';
import 'package:intl/intl.dart';

class CurrencyProvider with ChangeNotifier {
  String _currencySymbol = '\$'; // Símbolo por defecto
  String _currencyCode = 'USD'; // Código por defecto
  String _locale = 'en_US'; // Locale por defecto para el formato

  String get currencySymbol => _currencySymbol;
  String get currencyCode => _currencyCode;
  NumberFormat get currencyFormat =>
      NumberFormat.currency(locale: _locale, symbol: _currencySymbol);

  // Ejemplo de cómo podrías cambiar la moneda
  void setCurrency(String symbol, String code, String locale) {
    _currencySymbol = symbol;
    _currencyCode = code;
    _locale = locale;
    notifyListeners();
  }
}
