// ignore_for_file: overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/services/services.dart';

import '../selectFirestoreIdentifiers.dart';

class Municipality extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  Municipality({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.MUNICIPALITY,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = MUNICIPALITY.tr();
  }
  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    return await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: preceedingIdentifier.preceedingIdentifier.selectedItem.id,
      placeType: PlaceType.MUNICIPALITY,
    );
  }
}
