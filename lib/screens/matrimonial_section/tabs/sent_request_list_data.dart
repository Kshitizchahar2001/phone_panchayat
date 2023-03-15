// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getMatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class SentRequestListData extends ChangeNotifier {
  List<MatrimonialFollowRequest> sentRequests = <MatrimonialFollowRequest>[];
  bool loading = true;
  String nextToken;
  MatrimonialProfile currentProfile;

  SentRequestListData({MatrimonialProfile currentProfile}) {
    this.currentProfile = currentProfile;
    getSentRequestList();
  }

  getSentRequestList() async {
    loading = true;
    sentRequests.clear();
    notifyListeners();
    Map<String, dynamic> sentRequestData = await GetMatrimonialFollowRequest()
        .getFollowRequestByRequesterAndStatus(
            requesterId:
                currentProfile.id ?? Services.globalDataNotifier.localUser.id,
            status: MatrimonialRequestStatus.PENDING,
            nextToken: nextToken);
    if (sentRequestData != null &&
        sentRequestData["requestList"] != null &&
        sentRequestData["requestList"].isNotEmpty) {
      sentRequests.addAll(sentRequestData["requestList"]);
      nextToken = sentRequestData["nextToken"];
    }

    loading = false;
    notifyListeners();
  }
}
