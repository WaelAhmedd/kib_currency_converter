import 'package:injectable/injectable.dart';

import '../../data/models/ConversionRateParams.dart';

import '../../../../core/utils/Result.dart';
import '../../../../core/utils/UseCase.dart';
import '../../data/models/conversion_rate.dart';
import '../../data/repoimpl/currency_repo_impl.dart';

@injectable
class FetchConversionRateUseCase
    implements UseCase<Result<ConversionRate>, ConversionParams> {
  final CurrencyRepoImpl currencyRepo;

  FetchConversionRateUseCase(this.currencyRepo);

  @override
  Future<Result<ConversionRate>> invoke(ConversionParams params) {
    return currencyRepo.fetchConversionRates(params);
  }
}
