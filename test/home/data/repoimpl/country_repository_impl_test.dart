import 'package:flutter_test/flutter_test.dart';
import 'package:kib_currency_converter/features/home/data/models/country_model.dart';
import 'package:kib_currency_converter/features/home/data/repoimpl/countries_repo_impl.dart';

import 'package:mockito/mockito.dart';

import 'package:kib_currency_converter/core/utils/Result.dart';

import '../../../country_api_service.mocks.mocks.dart';


void main() {
  late MockCountryApiService mockApiService;
  late CountryRepositoryImpl repository;

  setUp(() {
    mockApiService = MockCountryApiService();
    repository = CountryRepositoryImpl(mockApiService);
  });

  group('fetchCountries', () {
    test('returns success when CountryApiService returns success', () async {
      // Arrange
      final mockCountries = [
        CountryModel(
          id: 'US',
          name: 'United States',
          alpha3: 'USA',
          currencyId: 'USD',
          currencyName: 'United States Dollar',
          currencySymbol: '\$',
        ),
        CountryModel(
          id: 'UK',
          name: 'United Kingdom',
          alpha3: 'GBR',
          currencyId: 'GBP',
          currencyName: 'British Pound',
          currencySymbol: '£',
        ),
      ];
      final mockResult = Result<List<CountryModel>>.success(mockCountries);

      when(mockApiService.fetchCountries())
          .thenAnswer((_) async => mockResult);

      // Act
      final result = await repository.fetchCountries();

      // Assert
      expect(result.isSuccess, true);
      expect(result.data, isNotNull);
      expect(result.data!.length, 2);
      expect(result.data!.first.name, 'United States');
    });

    test('returns error when CountryModelApiService returns error', () async {
      // Arrange
      final mockErrorResult = Result<List<CountryModel>>.error('Failed to fetch countries');
      when(mockApiService.fetchCountries())
          .thenAnswer((_) async => mockErrorResult);

      // Act
      final result = await repository.fetchCountries();

      // Assert
      expect(result.isError, true);
      expect(result.error, 'Failed to fetch countries');
    });
  });
}
