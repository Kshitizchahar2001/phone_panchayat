// ignore_for_file: file_names, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/models/DesignatedUserType.dart';
import 'package:flutter/material.dart';

import 'Identifiers/gramPanchayat.dart';
import 'Identifiers/municipality.dart';
import 'Identifiers/panchayatSamiti.dart';
import 'Identifiers/ward.dart';
import 'selectFirestoreIdentifiers.dart';

abstract class UserTypeByArea {
  FirestoreItemSelection itemSelection1;
  FirestoreItemSelection itemSelection2;

  DesignatedUserType designatedUserType;
  String userTypeValue;
  bool isInitialised = false;
  void initialise();

  validate() {
    itemSelection1.validate();
    itemSelection2.validate();
  }

  bool allValid() {
    return itemSelection1.isValid && itemSelection2.isValid;
  }
}

class Urban extends UserTypeByArea {
  FirestoreItemSelection userAreaType;
  Urban({@required this.userAreaType}) {
    userTypeValue = URBAN.tr();
    designatedUserType = DesignatedUserType.URBAN;
  }
  initialise() {
    itemSelection1 = Municipality(preceedingIdentifier: userAreaType);
    itemSelection2 = Ward(preceedingIdentifier: itemSelection1);
  }
}

class Rural extends UserTypeByArea {
  FirestoreItemSelection userAreaType;

  Rural({@required this.userAreaType}) {
    userTypeValue = RURAL.tr();
    designatedUserType = DesignatedUserType.RURAL;
  }
  initialise() {
    itemSelection1 = PanchayatSamiti(preceedingIdentifier: userAreaType);
    itemSelection2 = GramPanchayat(preceedingIdentifier: itemSelection1);
  }
}
