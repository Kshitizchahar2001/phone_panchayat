import 'package:amplify_datastore_plugin_interface/amplify_datastore_plugin_interface.dart';
import 'package:online_panchayat_flutter/models/Status.dart';

class FollowRelationQueryData {
  final bool success;
  final int version;
  final TemporalDateTime timestamp;
  final bool recordFound;
  final Status status;

  FollowRelationQueryData({
    this.success,
    this.version,
    this.timestamp,
    this.recordFound,
    this.status,
  });
}
