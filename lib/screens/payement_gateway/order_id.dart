// ignore_for_file: unnecessary_brace_in_string_interps

import 'dart:convert';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/constants/constants.dart';

class RazorpayOrderId {
  Future<String> getOrderId(Map<String, dynamic> options) async {
    http.Response response;

    String basicAuth = 'Basic ' +
        base64Encode(utf8.encode('${razorpayApiKey}:${razorpayApiSecret}'));

    Map<String, String> headers = {
      "Content-type": "application/json; charset=UTF-8",
      "Authorization": basicAuth
    };

    try {
      response = await http.post(Uri.parse(razorpayOrdersApiEndpoint),
          headers: headers, body: json.encode(options));

      var body = json.decode(response.body);

      if (body != null) return body["id"];

      return null;
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);

      return null;
    }
  }
}
