// ignore_for_file: file_names, avoid_function_literals_in_foreach_calls

import 'package:amazon_cognito_identity_dart_2/cognito.dart';

class LocalCognitoUser {
  String username;
  String name;
  String password;
  bool confirmed = false;
  bool hasAccess = false;

  LocalCognitoUser({this.username, this.name});

  /// Decode user from Cognito LocalCognitoUser Attributes
  factory LocalCognitoUser.fromUserAttributes(List<CognitoUserAttribute> attributes) {
    final user = LocalCognitoUser();
    attributes.forEach((attribute) {
      if (attribute.getName() == 'username') {
        user.username = attribute.getValue();
      } else if (attribute.getName() == 'name') {
        user.name = attribute.getValue();
      } else if (attribute.getName().toLowerCase().contains('verified')) {
        if (attribute.getValue().toLowerCase() == 'true') {
          user.confirmed = true;
        }
      }
    });
    return user;
  }
}