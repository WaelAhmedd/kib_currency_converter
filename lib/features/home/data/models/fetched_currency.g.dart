// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fetched_currency.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FetchedCurrency _$FetchedCurrencyFromJson(Map<String, dynamic> json) =>
    FetchedCurrency(
      id: json['id'] as String,
      currencyName: json['currencyName'] as String,
      currencySymbol: json['currencySymbol'] as String?,
    );

Map<String, dynamic> _$FetchedCurrencyToJson(FetchedCurrency instance) =>
    <String, dynamic>{
      'id': instance.id,
      'currencyName': instance.currencyName,
      'currencySymbol': instance.currencySymbol,
    };
