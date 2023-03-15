// ignore_for_file: file_names, avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/firestoreModels/Review.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/professionalReviewService.dart';

class IndividualProfessionalScreenData extends ChangeNotifier {
  IndividualProfessionalScreenData({
    this.professional,
    this.commentEditingController,
    this.focusNode,
  }) {
    overallRating = professional.totalStars / professional.totalReviews;
    if (professional.totalReviews == 0) overallRating = 0.0;

    reviews = ProfessionalReviewService.getReviews(professional);
  }

  final Professional professional;
  double overallRating;
  final TextEditingController commentEditingController;
  int rating = 0;
  final FocusNode focusNode;
  Future<List<Review>> reviews;

  updateRating(int rating) {
    professional.totalStars += rating;
    professional.totalReviews++;
    overallRating = professional.totalStars / professional.totalReviews;
    if (professional.totalReviews == 0) overallRating = 0.0;
    commentEditingController.clear();
    focusNode.unfocus();
    rating = 0;
    reviews = ProfessionalReviewService.getReviews(professional);
    print('$rating');
    notifyListeners();
  }

  Future<List<Review>> getReviews() async {
    return await reviews;
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
