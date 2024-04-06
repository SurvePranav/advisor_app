import 'dart:developer';

import 'package:advisor/models/chat_message_model.dart';
import 'package:advisor/models/response_model.dart';
import 'package:advisor/utils/constants.dart';
import 'package:dio/dio.dart';

class ChatRepo {
  static Future<String> chatTextGenerationRepo(
      List<ChatMessageModel> previousMessages) async {
    try {
      Dio dio = Dio();

      final response = await dio.post(
        "https://generativelanguage.googleapis.com/v1beta/models/gemini-1.0-pro:generateContent?key=$apiKey2",
        data: {
          "contents": previousMessages.map((e) => e.toMap()).toList(),
          "generationConfig": {
            "temperature": 0.5,
            "topK": 1,
            "topP": 1,
            "maxOutputTokens": 1024,
            "stopSequences": []
          },
          "safetySettings": [
            {
              "category": "HARM_CATEGORY_HARASSMENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_HATE_SPEECH",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_SEXUALLY_EXPLICIT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            },
            {
              "category": "HARM_CATEGORY_DANGEROUS_CONTENT",
              "threshold": "BLOCK_MEDIUM_AND_ABOVE"
            }
          ]
        },
      );

      if (response.statusCode == 200 && response.statusCode! < 300) {
        ResponseModel responseModel =
            ResponseModel.fromJson(response.data['candidates'].first);
        String generatedString = responseModel.content!.parts!.first.text!;
        return generatedString;
      }
      return '';
    } catch (e) {
      log(e.toString());
    }
    return '';
  }
}
