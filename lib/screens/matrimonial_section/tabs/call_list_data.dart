// ignore_for_file: prefer_initializing_formals

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getMatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class CallListData extends ChangeNotifier {
  List<MatrimonialFollowRequest> allContacts = <MatrimonialFollowRequest>[];
  List<MatrimonialFollowRequest> incomingRequests =
      <MatrimonialFollowRequest>[];
  List<MatrimonialFollowRequest> sentRequests = <MatrimonialFollowRequest>[];
  bool loading = true;
  String nextToken;
  MatrimonialProfile currentProfile;

  CallListData({MatrimonialProfile currentProfile}) {
    this.currentProfile = currentProfile;
    getAllContacts();
  }

  getAllContacts() async {
    loading = true;
    allContacts.clear();
    incomingRequests.clear();
    sentRequests.clear();
    notifyListeners();
    Map<String, dynamic> sentRequestData = await GetMatrimonialFollowRequest()
        .getFollowRequestByRequesterAndStatus(
            requesterId:
                currentProfile.id ?? Services.globalDataNotifier.localUser.id,
            status: MatrimonialRequestStatus.APPROVED,
            nextToken: nextToken);
    if (sentRequestData != null &&
        sentRequestData["requestList"] != null &&
        sentRequestData["requestList"].isNotEmpty) {
      sentRequests.addAll(sentRequestData["requestList"]);
      allContacts.addAll(sentRequests);
      nextToken = sentRequestData["nextToken"];
    }

    Map<String, dynamic> receivedRequestData =
        await GetMatrimonialFollowRequest()
            .getFollowRequestByResoponderAndStatus(
                responderId: currentProfile.id ??
                    Services.globalDataNotifier.localUser.id,
                status: MatrimonialRequestStatus.APPROVED,
                nextToken: nextToken);
    if (receivedRequestData != null &&
        receivedRequestData["requestList"] != null &&
        receivedRequestData["requestList"].isNotEmpty) {
      incomingRequests.addAll(receivedRequestData["requestList"]);
      allContacts.addAll(incomingRequests);
      nextToken = receivedRequestData["nextToken"];
    }

    loading = false;
    notifyListeners();
  }
}
