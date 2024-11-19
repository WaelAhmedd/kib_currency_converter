class ConversionParams {
  final String fromCurrency;
  final String toCurrency;

  ConversionParams({required this.fromCurrency, required this.toCurrency});

  String toQueryString() {
    return '${fromCurrency}_$toCurrency,${toCurrency}_$fromCurrency';
  }
}
