import 'package:injectable/injectable.dart';

import '../../data/models/fetched_currency.dart';

import '../../../../core/utils/Result.dart';
import '../../../../core/utils/UseCase.dart';
import '../../data/repoimpl/currency_repo_impl.dart';

@injectable
class FetchCurrenciesUseCase
    implements UseCase<Result<List<FetchedCurrency>>, NoParams> {
  final CurrencyRepoImpl currencyRepo;

  FetchCurrenciesUseCase(this.currencyRepo);

  @override
  Future<Result<List<FetchedCurrency>>> invoke(NoParams params) {
    return currencyRepo.fetchCurrencies();
  }
}
