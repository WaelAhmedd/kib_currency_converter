import 'package:injectable/injectable.dart';
import 'package:get_it/get_it.dart';
import 'package:kib_currency_converter/injectable.config.dart';

final getIt = GetIt.instance;

@InjectableInit()
Future<void> configureInjection(String environment) async {
  await getIt.init(environment: environment);
}
