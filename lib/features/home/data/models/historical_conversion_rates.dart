import 'package:json_annotation/json_annotation.dart';

part 'historical_conversion_rates.g.dart';

@JsonSerializable()
class HistoricalConversionRates {
  final Map<String, Map<String, double>> rates;

  HistoricalConversionRates({required this.rates});

  factory HistoricalConversionRates.fromJson(Map<String, dynamic> json) {
    final rates = json.map(
      (key, value) => MapEntry(
        key,
        (value as Map<String, dynamic>).map(
          (innerKey, innerValue) =>
              MapEntry(innerKey, (innerValue as num).toDouble()),
        ),
      ),
    );

    return HistoricalConversionRates(rates: rates);
  }

  Map<String, dynamic> toJson() => _$HistoricalConversionRatesToJson(this);
}
