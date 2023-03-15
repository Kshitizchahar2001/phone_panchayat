// ignore_for_file: file_names, overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import '../selectFirestoreIdentifiers.dart';

class GramPanchayat extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  GramPanchayat({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.GRAM_PANCHAYAT,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = VILLAGE_PANCHAYAT.tr();
  }
  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    return Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: preceedingIdentifier.selectedItem.id,
      placeType: PlaceType.GRAM_PANCHAYAT,
    );
  }
}
