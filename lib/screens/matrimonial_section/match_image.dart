// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/matrimonial_image_crousel.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/helperClasses/MatrimonialHelper.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/matrimonial_card_button.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonialMatchImages extends StatelessWidget {
  const MatrimonialMatchImages(
      {Key key,
      @required this.profile,
      this.isCurrentUserProfile = false,
      this.callRequestStatus,
      this.onSendFollowRequest,
      this.isIncomingRequest = false,
      this.onAcceptFollowRequest,
      this.onRejectFollowRequest})
      : super(key: key);

  final MatrimonialProfile profile;
  final bool isCurrentUserProfile;
  final bool isIncomingRequest;
  final MatrimonialRequestStatus callRequestStatus;
  final Function onSendFollowRequest;
  final Function onAcceptFollowRequest;
  final Function onRejectFollowRequest;

  List<String> getImagesList() {
    List<String> imageList = [];
    if (profile.profileImage != null) {
      imageList.add(profile.profileImage);
    }
    if (profile.images != null && profile.images.isNotEmpty) {
      imageList.addAll(profile.images);
    }

    return imageList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        centerTitle: true,
        elevation: 2.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          PHOTO,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.safePercentHeight * 2,
            horizontal: context.safePercentWidth * 4),
        child: Column(
          children: [
            MatrimonialImageCrousel(
              imageList: getImagesList(),
              crouselHeight: context.safePercentHeight * 60,
            ),
            SizedBox(
              height: context.safePercentHeight * 7,
            ),
            if (isCurrentUserProfile) ...[
              CustomButton(
                iconData: Icons.edit_note_outlined,
                text: EDIT_PROFILE,
                buttonColor: maroonColor,
                autoSize: true,
                borderRadius: 15,
                onPressed: () {
                  context.vxNav.push(
                      Uri.parse(MyRoutes.updateMatrimonialProfile),
                      params: profile);
                },
              )
            ],
            if (!isCurrentUserProfile && callRequestStatus == null) ...[
              CustomButton(
                iconData: FontAwesomeIcons.userFriends,
                text: CALL_REQUEST,
                buttonColor: maroonColor,
                autoSize: true,
                borderRadius: 15,
                onPressed: onSendFollowRequest,
              ),
            ],
            if (!isCurrentUserProfile &&
                callRequestStatus == MatrimonialRequestStatus.APPROVED) ...[
              CustomButton(
                iconData: FontAwesomeIcons.phoneAlt,
                text: CALL,
                buttonColor: maroonColor,
                autoSize: true,
                borderRadius: 15,
                onPressed: () => MatrimonialHelper.onCallPressed(profile),
              ),
            ],
            if (!isCurrentUserProfile &&
                callRequestStatus == MatrimonialRequestStatus.PENDING &&
                !isIncomingRequest) ...[
              CustomButton(
                iconData: Icons.pending,
                textColor: Colors.black,
                text: REQUEST_PENDING,
                buttonColor: lightGreySubheading,
                autoSize: true,
                borderRadius: 15,
                onPressed: null,
              ),
            ],
            if (!isCurrentUserProfile &&
                callRequestStatus == MatrimonialRequestStatus.REJECTED) ...[
              CustomButton(
                iconData: Icons.block,
                text: REQUEST_REJECTED,
                textColor: Colors.black,
                buttonColor: lightGreySubheading,
                autoSize: true,
                borderRadius: 15,
                onPressed: null,
              ),
            ],
            if (callRequestStatus == MatrimonialRequestStatus.PENDING &&
                isIncomingRequest) ...[
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MatrimonialCardButton(
                    onPress: onRejectFollowRequest,
                    buttonColor: lightGreySubheading,
                    text: Text(
                      REJECT,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    icon: Icon(
                      Icons.block,
                      color: Colors.black,
                      size: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                    ),
                  ),
                  MatrimonialCardButton(
                    onPress: onAcceptFollowRequest,
                    buttonColor: maroonColor,
                    text: Text(
                      APPROVE,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    icon: Icon(
                      Icons.arrow_circle_right,
                      color: Colors.white,
                      size: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                    ),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }
}
