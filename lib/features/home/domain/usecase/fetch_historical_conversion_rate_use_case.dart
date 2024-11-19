import 'package:injectable/injectable.dart';
import 'package:kib_currency_converter/features/home/data/models/HistoricalConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/HistoricalConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/historical_conversion_rates.dart';

import '../../data/models/ConversionRateParams.dart';
import '../../data/models/fetched_currency.dart';

import '../../../../core/utils/Result.dart';
import '../../../../core/utils/UseCase.dart';
import '../../data/repoimpl/currency_repo_impl.dart';

@injectable
class FetchHistoricalConversionRateUseCase
    implements UseCase<Result<HistoricalConversionRates>, HistoricalConversionRatesParams> {
  final CurrencyRepoImpl currencyRepo;

  FetchHistoricalConversionRateUseCase(this.currencyRepo);

  @override
  Future<Result<HistoricalConversionRates>> invoke(HistoricalConversionRatesParams params) {
    return currencyRepo.fetchHistoricalConversionRates(params);
  }
}
