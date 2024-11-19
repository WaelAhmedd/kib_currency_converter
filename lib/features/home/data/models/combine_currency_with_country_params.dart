import 'package:kib_currency_converter/features/home/data/models/fetched_currency.dart';

import 'country_model.dart';

class CombineCurrenciesWithCountriesParams {
  final List<CountryModel> countries;
  final List<FetchedCurrency> currencies;

  CombineCurrenciesWithCountriesParams({required this.countries, required this.currencies});
}
