import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

Dio api() {
  final String baseUrl = dotenv.get("OPEN_API_BASE_URL");

  final Dio dio = Dio(
    BaseOptions(
      connectTimeout: 5000,
      receiveTimeout: 5000,
      baseUrl: baseUrl,
    ),
  );

  return dio;
}
