import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../data/models/databasemodels/currency_with_country.dart';

class CurrencySelector extends StatelessWidget {
  final String title;
  final List<CurrencyWithCountry> currencies;
  final CurrencyWithCountry selectedCurrency;
  final ValueChanged<CurrencyWithCountry?> onCurrencyChanged;

  const CurrencySelector({
    required this.title,
    required this.currencies,
    required this.selectedCurrency,
    required this.onCurrencyChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16.0),
        ),
        const SizedBox(height: 8.0),
        SizedBox(
          width: double.infinity,
          child: DropdownButtonFormField<CurrencyWithCountry>(
            value: selectedCurrency,
            isExpanded: true,
            decoration: InputDecoration(
              filled: true,
              fillColor: Colors.grey[800],
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8.0),
              ),
            ),
            dropdownColor: Colors.grey[800],
            items: currencies.map((item) {
              return DropdownMenuItem(
                value: item,
                child: Row(
                  children: [
                    CachedNetworkImage(
                      imageUrl: item.countryFlagUrl,
                      width: 30,
                      height: 20,
                      fit: BoxFit.cover,
                    ),
                    const SizedBox(width: 8.0),
                    Expanded(
                      child: Text(
                        '${item.currencyName} (${item.countryName})',
                        style: const TextStyle(color: Colors.white),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
            onChanged: onCurrencyChanged,
          ),
        ),
      ],
    );
  }
}