// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetCurrenciesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCurrenciesResponse _$GetCurrenciesResponseFromJson(
        Map<String, dynamic> json) =>
    GetCurrenciesResponse(
      results: (json['results'] as Map<String, dynamic>?)?.map(
        (k, e) =>
            MapEntry(k, FetchedCurrency.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$GetCurrenciesResponseToJson(
        GetCurrenciesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
