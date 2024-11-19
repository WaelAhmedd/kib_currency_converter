import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import 'package:kib_currency_converter/features/home/data/models/fetched_currency.dart';

import '../../../../core/utils/Result.dart';
import '../models/GetCountriesResponse.dart';
import '../models/GetCurrenciesResponse.dart';
import '../models/country_model.dart';

@injectable
class CurrencyApiService {
  final Dio _dio;

  CurrencyApiService(this._dio);

  Future<Result<List<FetchedCurrency>>> fetchCurrencies() async {
    try {
      final response = await _dio.get('/api/v7/currencies');

      if (response.statusCode == 200) {
        final countriesResponse = GetCurrenciesResponse.fromJson(response.data);

        final countries = countriesResponse.toCurrencyList();

        return Result.success(countries);
      } else {
        return Result.error(
            'Failed to load countries. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return Result.error('Failed to fetch currencies: ${error.toString()}');
    }
  }
}
