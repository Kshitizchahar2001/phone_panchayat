// ignore: file_names
// ignore_for_file: file_names, duplicate_ignore, overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:easy_localization/easy_localization.dart';

import '../selectFirestoreIdentifiers.dart';

class UserAreaType extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  UserAreaType({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.PANCHAYAT_SAMITI,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = CHOOSE_AREA_TYPE.tr();
    // this.addListener(() {
    //   selectUserAreaIdentifiers.setUserType(value);
    // });
  }

  // validate() {
  //   this.preceedingIdentifier?.validate();
  //   // notifyListeners();
  // }

  @override
  bool get isValid => true;

  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    List<Places> identifiersList = <Places>[
      // Places(
      //   name: RURAL.tr(),
      // ),
      // Places(
      //   name: URBAN.tr(),
      // ),
    ];
    return identifiersList;
  }
}
