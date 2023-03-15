// ignore_for_file: file_names, overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import '../selectFirestoreIdentifiers.dart';

class PanchayatSamiti extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  PanchayatSamiti({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.PANCHAYAT_SAMITI,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = PANCHAYAT_COMMITTEE.tr();
  }
  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    return Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: preceedingIdentifier.preceedingIdentifier.selectedItem.id,
      placeType: PlaceType.PANCHAYAT_SAMITI,
    );
  }
}
