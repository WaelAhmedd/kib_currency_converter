import 'package:hive/hive.dart';
part 'currency_with_country.g.dart';

@HiveType(typeId: 0)
class CurrencyWithCountry {
  @HiveField(0)
  final String currencyId;

  @HiveField(1)
  final String currencyName;

  @HiveField(2)
  final String countryId;

  @HiveField(3)
  final String countryName;

  @HiveField(4)
  final String countryFlagUrl;

  CurrencyWithCountry({
    required this.currencyId,
    required this.currencyName,
    required this.countryId,
    required this.countryName,
    required this.countryFlagUrl,
  });
}
