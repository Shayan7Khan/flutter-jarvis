import 'package:dio/dio.dart';
import 'package:flutter_jarvis/core/logger_customizations/custom_logger.dart';
import 'package:flutter_jarvis/core/network_service.dart';

class OpenApiService {
  final CustomLogger log = CustomLogger(className: 'OpenApiService');
  final Dio _dio = NetworkService.create();
  final List<Map<String, String>> messages = [];

  Future<String> claudChat(String prompt) async {
    messages.add({'role': 'user', 'content': prompt});

    try {
      final response = await _dio.post(
        'messages',
        data: {
         "model": "claude-3-haiku-20240307",
          "max_tokens": 2048,
          "messages": messages,
        },
      );

      log.i(response.data);

      String content = response.data['content'][0]['text'].trim();
      messages.add({'role': 'assistant', 'content': content});

      return content;
    } on DioException catch (e) {
      log.e(e.response?.data ?? e.message);

      if (e.response?.statusCode == 401) {
        return 'Error: Invalid API key. Please check your Claude API key.';
      } else if (e.response?.statusCode == 429) {
        return 'Error: Rate limit exceeded. Please try again later.';
      } else {
        return 'Error: ${e.response?.data?['error']?['message'] ?? e.message}';
      }
    } catch (e) {
      log.e(e);
      return 'Error: Something went wrong - $e';
    }
  }
}
