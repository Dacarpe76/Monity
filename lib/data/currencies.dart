class Currency {
  final String code;
  final String name;
  final String symbol;

  const Currency({
    required this.code,
    required this.name,
    required this.symbol,
  });
}

const List<Currency> supportedCurrencies = [
  Currency(code: 'EUR', name: 'Euro', symbol: '\u20AC'),
  Currency(code: 'USD', name: 'US Dollar', symbol: '\$'),
  Currency(code: 'JPY', name: 'Japanese Yen', symbol: '\u00A5'),
  Currency(code: 'GBP', name: 'British Pound', symbol: '\u00A3'),
  Currency(code: 'AUD', name: 'Australian Dollar', symbol: 'A\$'),
  Currency(code: 'CAD', name: 'Canadian Dollar', symbol: 'C\$'),
  Currency(code: 'CHF', name: 'Swiss Franc', symbol: 'Fr'),
  Currency(code: 'CNY', name: 'Chinese Yuan', symbol: 'CN\u00A5'),
  Currency(code: 'HKD', name: 'Hong Kong Dollar', symbol: 'HK\$'),
  Currency(code: 'SGD', name: 'Singapore Dollar', symbol: 'S\$'),
];