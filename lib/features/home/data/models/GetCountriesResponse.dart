import 'package:json_annotation/json_annotation.dart';
import 'country_model.dart';
import 'country_model.dart';

part 'GetCountriesResponse.g.dart';

@JsonSerializable()
class GetCountriesResponse {
  final Map<String, CountryModel>? results;

  GetCountriesResponse({required this.results});

  factory GetCountriesResponse.fromJson(Map<String, dynamic> json) =>
      _$GetCountriesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$GetCountriesResponseToJson(this);

  List<CountryModel> toCountryList() {
    if (results == null) return [];
    return results!.values.toList();
  }
}
