import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kib_currency_converter/features/home/presentation/widgets/AmountInput.dart';
import 'package:kib_currency_converter/features/home/presentation/widgets/ConversionButton.dart';
import 'package:kib_currency_converter/features/home/presentation/widgets/ConversionInfo.dart';
import 'package:kib_currency_converter/features/home/presentation/widgets/CurrencySelctor.dart';
import 'package:kib_currency_converter/features/home/presentation/widgets/HistoricalList.dart';
import 'package:kib_currency_converter/features/home/presentation/widgets/HistoryButton.dart';
import '../../../injectable.dart';
import '../data/models/databasemodels/currency_with_country.dart';
import 'home_cubit.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final HomeCubit _homeCubit;

  @override
  void initState() {
    super.initState();
    _homeCubit = getIt<HomeCubit>();
    _homeCubit.init();
  }

  @override
  void dispose() {
    _homeCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => _homeCubit,
      child: Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            'KIB Currency Converter',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
        ),
        body: BlocConsumer<HomeCubit, HomeState>(
          listener: (context, state) {
            if (state is HomeError) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.message)),
              );
            }
          },
          builder: (context, state) {
            if (state is HomeLoading) {
              return const Center(child: CircularProgressIndicator());
            } else if (state is HomeLoaded) {
              return HomeContent(
                currenciesWithCountries: state.currencies,
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ),
    );
  }
}

class HomeContent extends StatefulWidget {
  final List<CurrencyWithCountry> currenciesWithCountries;

  const HomeContent({required this.currenciesWithCountries});

  @override
  State<HomeContent> createState() => _HomeContentState();
}

class _HomeContentState extends State<HomeContent> {
  late CurrencyWithCountry _fromCurrency;
  late CurrencyWithCountry _toCurrency;

  @override
  void initState() {
    super.initState();
    _fromCurrency = widget.currenciesWithCountries.first;
    _toCurrency = widget.currenciesWithCountries.first;
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          CurrencySelector(
            title: "From",
            currencies: widget.currenciesWithCountries,
            selectedCurrency: _fromCurrency,
            onCurrencyChanged: (currency) {
              setState(() => _fromCurrency = currency!);
            },
          ),
          const SizedBox(height: 20.0),
          AmountInput(),
          const SizedBox(height: 16.0),
          ConversionInfo(),
          const SizedBox(height: 16.0),
          CurrencySelector(
            title: "To",
            currencies: widget.currenciesWithCountries,
            selectedCurrency: _toCurrency,
            onCurrencyChanged: (currency) {
              setState(() => _toCurrency = currency!);
            },
          ),
          const SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ConvertButton(
                fromCurrency: _fromCurrency,
                toCurrency: _toCurrency,
              ),
              const SizedBox(width: 16.0),
              HistoryButton(
                fromCurrency: _fromCurrency,
                toCurrency: _toCurrency,
              ),
            ],
          ),
          const SizedBox(height: 30.0),
          HistoricalList(),
        ],
      ),
    );
  }
}


