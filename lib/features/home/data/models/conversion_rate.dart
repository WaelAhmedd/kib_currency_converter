import 'package:json_annotation/json_annotation.dart';

part 'conversion_rate.g.dart';


@JsonSerializable()
class ConversionRate {
  final Map<String, double> rates;

  ConversionRate({required this.rates});

  factory ConversionRate.fromJson(Map<String, dynamic> json) {
    final rates = json.map((key, value) => MapEntry(key, (value as num).toDouble()));
    return ConversionRate(rates: rates);
  }

  Map<String, dynamic> toJson() => rates;
}

