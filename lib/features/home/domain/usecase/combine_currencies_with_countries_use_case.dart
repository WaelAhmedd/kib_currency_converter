import 'package:injectable/injectable.dart';



import '../../../../core/utils/UseCase.dart';
import '../../data/models/combine_currency_with_country_params.dart';
import '../../data/repoimpl/currency_with_country_repo_impl.dart';

@injectable
class CombineCurrenciesWithCountriesUseCase
    implements UseCase<void, CombineCurrenciesWithCountriesParams> {
  final CurrencyWithCountryRepoImpl currencyWithCountryRepo;

  CombineCurrenciesWithCountriesUseCase(this.currencyWithCountryRepo);

  @override
  Future<void> invoke(CombineCurrenciesWithCountriesParams params) {
    return currencyWithCountryRepo.combineCurrenciesWithCountries(params);
  }
}
