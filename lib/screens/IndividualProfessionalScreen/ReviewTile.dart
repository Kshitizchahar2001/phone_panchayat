// ignore_for_file: file_names, prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/firestoreModels/Review.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';

class ReviewTile extends StatelessWidget {
  ReviewTile({
    Key key,
    this.review,
  }) : super(key: key);

  final Review review;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      shadowColor: Theme.of(context).shadowColor,
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${review.userName}',
              style: Theme.of(context).textTheme.subtitle2.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s),
                  ),
            ),
            RatingBar(
              itemSize: 20.0,
              initialRating: review.rating.toDouble(),
              ignoreGestures: true,
              ratingWidget: RatingWidget(
                empty: Icon(
                  Icons.star_border,
                  color: Colors.amber,
                ),
                full: Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
                half: Icon(
                  Icons.star_half,
                  color: Colors.amber,
                ),
              ),
              onRatingUpdate: (_) {},
            ),
            Text(
              '${review.comment}',
              style: TextStyle(
                color: lightGreySubheading,
                fontWeight: FontWeight.normal,
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.s),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
