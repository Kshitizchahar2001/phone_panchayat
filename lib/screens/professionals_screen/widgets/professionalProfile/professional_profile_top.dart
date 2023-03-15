// ignore_for_file: implementation_imports, prefer_const_constructors, curly_braces_in_flow_control_structures, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/src/public_ext.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/services_constant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/call_icon.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/custom_snackbar.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/whatsapp_icon.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/src/extensions/context_ext.dart';

import '../../individual_professional_data.dart';

class ProfessionalProfileTop extends StatelessWidget {
  const ProfessionalProfileTop(
      {Key key,
      @required this.professional,
      @required this.isCurrentUserIsProfessional})
      : super(key: key);

  final Professional professional;
  final bool isCurrentUserIsProfessional;

  String get _bannerImage {
    String imageUrl;
    imageUrl =
        professional.workImages != null && professional.workImages.isNotEmpty
            ? professional.workImages[0]
            : registerPageBannerImage;
    return imageUrl;
  }

  void editProfileOnClick(BuildContext context) async {
    bool result = await context.vxNav.waitAndPush(
        Uri.parse(MyRoutes.editProfessional),
        params: professional);
    if (result)
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(
          context,
          PROFILE_UPDATED_SUCCESSFULLY,
          Icon(Icons.check_circle, color: Colors.white)));
    else
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(context,
          PROFILE_UPDATE_FAILED, Icon(Icons.error, color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 1.7),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(10.0), topRight: Radius.circular(10.0)),
        ),
        elevation: 0.0,
        color: Theme.of(context).cardColor,
        child: Column(
          children: [
            Stack(
              clipBehavior: Clip.none,
              alignment: Alignment.center,
              children: [
                CachedNetworkImage(
                  imageUrl: _bannerImage,
                  imageBuilder: (context, imageBuilder) {
                    return Container(
                        height: context.safePercentHeight * 28,
                        width: double.infinity,
                        margin: EdgeInsets.only(
                            bottom: context.safePercentHeight * 10),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: imageBuilder,
                          ),
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(10.0),
                              topRight: Radius.circular(10.0)),
                        ));
                  },
                  placeholder: (context, url) => RectangularImageLoading(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
                Positioned(
                  top: context.safePercentHeight * 28 -
                      context.safePercentHeight * 8,
                  child: CircleAvatar(
                    radius: context.safePercentHeight * 8.5,
                    backgroundColor: Colors.white,
                    child: CircleAvatar(
                      radius: context.safePercentHeight * 8,
                      backgroundImage:
                          Image.network(professional.user.image).image,
                    ),
                  ),
                ),
              ],
            ),
            Center(
              child: Text(
                professional.user.name,
                style: Theme.of(context).textTheme.headline2.copyWith(
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.m10)),
              ),
            ),
            Consumer<IndividualProfessionalData>(
              builder: (context, _, __) => Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  RatingBar(
                    itemSize: 30.0,
                    initialRating: _.overallRating,
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
                  SizedBox(
                    width: context.safePercentWidth * 7,
                  ),
                  Text(
                    '${_.overallRating.toStringAsFixed(1)} / 5',
                    style: Theme.of(context).textTheme.subtitle2.copyWith(
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                        ),
                  ),
                  SizedBox(height: context.safePercentHeight * 1.2),
                ],
              ),
            ),

            /// Showing edit profile button conditonally
            Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.safePercentWidth * 1.5,
                  vertical: context.safePercentHeight * 1),
              child: isCurrentUserIsProfessional
                  ? CustomButton(
                      text: EDIT_PROFILE.tr(),
                      onPressed: () => editProfileOnClick(context),
                      edgeInsets: EdgeInsets.symmetric(vertical: 5),
                      borderRadius: 5,
                      iconData: FontAwesomeIcons.edit,
                      textColor: maroonColor,
                      buttonColor: Theme.of(context).cardColor,
                      boxShadow: [],
                      boxBorder: Border.all(width: 0.4, color: maroonColor),
                    )
                  : Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        CallIcon(professional: professional),
                        SizedBox(width: context.safePercentWidth * 5),
                        WhatsappIcon(professional: professional),
                      ],
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
