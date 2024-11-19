import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'package:injectable/injectable.dart';

import 'package:kib_currency_converter/features/home/presentation/HomeScreen.dart';
import 'package:kib_currency_converter/features/splash/SplashScreen.dart';
import 'package:hive_flutter/hive_flutter.dart';

import 'features/home/data/models/databasemodels/currency_with_country.dart';
import 'injectable.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await dotenv.load(fileName: ".env");

  configureInjection(Environment.dev);
  await Hive.initFlutter();

  Hive.registerAdapter(CurrencyWithCountryAdapter());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SplashScreen(),
    );
  }
}
