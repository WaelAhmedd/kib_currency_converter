import 'package:injectable/injectable.dart';
import 'package:hive/hive.dart';
import '../../domain/repos/currency_with_country_repo.dart';
import '../models/combine_currency_with_country_params.dart';
import '../models/databasemodels/currency_with_country.dart';

@injectable
class CurrencyWithCountryRepoImpl implements CurrencyWithCountryRepo {
  CurrencyWithCountryRepoImpl();

  @override
  Future<void> saveCurrencyWithCountry(List<CurrencyWithCountry> data) async {
    final box =
        await Hive.openBox<CurrencyWithCountry>('currency_with_country');
    await box.clear();
    await box.addAll(data);
  }

  @override
  Future<List<CurrencyWithCountry>> fetchCurrenciesWithCountries() async {
    final box =
        await Hive.openBox<CurrencyWithCountry>('currency_with_country');
    return box.values.toList();
  }

  @override
  Future<void> combineCurrenciesWithCountries(
      CombineCurrenciesWithCountriesParams params) async {
    if (params.currencies.isNotEmpty && params.countries.isNotEmpty) {
      final combinedData = params.countries
          .map((country) {
            final matchingCurrency = params.currencies.firstWhere(
              (currency) => currency.id == country.currencyId,
            );

            if (matchingCurrency != null) {
              return CurrencyWithCountry(
                currencyId: matchingCurrency.id,
                currencyName: matchingCurrency.currencyName,
                countryId: country.id,
                countryName: country.name,
                countryFlagUrl:
                    'https://flagcdn.com/w320/${country.id.toLowerCase()}.png',
              );
            }
            return null;
          })
          .whereType<CurrencyWithCountry>()
          .toList();

      await saveCurrencyWithCountry(combinedData);
    }
  }
}
