import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';

import '../../../../core/utils/Result.dart';
import '../models/conversion_rate.dart';

@injectable
class ConvertApiService {
  final Dio _dio;

  ConvertApiService(this._dio);

  Future<Result<ConversionRate>> fetchConversionRates(String query) async {
    try {
      final response = await _dio.get('/api/v7/convert', queryParameters: {
        'q': query,
        'compact': 'ultra',
      });

      if (response.statusCode == 200) {
        final data = response.data as Map<String, dynamic>;

        final conversionRate = ConversionRate.fromJson(data);
        return Result.success(conversionRate);
      } else {
        return Result.error(
            'Failed to fetch conversion rates. Status code: ${response.statusCode}');
      }
    } catch (error) {
      return Result.error(
          'Failed to fetch conversion rates: ${error.toString()}');
    }
  }
}
