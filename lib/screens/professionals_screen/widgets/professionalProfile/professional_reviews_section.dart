// ignore_for_file: implementation_imports, deprecated_member_use, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/individual_professional_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/review.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

class ProfessionalReviewsSection extends StatelessWidget {
  const ProfessionalReviewsSection({Key key}) : super(key: key);
  final numberOfReviewsOnProfileScreen = 3;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        Text(
          REVIEWS,
          style: Theme.of(context).textTheme.headline6,
        ).tr(),
        SizedBox(height: context.safePercentHeight * 1.2),
        Consumer<IndividualProfessionalData>(
          builder: (context, value, child) {
            if (value.reviewLoading)
              return Container();
            else
              return value.reviews.isEmpty
                  ? Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: context.safePercentHeight * 3),
                      child: Center(
                        child: Text(
                          "${NO_REVIEWS_YET.tr()}...",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s10)),
                        ),
                      ),
                    )
                  : Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ListView.separated(
                          itemCount: value.reviews.length >
                                  numberOfReviewsOnProfileScreen
                              ? numberOfReviewsOnProfileScreen
                              : value.reviews.length,
                          shrinkWrap: true,
                          physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            return Review(review: value.reviews[index]);
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
                        if (value.reviews.length >
                            numberOfReviewsOnProfileScreen)
                          ElevatedButton(
                            onPressed: () {
                              context.vxNav.push(
                                  Uri.parse(MyRoutes.seeAllReviews),
                                  params: value.reviews);
                            },
                            child: Text(
                              SEE_ALL_REVIEWS,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                      fontSize: responsiveFontSize(
                                        context,
                                        size: ResponsiveFontSizes.s,
                                      ),
                                      color: Colors.white),
                            ).tr(),
                            style:
                                ElevatedButton.styleFrom(primary: maroonColor),
                          ),
                      ],
                    );
          },
        ),
      ],
    );
  }
}
