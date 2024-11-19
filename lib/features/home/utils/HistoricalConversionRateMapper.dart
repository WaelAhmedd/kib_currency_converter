import '../data/models/HistoricalRateUiModel.dart';

List<HistoricalConversionRateUiModel> mapToHistoricalConversionRateUiModels(
    Map<String, Map<String, double>> historicalData) {
  return historicalData.entries
      .expand((conversionEntry) {
    final conversion = conversionEntry.key;
    final dateRateMap = conversionEntry.value;
    return dateRateMap.entries.map((dateRateEntry) {
      final date = dateRateEntry.key;
      final rate = dateRateEntry.value;

      return HistoricalConversionRateUiModel(
        conversion: conversion,
        date: date,
        rate: rate,
      );
    });
  })
      .toList();
}
