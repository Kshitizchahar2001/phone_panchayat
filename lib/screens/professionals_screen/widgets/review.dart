// ignore_for_file: implementation_imports, prefer_const_constructors, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/ProfessionalReviews.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class Review extends StatelessWidget {
  const Review({Key key, @required this.review}) : super(key: key);
  final ProfessionalReviews review;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: context.safePercentHeight * 1),
        Row(
          children: [
            CachedNetworkImage(
              imageUrl: review.user.image,
              imageBuilder: (context, imageProvider) => CircleAvatar(
                maxRadius: 10,
                backgroundImage: imageProvider,
              ),
              placeholder: (context, url) => Shimmer.fromColors(
                child: CircleAvatar(
                    maxRadius: 10, backgroundColor: lightGreySubheading),
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
              ),
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
            SizedBox(width: context.safePercentWidth * 1),
            Expanded(
              child: Text(
                review.user.name,
                style: Theme.of(context).textTheme.headline1.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s)),
              ),
            ),
            SizedBox(width: context.safePercentWidth * 1),
            Text(
              review.createdAt.getDateTimeInUtc().toString().split(" ").first,
              style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s),
                  color: lightGreySubheading),
            )
          ],
        ),
        SizedBox(height: context.safePercentHeight * 0.5),
        Row(
          children: [
            Expanded(
              child: RatingBar(
                itemSize: 20.0,
                initialRating:
                    review.rating != null ? review.rating.toDouble() : 1.0,
                allowHalfRating: true,
                ignoreGestures: true,
                ratingWidget: RatingWidget(
                  empty: Icon(
                    Icons.star_border,
                    color: maroonColor,
                  ),
                  full: Icon(
                    Icons.star,
                    color: maroonColor,
                  ),
                  half: Icon(
                    Icons.star_half,
                    color: maroonColor,
                  ),
                ),
                onRatingUpdate: (_) {},
              ),
            ),
          ],
        ),
        Text(
          review.content,
          style: Theme.of(context).textTheme.headline2.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ),
        SizedBox(height: context.safePercentHeight * 1),
      ],
    );
  }
}
