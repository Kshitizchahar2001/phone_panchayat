// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getMatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class IncomingRequestListData extends ChangeNotifier {
  List<MatrimonialFollowRequest> incomingRequests =
      <MatrimonialFollowRequest>[];
  bool loading = true;
  String nextToken;
  MatrimonialProfile currentProfile;

  IncomingRequestListData({MatrimonialProfile currentProfile}) {
    this.currentProfile = currentProfile;
    getIncomingRequestList();
  }

  getIncomingRequestList() async {
    loading = true;
    incomingRequests.clear();
    notifyListeners();

    Map<String, dynamic> receivedRequestData =
        await GetMatrimonialFollowRequest()
            .getFollowRequestByResoponderAndStatus(
                responderId: currentProfile.id ??
                    Services.globalDataNotifier.localUser.id,
                status: MatrimonialRequestStatus.PENDING,
                nextToken: nextToken);
    if (receivedRequestData != null &&
        receivedRequestData["requestList"] != null &&
        receivedRequestData["requestList"].isNotEmpty) {
      incomingRequests.addAll(receivedRequestData["requestList"]);
      nextToken = receivedRequestData["nextToken"];
    }

    loading = false;
    notifyListeners();
  }
}
