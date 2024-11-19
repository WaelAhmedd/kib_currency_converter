// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'GetCountriesResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetCountriesResponse _$GetCountriesResponseFromJson(
        Map<String, dynamic> json) =>
    GetCountriesResponse(
      results: (json['results'] as Map<String, dynamic>?)?.map(
        (k, e) => MapEntry(k, CountryModel.fromJson(e as Map<String, dynamic>)),
      ),
    );

Map<String, dynamic> _$GetCountriesResponseToJson(
        GetCountriesResponse instance) =>
    <String, dynamic>{
      'results': instance.results,
    };
