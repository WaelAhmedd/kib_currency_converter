import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/databasemodels/currency_with_country.dart';
import '../home_cubit.dart';

class HistoryButton extends StatelessWidget {
  final CurrencyWithCountry fromCurrency;
  final CurrencyWithCountry toCurrency;

  const HistoryButton({
    required this.fromCurrency,
    required this.toCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeCubit>().fetchHistoricalData(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.green,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'History',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}