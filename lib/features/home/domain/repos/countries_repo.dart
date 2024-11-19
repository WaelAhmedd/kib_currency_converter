import '../../data/models/country_model.dart';
import '../../../../core/utils/Result.dart';

abstract class CountriesRepo {
  Future<Result<List<CountryModel>>> fetchCountries();
}
