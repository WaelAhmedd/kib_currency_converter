import 'package:json_annotation/json_annotation.dart';
import 'package:kib_currency_converter/features/home/data/models/fetched_currency.dart';
import 'country_model.dart';

part 'GetCurrenciesResponse.g.dart';

@JsonSerializable()
class GetCurrenciesResponse {
  final Map<String, FetchedCurrency>? results;

  GetCurrenciesResponse({required this.results});

  factory GetCurrenciesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCurrenciesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCurrenciesResponseToJson(this);

  List<FetchedCurrency> toCurrencyList() {
    if (results == null) return [];
    return results!.values.toList();
  }
}
