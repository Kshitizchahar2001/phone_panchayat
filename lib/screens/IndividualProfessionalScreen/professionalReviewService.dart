// ignore_for_file: file_names, avoid_print, avoid_print, duplicate_ignore, avoid_function_literals_in_foreach_calls

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/firestoreModels/Review.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalScreenData.dart';

class ProfessionalReviewService {
  static final _firestore = FirebaseFirestore.instance;

  static Future<String> addReview(Professional professional, Review review,
      IndividualProfessionalScreenData individualProfessionalScreenData) async {
    if (professional.docId == null) {
      return 'Couldn\'t add Review.';
    }

    final collectionReference = _firestore
        .collection('professionals')
        .doc(professional.profession)
        .collection(professional.profession)
        .doc(professional.docId)
        .collection('reviews');

    final doc = collectionReference.doc(review.id);

    String result = 'An Error Ocurred.';

    await doc.set(review.toJson()).then((value) {
      result = 'Review added Successfully';
      individualProfessionalScreenData.updateRating(review.rating);
    });

    final professionalDoc = _firestore
        .collection('professionals')
        .doc(professional.profession)
        .collection(professional.profession)
        .doc(professional.docId);

    await professionalDoc.update({
      'totalStars': professional.totalStars,
      'totalReviews': professional.totalReviews,
    });

    return result;
  }

  static Future<List<Review>> getReviews(Professional professional) async {
    if (professional.docId == null) return null;

    print('${professional.name}\'s docId is not null');

    final collectionReference = _firestore
        .collection('professionals')
        .doc(professional.profession)
        .collection(professional.profession)
        .doc(professional.docId)
        .collection('reviews');

    List<Review> reviews = [];

    await collectionReference.get().then((reviewsSnapshot) {
      reviewsSnapshot.docs.forEach((reviewSnapshot) {
        var reviewJson = reviewSnapshot.data();
        reviews.add(Review.fromJson(reviewJson));
      });
    });

    return reviews;
  }
}
