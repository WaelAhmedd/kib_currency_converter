import 'package:injectable/injectable.dart';

import '../../data/models/databasemodels/currency_with_country.dart';
import '../../data/models/fetched_currency.dart';

import '../../../../core/utils/Result.dart';
import '../../../../core/utils/UseCase.dart';
import '../../data/repoimpl/currency_with_country_repo_impl.dart';

@injectable
class GetCurrenciesWithCountriesUseCase
    implements UseCase<List<CurrencyWithCountry>, NoParams> {
  final CurrencyWithCountryRepoImpl currencyWithCountryRepo;

  GetCurrenciesWithCountriesUseCase(this.currencyWithCountryRepo);

  @override
  Future<List<CurrencyWithCountry>> invoke(NoParams params) {
    return currencyWithCountryRepo.fetchCurrenciesWithCountries();
  }
}
