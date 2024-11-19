import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/utils/Result.dart';
import '../models/historical_conversion_rates.dart';

@injectable
class HistoricalRatesApiService {
  final Dio _dio;

  HistoricalRatesApiService(this._dio);

  Future<Result<HistoricalConversionRates>> fetchHistoricalRates({
    required String query,
    required String startDate,
    required String endDate,
  }) async {
    try {
      final response = await _dio.get(
        '/api/v7/convert',
        queryParameters: {
          'q': query,
          'compact': 'ultra',
          'date': startDate,
          'endDate': endDate,
        },
      );

      if (response.statusCode == 200) {
        final data = HistoricalConversionRates.fromJson(response.data);
        return Result.success(data);
      } else {
        return Result.error(
            'Failed to load historical rates. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return Result.error('Failed to fetch historical rates: ${error.toString()}');
    }
  }
}
