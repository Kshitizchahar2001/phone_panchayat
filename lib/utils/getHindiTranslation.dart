// ignore_for_file: file_names, avoid_print

import 'dart:convert';

import 'package:http/http.dart' as http;

class GetHindiTranslation {
  

  static Future<String> getHindiFromGoogleTranslateApi(String english) async {
    http.Response response;

    // String url =
    //     "https://translation.googleapis.com/language/translate/v2?target=hi&key=AIzaSyDcKRZRgan_b41mdPkA9iZLfK4X5kf0j6c&q=hello";

    String authority = "translation.googleapis.com";
    String unencodedPath = "/language/translate/v2";
    Map<String, String> queryParameters = {
      'target': 'hi',
      'key': 'AIzaSyDcKRZRgan_b41mdPkA9iZLfK4X5kf0j6c',
      'q': english,
      'source': 'en',
    };

    Uri url = Uri.https(authority, unencodedPath, queryParameters);

    response = await http.post(url);
    var body = jsonDecode(response.body);
    print(body);
    String translatedText = body['data']['translations'][0]['translatedText'];
    print(translatedText);
    return translatedText;
  }
}
