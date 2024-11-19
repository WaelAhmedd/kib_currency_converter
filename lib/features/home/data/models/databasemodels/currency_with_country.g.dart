// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'currency_with_country.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class CurrencyWithCountryAdapter extends TypeAdapter<CurrencyWithCountry> {
  @override
  final int typeId = 0;

  @override
  CurrencyWithCountry read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return CurrencyWithCountry(
      currencyId: fields[0] as String,
      currencyName: fields[1] as String,
      countryId: fields[2] as String,
      countryName: fields[3] as String,
      countryFlagUrl: fields[4] as String,
    );
  }

  @override
  void write(BinaryWriter writer, CurrencyWithCountry obj) {
    writer
      ..writeByte(5)
      ..writeByte(0)
      ..write(obj.currencyId)
      ..writeByte(1)
      ..write(obj.currencyName)
      ..writeByte(2)
      ..write(obj.countryId)
      ..writeByte(3)
      ..write(obj.countryName)
      ..writeByte(4)
      ..write(obj.countryFlagUrl);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CurrencyWithCountryAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
