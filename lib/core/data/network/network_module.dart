import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

@module
abstract class NetworkModule {
  @lazySingleton
  Dio dio() {
    final String apiKey = dotenv.env['API_KEY'] ?? '';
    return Dio(BaseOptions(
      baseUrl: "https://prepaid.currconv.com",
      connectTimeout: const Duration(seconds: 50),
      receiveTimeout: const Duration(seconds: 50),
    ))
      ..interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) {
          options.queryParameters['apiKey'] = apiKey;
          return handler.next(options);
        },
        onError: (DioError error, handler) {
          return handler.next(error);
        },
      ))
      ..interceptors.add(LogInterceptor(responseBody: true)); // For debugging
  }
}
