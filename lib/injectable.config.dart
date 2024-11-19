// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:dio/dio.dart' as _i361;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:kib_currency_converter/core/data/network/network_module.dart'
    as _i371;
import 'package:kib_currency_converter/features/home/data/datasource/conversion_rate_api_service.dart'
    as _i265;
import 'package:kib_currency_converter/features/home/data/datasource/get_countries_api.dart'
    as _i915;
import 'package:kib_currency_converter/features/home/data/datasource/get_currencies_api_service.dart'
    as _i544;
import 'package:kib_currency_converter/features/home/data/datasource/historical_rates_api_service.dart'
    as _i877;
import 'package:kib_currency_converter/features/home/data/repoimpl/countries_repo_impl.dart'
    as _i232;
import 'package:kib_currency_converter/features/home/data/repoimpl/currency_repo_impl.dart'
    as _i277;
import 'package:kib_currency_converter/features/home/data/repoimpl/currency_with_country_repo_impl.dart'
    as _i388;
import 'package:kib_currency_converter/features/home/domain/usecase/combine_currencies_with_countries_use_case.dart'
    as _i962;
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_conversion_rate_use_case.dart'
    as _i623;
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_countries_use_case.dart'
    as _i536;
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_currencies_use_case.dart'
    as _i40;
import 'package:kib_currency_converter/features/home/domain/usecase/fetch_historical_conversion_rate_use_case.dart'
    as _i416;
import 'package:kib_currency_converter/features/home/domain/usecase/get_currencies_with_countries_use_case.dart'
    as _i787;
import 'package:kib_currency_converter/features/home/presentation/home_cubit.dart'
    as _i719;
import 'package:kib_currency_converter/features/splash/splash_cubit.dart'
    as _i493;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    final networkModule = _$NetworkModule();
    gh.factory<_i388.CurrencyWithCountryRepoImpl>(
        () => _i388.CurrencyWithCountryRepoImpl());
    gh.factory<_i493.SplashCubit>(() => _i493.SplashCubit());
    gh.lazySingleton<_i361.Dio>(() => networkModule.dio());
    gh.factory<_i787.GetCurrenciesWithCountriesUseCase>(() =>
        _i787.GetCurrenciesWithCountriesUseCase(
            gh<_i388.CurrencyWithCountryRepoImpl>()));
    gh.factory<_i962.CombineCurrenciesWithCountriesUseCase>(() =>
        _i962.CombineCurrenciesWithCountriesUseCase(
            gh<_i388.CurrencyWithCountryRepoImpl>()));
    gh.factory<_i915.CountryApiService>(
        () => _i915.CountryApiService(gh<_i361.Dio>()));
    gh.factory<_i877.HistoricalRatesApiService>(
        () => _i877.HistoricalRatesApiService(gh<_i361.Dio>()));
    gh.factory<_i265.ConvertApiService>(
        () => _i265.ConvertApiService(gh<_i361.Dio>()));
    gh.factory<_i544.CurrencyApiService>(
        () => _i544.CurrencyApiService(gh<_i361.Dio>()));
    gh.factory<_i277.CurrencyRepoImpl>(() => _i277.CurrencyRepoImpl(
          gh<_i544.CurrencyApiService>(),
          gh<_i265.ConvertApiService>(),
          gh<_i877.HistoricalRatesApiService>(),
        ));
    gh.factory<_i232.CountryRepositoryImpl>(
        () => _i232.CountryRepositoryImpl(gh<_i915.CountryApiService>()));
    gh.factory<_i536.FetchCountriesUseCase>(
        () => _i536.FetchCountriesUseCase(gh<_i232.CountryRepositoryImpl>()));
    gh.factory<_i416.FetchHistoricalConversionRateUseCase>(() =>
        _i416.FetchHistoricalConversionRateUseCase(
            gh<_i277.CurrencyRepoImpl>()));
    gh.factory<_i40.FetchCurrenciesUseCase>(
        () => _i40.FetchCurrenciesUseCase(gh<_i277.CurrencyRepoImpl>()));
    gh.factory<_i623.FetchConversionRateUseCase>(
        () => _i623.FetchConversionRateUseCase(gh<_i277.CurrencyRepoImpl>()));
    gh.factory<_i719.HomeCubit>(() => _i719.HomeCubit(
          fetchCurrenciesUseCase: gh<_i40.FetchCurrenciesUseCase>(),
          fetchCountriesUseCase: gh<_i536.FetchCountriesUseCase>(),
          getCurrenciesWithCountriesUseCase:
              gh<_i787.GetCurrenciesWithCountriesUseCase>(),
          combineCurrenciesWithCountriesUseCase:
              gh<_i962.CombineCurrenciesWithCountriesUseCase>(),
          fetchConversionRateUseCase: gh<_i623.FetchConversionRateUseCase>(),
          fetchHistoricalConversionRateUseCase:
              gh<_i416.FetchHistoricalConversionRateUseCase>(),
        ));
    return this;
  }
}

class _$NetworkModule extends _i371.NetworkModule {}
