// ignore_for_file: implementation_imports, prefer_const_constructors, deprecated_member_use

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/ProfessionalReviews.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/review.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class AllReviewsScreen extends StatelessWidget {
  const AllReviewsScreen({Key key, @required this.allReviews})
      : super(key: key);
  final List<ProfessionalReviews> allReviews;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: maroonColor),
        title: FittedBox(
          child: Text(
            REVIEWS,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.m),
                color: maroonColor),
          ).tr(),
        ),
      ),
      body: Padding(
        padding:
            EdgeInsets.symmetric(horizontal: context.safePercentWidth * 1.7),
        child: Card(
          elevation: 0.0,
          color: Theme.of(context).cardColor,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.safePercentHeight * 1,
                horizontal: context.safePercentWidth * 2.3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: context.safePercentHeight * 1.2),
                allReviews.isEmpty
                    ? Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.safePercentHeight * 3),
                        child: Center(
                          child: Text(
                            "${NO_REVIEWS_YET.tr()}...",
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s10)),
                          ),
                        ),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          ListView.separated(
                            itemCount: allReviews.length,
                            shrinkWrap: true,
                            physics: NeverScrollableScrollPhysics(),
                            itemBuilder: (context, index) {
                              return Review(review: allReviews[index]);
                            },
                            separatorBuilder: (ctx, index) {
                              return Divider(
                                color: lightGreySubheading,
                                indent: 20.0,
                                endIndent: 20.0,
                              );
                            },
                          ),
                          SizedBox(height: context.safePercentHeight * 1),
                        ],
                      ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
