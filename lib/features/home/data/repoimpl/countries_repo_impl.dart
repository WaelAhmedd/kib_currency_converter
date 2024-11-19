import 'package:injectable/injectable.dart';


import '../../../../core/utils/Result.dart';
import '../../domain/repos/countries_repo.dart';
import '../datasource/get_countries_api.dart';
import '../models/country_model.dart';

@injectable
class CountryRepositoryImpl implements CountriesRepo {
  final CountryApiService _countryApiService;

  CountryRepositoryImpl(
      this._countryApiService);
  @override
  Future<Result<List<CountryModel>>> fetchCountries() async {
    return await _countryApiService.fetchCountries();
  }
}
