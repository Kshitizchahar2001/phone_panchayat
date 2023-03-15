// ignore_for_file: overridden_fields, annotate_overrides

import 'package:online_panchayat_flutter/enum/identifierType.dart';
import 'package:online_panchayat_flutter/models/Places.dart';

import '../selectFirestoreIdentifiers.dart';

class Ward extends FirestoreItemSelection {
  FirestoreItemSelection preceedingIdentifier;

  Ward({this.preceedingIdentifier})
      : super(
          identifierType: IdentifierType.WARD,
          preceedingIdentifier: preceedingIdentifier,
        ) {
    label = "वार्ड";
    // label = WARD.tr();
  }
  @override
  Future<List<Places>> getIdentifiersFromFirestore() async {
    return <Places>[];
  }
}
