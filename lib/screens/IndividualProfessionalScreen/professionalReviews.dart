// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/firestoreModels/Review.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/ReviewTile.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalScreenData.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:easy_localization/easy_localization.dart';

class ProfessionalReviews extends StatefulWidget {
  ProfessionalReviews({Key key, this.professional}) : super(key: key);
  final Professional professional;

  @override
  _ProfessionalReviewsState createState() => _ProfessionalReviewsState();
}

class _ProfessionalReviewsState extends State<ProfessionalReviews> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Review>>(
      future:
          Provider.of<IndividualProfessionalScreenData>(context, listen: false)
              .getReviews(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return Center(
            child: CircularProgressIndicator(),
          );
        if (snapshot.data == null || snapshot.data.length == 0)
          return Center(
            child: Text(
              NO_REVIEWS.tr(),
              style: TextStyle(
                color: lightGreySubheading,
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.xs),
              ),
            ),
          );
        return ListView.builder(
            shrinkWrap: true,
            physics: ScrollPhysics(),
            itemCount: snapshot.data.length,
            itemBuilder: (_, index) => ReviewTile(
                  review: snapshot.data[index],
                ));
      },
    );
  }
}
