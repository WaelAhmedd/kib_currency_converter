import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/databasemodels/currency_with_country.dart';
import '../home_cubit.dart';

class ConvertButton extends StatelessWidget {
  final CurrencyWithCountry fromCurrency;
  final CurrencyWithCountry toCurrency;

  const ConvertButton({
    required this.fromCurrency,
    required this.toCurrency,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        context.read<HomeCubit>().convert(
          fromCurrency: fromCurrency,
          toCurrency: toCurrency,
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: Colors.blue,
        padding: const EdgeInsets.symmetric(vertical: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        ),
      ),
      child: const Text(
        'Convert',
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}