// ignore_for_file: avoid_print

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/models/ProfessionalReviews.dart';
import 'package:online_panchayat_flutter/models/ReviewResult.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createProfessionalReview.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getProfessionalReviews.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class IndividualProfessionalData extends ChangeNotifier {
  IndividualProfessionalData({
    this.professional,
  }) {
    overallRating = professional.totalStars / professional.totalReviews;
    if (professional.totalReviews == 0) overallRating = 0.0;
  }

  final Professional professional;
  double overallRating;
  int rating = 0;
  bool reviewLoading = true;
  List<ProfessionalReviews> reviews;
  ReviewResult reviewResult;

  loadReviewsFromDatabase() async {
    List<ProfessionalReviews> allReviews = await GetProfessionalReviews()
        .getProfessionalReviews(professionalId: professional.id);

    /// Reversing allReviews so we get items in reversed manner
    reviews = List.from(allReviews.reversed);
    reviewLoading = false;
    notifyListeners();
  }

  updateRating(int rating) async {
    professional.totalStars += rating;
    professional.totalReviews++;

    /// Doing database call which will update Professional profile
    // await UpdateProfessionalRating().updateProfessionalRating(
    //   professionalId: professional.id,
    //   totalReviews: professional.totalReviews,
    //   totalStars: professional.totalStars,
    // );

    ///
    overallRating = professional.totalStars / professional.totalReviews;
    if (professional.totalReviews == 0) overallRating = 0.0;
    // commentEditingController.clear();
    // focusNode.unfocus();
    rating = 0;
    // await loadReviewsFromDatabase();
    print('$rating');
    notifyListeners();
  }

  /// Method used to add a new review in database for professional
  /// Requires a optional paramter content of type string
  Future<ReviewResult> addReview({String content}) async {
    ProfessionalReviews review = ProfessionalReviews(
      professionalId: professional.id,
      rating: rating,
      status: Status.ACTIVE,
      content: content,
    );
    ReviewResult result = await CreateProfessionalReview()
        .createProfessionalReview(
            review: review, userId: Services.globalDataNotifier.localUser.id);
    updateRating(rating);
    return result;
  }

  Future<List<ProfessionalReviews>> getReviews() async {
    return reviews ?? await loadReviewsFromDatabase();
  }

  @override
  void notifyListeners() {
    super.notifyListeners();
  }
}
