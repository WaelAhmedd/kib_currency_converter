import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:kib_currency_converter/features/home/data/models/ConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/HistoricalConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/historical_conversion_rates.dart';
import 'package:kib_currency_converter/core/utils/UseCase.dart';
import 'package:kib_currency_converter/features/home/data/models/HistoricalRateUiModel.dart';
import 'package:kib_currency_converter/features/home/domain/usecase/combine_currencies_with_countries_use_case.dart';
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_conversion_rate_use_case.dart';
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_countries_use_case.dart';
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_currencies_use_case.dart';
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_historical_conversion_rate_use_case.dart';

import '../data/models/combine_currency_with_country_params.dart';
import '../data/models/databasemodels/currency_with_country.dart';
import '../domain/usecase/get_currencies_with_countries_use_case.dart';
import '../utils/HistoricalConversionRateMapper.dart';
import '../utils/get_today_date_and_last_seven_date.dart';

part 'home_state.dart';

@Injectable()
class HomeCubit extends Cubit<HomeState> {
  final FetchCurrenciesUseCase fetchCurrenciesUseCase;
  final FetchCountriesUseCase fetchCountriesUseCase;
  final GetCurrenciesWithCountriesUseCase getCurrenciesWithCountriesUseCase;
  final CombineCurrenciesWithCountriesUseCase combineCurrenciesWithCountriesUseCase;
  final FetchConversionRateUseCase fetchConversionRateUseCase;
  final FetchHistoricalConversionRateUseCase fetchHistoricalConversionRateUseCase;

  HomeCubit({
    required this.fetchCurrenciesUseCase,
    required this.fetchCountriesUseCase,
    required this.getCurrenciesWithCountriesUseCase,
    required this.combineCurrenciesWithCountriesUseCase,
    required this.fetchConversionRateUseCase,
    required this.fetchHistoricalConversionRateUseCase,
  }) : super(HomeInitial());

  Future<void> init() async {
    emit(HomeLoading());

    try {
      var currenciesWithCountries =
      await getCurrenciesWithCountriesUseCase.invoke(NoParams());

      if (currenciesWithCountries.isEmpty) {
        final currenciesResult =
        await fetchCurrenciesUseCase.invoke(NoParams());
        final countriesResult =
        await fetchCountriesUseCase.invoke(NoParams());

        if (currenciesResult.isSuccess && countriesResult.isSuccess) {
          await combineCurrenciesWithCountriesUseCase.invoke(
            CombineCurrenciesWithCountriesParams(
              currencies: currenciesResult.data!,
              countries: countriesResult.data!,
            ),
          );

          currenciesWithCountries = await getCurrenciesWithCountriesUseCase
              .invoke(NoParams());
        } else {
          throw Exception(currenciesResult.error ?? countriesResult.error);
        }
      }

      emit(HomeLoaded(
        currencies: currenciesWithCountries,
        fromCurrency: currenciesWithCountries.first,
        toCurrency: currenciesWithCountries.first,
        amount: 0.0,
        conversionRate: 0.0,
        convertedAmount: 0.0,
        historicalData: [],
        isLoadingHistory: false,
      ));
    } catch (e) {
      emit(HomeError('Initialization failed: $e'));
    }
  }


  void updateAmount(double amount) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(amount: amount));
    }
  }


  void convert({
    required CurrencyWithCountry fromCurrency,
    required CurrencyWithCountry toCurrency,
  }) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      emit(currentState.copyWith(
        conversionRate: 0.0,
        convertedAmount: 0.0,
      ));

      try {
        final result = await fetchConversionRateUseCase.invoke(
          ConversionParams(
            fromCurrency: fromCurrency.currencyId,
            toCurrency: toCurrency.currencyId,
          ),
        );

        if (result.isSuccess && result.data != null) {
          final rate = result.data!.rates.entries.first.value;

          final convertedAmount = currentState.amount * rate;

          emit(
            currentState.copyWith(
              fromCurrency: fromCurrency,
              toCurrency: toCurrency,
              conversionRate: rate,
              convertedAmount: convertedAmount,
            ),
          );
        } else {
          emit(HomeError('Failed to fetch conversion rate: ${result.error}'));
        }
      } catch (e) {
        emit(HomeError('An error occurred during conversion: $e'));
      }
    }
  }


  /// Fetch historical data for the selected currencies
  void fetchHistoricalData({
    required CurrencyWithCountry fromCurrency,
    required CurrencyWithCountry toCurrency,
  }) async {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;

      emit(currentState.copyWith(historicalData: [], isLoadingHistory: true));

      try {
        final dateRange = getTodayAndLast7Days();

        final result = await fetchHistoricalConversionRateUseCase.invoke(
          HistoricalConversionRatesParams(
              fromCurrency: fromCurrency.currencyId,
              toCurrency: toCurrency.currencyId,endDate:dateRange['today']??"",startDate: dateRange['sevenDaysAgo']??""
          ),
        );

        if (result.isSuccess && result.data != null) {
          final historicalData = mapToHistoricalConversionRateUiModels(result.data!.rates);

          emit(currentState.copyWith(
            historicalData: historicalData,
            isLoadingHistory: false,
          ));
        } else {
          emit(HomeError('Failed to fetch historical data: ${result.error}'));
        }
      } catch (e) {
        emit(HomeError('An error occurred while fetching history: $e'));
      }
    }
  }


  /// Update the selected `fromCurrency`
  void setFromCurrency(CurrencyWithCountry fromCurrency) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(fromCurrency: fromCurrency));
    }
  }

  /// Update the selected `toCurrency`
  void setToCurrency(CurrencyWithCountry toCurrency) {
    if (state is HomeLoaded) {
      final currentState = state as HomeLoaded;
      emit(currentState.copyWith(toCurrency: toCurrency));
    }
  }
}

