// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'historical_conversion_rates.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

HistoricalConversionRates _$HistoricalConversionRatesFromJson(
        Map<String, dynamic> json) =>
    HistoricalConversionRates(
      rates: (json['rates'] as Map<String, dynamic>).map(
        (k, e) => MapEntry(
            k,
            (e as Map<String, dynamic>).map(
              (k, e) => MapEntry(k, (e as num).toDouble()),
            )),
      ),
    );

Map<String, dynamic> _$HistoricalConversionRatesToJson(
        HistoricalConversionRates instance) =>
    <String, dynamic>{
      'rates': instance.rates,
    };
