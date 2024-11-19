import 'package:flutter_test/flutter_test.dart';
import 'package:kib_currency_converter/features/home/data/datasource/conversion_rate_api_service.dart';
import 'package:mockito/mockito.dart';
import 'package:dio/dio.dart';

import '../../dio.mocks.mocks.dart';



void main() {
  late MockDio mockDio;
  late ConvertApiService convertApiService;

  setUp(() {
    mockDio = MockDio();
    convertApiService = ConvertApiService(mockDio);
  });

  group('fetchConversionRates', () {
    test('returns success when API call is successful', () async {
      // Arrange
      final mockResponse = Response(
        statusCode: 200,
        data: {
          'USD_PHP': 46.211,
          'PHP_USD': 0.02163987,
        },
        requestOptions: RequestOptions(path: '/api/v7/convert'),
      );

      when(mockDio.get('/api/v7/convert', queryParameters: {
        'q': 'USD_PHP,PHP_USD',
        'compact': 'ultra',
      })).thenAnswer((_) async => mockResponse);


      // Act
      final result = await convertApiService.fetchConversionRates('USD_PHP,PHP_USD');

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, isNotNull);
      expect(result.data!.rates['USD_PHP'], 46.211);
      expect(result.data!.rates['PHP_USD'], 0.02163987);
    });

    test('returns error when API response status code is not 200', () async {
      // Arrange
      final mockResponse = Response(
        statusCode: 500,
        requestOptions: RequestOptions(path: '/api/v7/convert'),
      );

      when(mockDio.get('/api/v7/convert', queryParameters: {
        'q': 'USD_PHP,PHP_USD',
        'compact': 'ultra',
      })).thenAnswer((_) async => mockResponse);

      // Act
      final result = await convertApiService.fetchConversionRates('USD_PHP,PHP_USD');

      // Assert
      expect(result.isError, true);
      expect(result.error, contains('Failed to fetch conversion rates. Status code: 500'));
    });
  });
}
