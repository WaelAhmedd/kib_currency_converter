import 'package:flutter_test/flutter_test.dart';
import 'package:kib_currency_converter/features/home/data/models/ConversionRateParams.dart';
import 'package:kib_currency_converter/features/home/data/models/conversion_rate.dart';
import 'package:kib_currency_converter/features/home/data/repoimpl/currency_repo_impl.dart';
import 'package:mockito/mockito.dart';
import 'package:kib_currency_converter/features/home/data/models/fetched_currency.dart';
import 'package:kib_currency_converter/core/utils/Result.dart';

import '../../../conversion_rate_api_service.mocks.mocks.dart';
import '../../../currency_api_service_mocks.mocks.dart';
import '../../../historical_rates_api_service.mocks.dart';


void main() {
  late MockCurrencyApiService mockApiService;
  late MockConvertApiService mockConvertApiService;
  late MockHistoricalRatesApiService mockHistoricalRatesApiService;

  late CurrencyRepoImpl repository;

  setUp(() {
    mockApiService = MockCurrencyApiService();
    mockConvertApiService = MockConvertApiService();
    mockHistoricalRatesApiService = MockHistoricalRatesApiService();
    repository = CurrencyRepoImpl(mockApiService, mockConvertApiService,mockHistoricalRatesApiService);
  });

  group('fetchCurrencies', () {
    test('returns success when CurrencyApiService returns success', () async {
      // Arrange
      final mockCurrencies = [
        FetchedCurrency(
          id: 'USD',
          currencyName: 'United States Dollar',
          currencySymbol: '\$',
        ),
        FetchedCurrency(
          id: 'EUR',
          currencyName: 'Euro',
          currencySymbol: '€',

        ),
      ];
      final mockResult = Result<List<FetchedCurrency>>.success(mockCurrencies);

      when(mockApiService.fetchCurrencies())
          .thenAnswer((_) async => mockResult);

      // Act
      final result = await repository.fetchCurrencies();

      expect(result.isSuccess, true);
      expect(result.data, isNotNull);
      expect(result.data!.length, 2);
      expect(result.data!.first.currencyName, 'United States Dollar');
    });

    test('returns error when CurrencyApiService returns error', () async {
      // Arrange
      final mockErrorResult = Result<List<FetchedCurrency>>.error(
          'Failed to fetch currencies');
      when(mockApiService.fetchCurrencies())
          .thenAnswer((_) async => mockErrorResult);

      // Act
      final result = await repository.fetchCurrencies();

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Failed to fetch currencies');
    });
  });

  group('Conversion Tests', () {
    test('returns success when ConvertApiService returns success', () async {
      // Arrange
      final params = ConversionParams(fromCurrency: 'USD', toCurrency: 'PHP');
      final mockRates = {
        'USD_PHP': 46.211,
        'PHP_USD': 0.02163987,
      };
      final mockConversionRate = ConversionRate(rates: mockRates);
      final mockResult = Result<ConversionRate>.success(mockConversionRate);

      when(mockConvertApiService.fetchConversionRates(params.toQueryString()))
          .thenAnswer((_) async => mockResult);

      // Act
      final result = await repository.fetchConversionRates(params);

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, isNotNull);
      expect(result.data!.rates['USD_PHP'], 46.211);
      expect(result.data!.rates['PHP_USD'], 0.02163987);
    });

    test('returns error when ConvertApiService returns error', () async {
      // Arrange
      final params = ConversionParams(fromCurrency: 'USD', toCurrency: 'PHP');
      final mockErrorResult =
      Result<ConversionRate>.error('Failed to fetch conversion rates');
      when(mockConvertApiService.fetchConversionRates(params.toQueryString()))
          .thenAnswer((_) async => mockErrorResult);

      // Act
      final result = await repository.fetchConversionRates(params);

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Failed to fetch conversion rates');
    });
  });
}
