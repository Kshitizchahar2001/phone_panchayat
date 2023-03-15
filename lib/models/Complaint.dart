// ignore_for_file: file_names

import 'package:online_panchayat_flutter/models/AreaType.dart';
import 'package:online_panchayat_flutter/models/PostWithTags.dart';

class Complaint {
  AreaType areaType;
  String municipality;
  int wardNo;
  String panchayatCommittee;
  String villagePanchayat;

  PostWithTags complaint;

  Complaint({
    this.areaType,
    this.municipality,
    this.wardNo,
    this.panchayatCommittee,
    this.villagePanchayat,
    this.complaint,
  });
}
