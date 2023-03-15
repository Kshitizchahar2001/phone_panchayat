// ignore_for_file: overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import '../selectFirestoreIdentifiers.dart';

class District extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  District({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.PANCHAYAT_SAMITI,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = DISTRICT.tr();
  }
  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    // return identifiersList;
    return Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: preceedingIdentifier.selectedItem.id,
      placeType: PlaceType.DISTRICT,
    );
  }
}
