// ignore_for_file: file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';

// Init firestore and geoFlutterFire

class RegisterProfessional {
  static final _firestore = FirebaseFirestore.instance;

  static Future<void> registerProfessional(Professional professional) async {
    // Map professionalJson = professional.toJson();
    // professionalJson['point'] = myLocation.data;

    var collectionReference = _firestore
        .collection('professionals')
        .doc(professional.profession)
        .collection(professional.profession);

    var doc = (professional.docId == null)
        ? collectionReference.doc()
        : collectionReference.doc(professional.docId);

    professional.docId = doc.id;
    Map professionalJson = professional.toJson();

    await doc.set(professionalJson);

    // await collectionReference.add(professionalJson);
  }

  static Future<void> removeProfessional(Professional professional) async {
    var collectionReference = _firestore
        .collection('professionals')
        .doc(professional.profession)
        .collection(professional.profession);

    await collectionReference.doc(professional.docId).delete();
  }

  static Future<void> addProfession({
    String profession,
    String en,
    String hi,
  }) async {
    await _firestore.collection('professionals').doc(profession).set({
      'id': profession,
      'en': en ?? profession,
      'hi': hi ?? profession,
    });
  }
}
