// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'conversion_rate.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ConversionRate _$ConversionRateFromJson(Map<String, dynamic> json) =>
    ConversionRate(
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(k, (e as num).toDouble()),
      ),
    );

Map<String, dynamic> _$ConversionRateToJson(ConversionRate instance) =>
    <String, dynamic>{
      'rates': instance.rates,
    };
