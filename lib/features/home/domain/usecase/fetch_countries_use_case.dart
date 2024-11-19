import 'package:injectable/injectable.dart';

import '../../../../core/utils/Result.dart';
import '../../../../core/utils/UseCase.dart';
import '../../data/models/country_model.dart';
import '../../data/repoimpl/countries_repo_impl.dart';

@injectable
class FetchCountriesUseCase
    implements UseCase<Result<List<CountryModel>>, NoParams> {
  final CountryRepositoryImpl countriesRepo;

  FetchCountriesUseCase(this.countriesRepo);

  @override
  Future<Result<List<CountryModel>>> invoke(NoParams params) {
    return countriesRepo.fetchCountries();
  }
}
