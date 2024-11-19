import 'package:json_annotation/json_annotation.dart';

part 'fetched_currency.g.dart';

@JsonSerializable()
class FetchedCurrency {
  final String id;
  final String currencyName;
  final String? currencySymbol;


  FetchedCurrency({
    required this.id,
    required this.currencyName,
    this.currencySymbol,

  });

  factory FetchedCurrency.fromJson(Map<String, dynamic> json) =>
      _$FetchedCurrencyFromJson(json);

  Map<String, dynamic> toJson() => _$FetchedCurrencyToJson(this);
}
