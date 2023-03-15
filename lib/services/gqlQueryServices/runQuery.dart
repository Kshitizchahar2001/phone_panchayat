// ignore_for_file: unused_import, file_names, avoid_print, unnecessary_new, unnecessary_string_interpolations

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:amazon_cognito_identity_dart_2/sig_v4.dart';
import 'package:http/http.dart' as http;
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'dart:convert';
import 'dart:developer';

class RunQuery {
  static AuthenticationService authenticationService;

  static Future<http.Response> runQuery(
      {@required String operationName,
      @required String mutationDocument,
      @required Map<String, dynamic> variables}) async {
    http.Response response;
    SigV4Request signedRequest;

    // String oldSessionToken =
    //     "IQoJb3JpZ2luX2VjEMT//////////wEaCmFwLXNvdXRoLTEiRzBFAiBmZ5hlwwO+rKoedJcgvIQNvjhy6diZD6OnYH2Q6mMGFwIhAP17njeg2Juc93FKyU+RR56V4of/nCXmZ9sGEGpLMfWWKtMECN3//////////wEQABoMMTA4NjcxMTc3MDg0Igx34eZ5q/O4dk0/HqgqpwTKcm7R3d5ThtlLyz89jpL83zA8uwOhWBTzEXAtL8cga+W6yStsCEUUxBqHe62BsXk5K1pdOLOe5cR7WrAVTXIsng93xHtPjDHk9VR16N9R85q/pSQLNotbw8FV5LPffy/tu9h6sMT1T/HETP4QO25t5Xgizyo+HEGaaCFxNPoy28wD0F1HEniGB8NoB97FaM3t0xA2vwW1sd3qGJDmDmCA0f3gg/btnLECF9PUVaOZKzPhN95f9c/IBAHxatDueGnq2HhqaCtlijFvuQTZLrdw7/e2twgyOwUeXm+XL7bSCNc9fgcYldR+ogr3SNJJHkFJZId61Dx7UQVl2zXJvBkNu78Jssc32UVf+KwCQ2bOZwj8vrElHk09m+HC31NEA/e+ac2JBxfUd0CoS180EfyMeaNLsdsjsa/hqS6XJRn7vUqN0F870G4Ne4ve5Bv9jUgovoUnZ5nj+Giwldwq1Cb28OqasK970q0+L24mueXeia4+1PNpfRkCdiczlv5T4zoewQS1IpLEyrnPSP9XVLCFQ/4WjXNbDi7QGCEihiXnhBUhHu+A3lLi6k5Vw3F16YXkxbhup8MoGzaG6Pjq5DScdz9wch/yVvvj9PLYvJTlnalhX2udWXhgglBXCrBxOKCcsrbEOjfF78UIh9yOsyhx1b/cEG7w9BUduJPErE2V3KAnETQhi0x91IomIYnXYLRJuC+hVbX8nCjESW8tFRnl4hrkxzTw9jDi1NCIBjqFAqEqmZEC1gm7sPC1kfruKF/O6zCFw5sI2QQeclIrlZnndUVNGGrZGpN3w3fWKG6QFcpZot1iQPnHBRbFep6aQASm+MAXuP0loy9CAVSOEZMlp+DuxaDgFqGuraWFLXqwTtgq1W5dEdfw22Ivx1gRCY/ixhhOtsT8EtFOkGfnkYNA3+sbe65ernWVnDGlDwk19lR6SF3NjcJKf7ReKiRukaDFmoBsicHw+w7qQ6Z8eO+TVI7DDaw8DBJpIWQ7wOpiuxCaZplRI+SoayPJATIl809hRagloPiI30C1DRC9gpwbEEz0Vc0orVEvvlQw++hvktRJUYDoOHJeBelclHU36sT5jzvU+A==";
    // authenticationService.awsSigV4Client.sessionToken = oldSessionToken;

    //
    signedRequest = _getSignedRequest(
      authenticationService: authenticationService,
      operationName: operationName,
      mutationDocument: mutationDocument,
      variables: variables,
    );

    try {
      response = await http.post(Uri.parse(signedRequest.url),
          headers: signedRequest.headers, body: signedRequest.body);
      if (operationName != "CreateView" &&
          await _isTokenRenewedAfterExpiration(
            response: response,
            operationName: operationName,
            variables: variables,
          )) {
        signedRequest = _getSignedRequest(
          authenticationService: authenticationService,
          operationName: operationName,
          mutationDocument: mutationDocument,
          variables: variables,
        );
        response = await http.post(Uri.parse(signedRequest.url),
            headers: signedRequest.headers, body: signedRequest.body);

        // retry ;
      }
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }

    return response;
  }

  static Future<bool> _isTokenRenewedAfterExpiration({
    @required http.Response response,
    @required String operationName,
    @required Map<String, dynamic> variables,
  }) async {
    var body = jsonDecode(response.body);
    if (body["errors"] == null) return false;
    List errors = body["errors"];
    for (int i = 0; i < errors.length; i++) {
      var error = errors[i];
      try {
        FirebaseCrashlytics.instance.log(
            "Error in dynamo db query: ${error.toString()} operation name : $operationName , variables : $variables ");
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError("run query line 67" + e, s);
      }
      print(error);
      if (error["errorType"] == "ExpiredTokenException" ||
          error["errorType"] == "UnrecognizedClientException") {
        print("encountered token expire error");
        await authenticationService.initialiseAuthenticationService();
        AnalyticsService.firebaseAnalytics
            .logEvent(name: "token_renewed", parameters: {
          "error": error["errorType"],
        });
        return true;
      }
    }
    return false;
  }

  static SigV4Request _getSignedRequest(
      {@required AuthenticationService authenticationService,
      @required String operationName,
      @required String mutationDocument,
      @required Map<String, dynamic> variables}) {
    // log(authenticationService.awsSigV4Client.sessionToken);
    return new SigV4Request(
      authenticationService.awsSigV4Client,
      method: 'POST',
      path: '/graphql',
      headers: new Map<String, String>.from(
          {'Content-Type': 'application/graphql; charset=utf-8'}),
      body: {
        'operationName': operationName,
        'query': mutationDocument,
        'variables': jsonEncode(variables)
      },
    );
  }

  static Future<http.Response> runQueryWithAPIKey({
    @required Map variables,
    @required String mutationDocument,
    @required String operationName,
  }) async {
    http.Response response;
    var url =
        'https://obmow6rk7fd3pkzlkmndty5uam.appsync-api.ap-south-1.amazonaws.com/graphql';
    var apiKey = 'da2-qpjr266gpjdhpb2jsrnqu4mymq';
    var encodedJson = jsonEncode({
      'query': mutationDocument,
      'variables': jsonEncode(variables),
      'operationName': operationName,
    });
    response = await http.post(Uri.parse(url),
        body: encodedJson, headers: {'X-Api-Key': '$apiKey'});

    // var body = jsonDecode(response.body);
    // print(body.toString());
    return response;
  }
}
