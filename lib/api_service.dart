import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_application_2/apj_key.dart';
import 'message.dart';

class ApiService {
  static Future<String> sendMessageToChatGpt(String message) async {
    Uri uri = Uri.parse("https://api.openai.com/v1/chat/completions");

    Map<String, dynamic> body = {
      "model": "gpt-3.5-turbo",
      "messages": [
        {"role": "user", "content": message}
      ],
      "max_tokens": 500,
    };

    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer ${APIKey.OPENAI_API_KEY}",
      },
      body: json.encode(body),
    );

    print(response.body);

    Map<String, dynamic> parsedReponse = json.decode(response.body);

    if (parsedReponse.containsKey('error')) {
      // Обработка случая ошибки
      String errorMessage = parsedReponse['error']['message'];
      print('Ошибка: $errorMessage');
      return 'Ошибка: $errorMessage';
    }

    String reply = parsedReponse['choices'][0]['message']['content'];
    return reply;
  }
}
