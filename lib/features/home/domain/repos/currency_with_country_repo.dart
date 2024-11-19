import '../../data/models/combine_currency_with_country_params.dart';
import '../../data/models/databasemodels/currency_with_country.dart';

abstract class CurrencyWithCountryRepo {
  Future<void> saveCurrencyWithCountry(List<CurrencyWithCountry> data);

  Future<List<CurrencyWithCountry>> fetchCurrenciesWithCountries();

  Future<void> combineCurrenciesWithCountries(CombineCurrenciesWithCountriesParams params);
}
