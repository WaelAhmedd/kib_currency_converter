import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../home_cubit.dart';

class HistoricalList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<HomeCubit, HomeState>(
      builder: (context, state) {
        if (state is HomeLoaded && state.historicalData.isNotEmpty) {
          return Expanded(
            child: ListView.builder(
              itemCount: state.historicalData.length,
              itemBuilder: (context, index) {
                final item = state.historicalData[index];
                return Card(
                  color: Colors.grey[850],
                  margin: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        Text(
                          item.conversion,
                          style: const TextStyle(color: Colors.white),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              item.date,
                              style: const TextStyle(color: Colors.white),
                            ),
                            Text(
                              item.rate.toStringAsFixed(2),
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        }
        return const Center(
          child: Text(
            'No historical data available.',
            style: TextStyle(color: Colors.white),
          ),
        );
      },
    );
  }
}