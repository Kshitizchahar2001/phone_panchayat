// ignore_for_file: overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import '../selectFirestoreIdentifiers.dart';

class State extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  State({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.PANCHAYAT_SAMITI,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = STATE.tr();
  }
  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    // return identifiersList;
    List<Places> places = await Services
        .gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: 'country1',
      placeType: PlaceType.STATE,
    );
    places.removeWhere(
        (element) => element.name_hi == null || element.name_hi == '');
    return places;
  }
}
