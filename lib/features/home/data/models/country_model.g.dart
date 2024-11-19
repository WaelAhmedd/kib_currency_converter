// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'country_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CountryModel _$CountryModelFromJson(Map<String, dynamic> json) => CountryModel(
      alpha3: json['alpha3'] as String,
      currencyId: json['currencyId'] as String,
      currencyName: json['currencyName'] as String,
      currencySymbol: json['currencySymbol'] as String?,
      id: json['id'] as String,
      name: json['name'] as String,
    );

Map<String, dynamic> _$CountryModelToJson(CountryModel instance) =>
    <String, dynamic>{
      'alpha3': instance.alpha3,
      'currencyId': instance.currencyId,
      'currencyName': instance.currencyName,
      'currencySymbol': instance.currencySymbol,
      'id': instance.id,
      'name': instance.name,
    };
