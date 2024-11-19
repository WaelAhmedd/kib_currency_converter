import 'package:injectable/injectable.dart';
import 'package:kib_currency_converter/features/home/data/models/HistoricalConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/fetched_currency.dart';
import 'package:kib_currency_converter/features/home/data/models/historical_conversion_rates.dart';

import 'package:kib_currency_converter/core/utils/Result.dart';

import '../../domain/repos/currency_repo.dart';
import '../datasource/conversion_rate_api_service.dart';
import '../datasource/get_currencies_api_service.dart';
import '../datasource/historical_rates_api_service.dart';
import '../models/ConversionRateParams.dart';
import '../models/conversion_rate.dart';

@injectable
class CurrencyRepoImpl implements CurrencyRepo {
  final CurrencyApiService _currencyApiService;
  final ConvertApiService _convertApiService;
  final HistoricalRatesApiService _historicalRatesApiService;

  CurrencyRepoImpl(this._currencyApiService, this._convertApiService,
      this._historicalRatesApiService);

  @override
  Future<Result<List<FetchedCurrency>>> fetchCurrencies() async {
    return await _currencyApiService.fetchCurrencies();
  }

  @override
  Future<Result<ConversionRate>> fetchConversionRates(
      ConversionParams params) async {
    return await _convertApiService
        .fetchConversionRates(params.toQueryString());
  }

  @override
  Future<Result<HistoricalConversionRates>> fetchHistoricalConversionRates(
      HistoricalConversionRatesParams params) async {
    return await _historicalRatesApiService.fetchHistoricalRates(
        query: params.toQueryString(),
        startDate: params.startDate,
        endDate: params.endDate);
  }
}
