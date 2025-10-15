import 'package:intl/intl.dart';

String formatCurrency(double amount, String symbol) {
  final format = NumberFormat.currency(
    locale: 'en_US', // Using a consistent locale for number formatting part
    symbol: '$symbol ', // Add symbol with a space
  );
  return format.format(amount);
}
