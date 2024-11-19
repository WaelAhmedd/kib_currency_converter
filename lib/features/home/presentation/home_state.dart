part of 'home_cubit.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}



class HomeLoaded extends HomeState {
  final List<CurrencyWithCountry> currencies;
  final CurrencyWithCountry? fromCurrency;
  final CurrencyWithCountry? toCurrency;
  final double amount;
  final double conversionRate;
  final double convertedAmount;
  final List<HistoricalConversionRateUiModel> historicalData;
  final bool isLoadingHistory;

  HomeLoaded({
    required this.currencies,
    this.fromCurrency,
    this.toCurrency,
    this.amount = 0.0,
    this.conversionRate = 0.0,
    this.convertedAmount = 0.0,
    this.historicalData = const [],
    this.isLoadingHistory = false,
  });

  HomeLoaded copyWith({
    List<CurrencyWithCountry>? currencies,
    CurrencyWithCountry? fromCurrency,
    CurrencyWithCountry? toCurrency,
    double? amount,
    double? conversionRate,
    double? convertedAmount,
    List<HistoricalConversionRateUiModel>? historicalData,
    bool? isLoadingHistory,
  }) {
    return HomeLoaded(
      currencies: currencies ?? this.currencies,
      fromCurrency: fromCurrency ?? this.fromCurrency,
      toCurrency: toCurrency ?? this.toCurrency,
      amount: amount ?? this.amount,
      conversionRate: conversionRate ?? this.conversionRate,
      convertedAmount: convertedAmount ?? this.convertedAmount,
      historicalData: historicalData ?? this.historicalData,
      isLoadingHistory: isLoadingHistory ?? this.isLoadingHistory,
    );
  }
}


class HomeError extends HomeState {
  final String message;
  HomeError(this.message);
}
