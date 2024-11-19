import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/Result.dart';
import '../models/GetCountriesResponse.dart';
import '../models/country_model.dart';

@injectable
class CountryApiService {
  final Dio _dio;

  CountryApiService(this._dio);

  Future<Result<List<CountryModel>>> fetchCountries() async {
    try {
      final response = await _dio.get('/api/v7/countries');

      if (response.statusCode == 200) {
        final countriesResponse = GetCountriesResponse.fromJson(response.data);

        final countries = countriesResponse.toCountryList();

        return Result.success(countries);
      } else {
        return Result.error(
            'Failed to load countries. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return Result.error('Failed to fetch countries: ${error.toString()}');
    }
  }
}
