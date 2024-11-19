import 'package:json_annotation/json_annotation.dart';

part 'country_model.g.dart';

@JsonSerializable()
class CountryModel {
  final String alpha3;
  final String currencyId;
  final String currencyName;
  final String? currencySymbol;
  final String id;
  final String name;

  CountryModel({
    required this.alpha3,
    required this.currencyId,
    required this.currencyName,
    this.currencySymbol,
    required this.id,
    required this.name,
  });

  factory CountryModel.fromJson(Map<String, dynamic> json) =>
      _$CountryModelFromJson(json);

  Map<String, dynamic> toJson() => _$CountryModelToJson(this);
}
