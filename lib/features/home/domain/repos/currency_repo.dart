import 'package:kib_currency_converter/features/home/data/models/HistoricalConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/fetched_currency.dart';
import 'package:kib_currency_converter/features/home/data/models/historical_conversion_rates.dart';

import '../../data/models/ConversionRateParams.dart';
import '../../data/models/conversion_rate.dart';
import '../../../../core/utils/Result.dart';

abstract class CurrencyRepo {
  Future<Result<List<FetchedCurrency>>> fetchCurrencies();
  Future<Result<ConversionRate>> fetchConversionRates(ConversionParams params);
  Future<Result<HistoricalConversionRates>> fetchHistoricalConversionRates(HistoricalConversionRatesParams params);

}