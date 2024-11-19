class HistoricalConversionRatesParams {
  final String fromCurrency;
  final String toCurrency;
  final String startDate;
  final String endDate;

  HistoricalConversionRatesParams(
      {required this.fromCurrency,
      required this.toCurrency,
      required this.startDate,
      required this.endDate});

  String toQueryString() {
    return '${fromCurrency}_$toCurrency,${toCurrency}_$fromCurrency';
  }
}
