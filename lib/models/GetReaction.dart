// ignore_for_file: file_names

import 'package:amplify_flutter/amplify_flutter.dart';

import 'Status.dart';

class GetReaction {
  GetReaction({
    this.status,
    this.version,
  });
  Status status;
  int version;

  GetReaction.fromJson(Map<String, dynamic> json)
      : version = json['version'],
        status = enumFromString<Status>(json['status'], Status.values);

  Map<String, dynamic> toJson() =>
      {'version': version, 'status': enumToString(status)};
}
