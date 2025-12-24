import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class NetworkService {
  static Dio create() {
    final dio = Dio(
      BaseOptions(
        baseUrl: 'https://api.anthropic.com/v1/',
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'x-api-key': '${dotenv.env['CLAUDE_API_KEY']}',
          'anthropic-version': '2023-06-01',
        },
      ),
    );
    return dio;
  }
}
