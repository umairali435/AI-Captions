import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart'; // Add this import

class ApiService {
  final Dio _dio = Dio();
  final String _apiKey = dotenv.env['API_KEY'] ?? ''; // Load API key from .env

  Future<Response> fetchData(String prompt) async {
    try {
      final response = await _dio.post(
        "https://api.groq.com/openai/v1/chat/completions",
        data: {
          "model": "llama-3.3-70b-versatile",
          "response_format": {"type": "json_object"},
          "messages": [
            {
              "role": "user",
              "content": prompt,
            },
          ],
        },
        options: Options(
          headers: {'Authorization': 'Bearer $_apiKey'},
          contentType: Headers.jsonContentType,
        ),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
