// ignore_for_file: prefer_const_constructors, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileCompleteDialog extends StatelessWidget {
  const ProfileCompleteDialog({Key key, @required this.currentProfile})
      : super(key: key);

  final MatrimonialProfile currentProfile;

  Widget _buildChild(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: maroonColor,
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(16), topRight: Radius.circular(16)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          /// Add a network image
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.rectangle,
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(16), topRight: Radius.circular(16)),
            ),
            height: context.safePercentHeight * 18,
            width: double.infinity,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.safePercentHeight * 1.5),
              child: CachedNetworkImage(
                fit: BoxFit.fitHeight,
                imageUrl: matrimonial_dialog_image,
                imageBuilder: (context, imageProvider) => Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.fitHeight)),
                ),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),
            ),
          ),

          Padding(
            padding:
                EdgeInsets.symmetric(horizontal: context.safePercentWidth * 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: context.safePercentHeight * 2,
                ),
                Text(UPDATE_PROFILE.tr() + "!!",
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m10),
                        fontWeight: FontWeight.bold,
                        color: Colors.white)),
                SizedBox(
                  height: context.safePercentHeight * 1.7,
                ),
                Text(MATRIMONIAL_UPDATE_PROFILE_MESSAGE.tr(),
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m),
                        color: Colors.white)),
                SizedBox(
                  height: context.safePercentHeight * 3,
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text(CANCEL,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                      fontWeight: FontWeight.bold,
                                      color: lightGreySubheading))
                          .tr(),
                    ),
                    SizedBox(
                      width: context.safePercentWidth * 2,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(primary: Colors.white),
                      onPressed: () {
                        context.vxNav
                            .push(Uri.parse(MyRoutes.updateMatrimonialProfile),
                                params: currentProfile)
                            .then((value) => Navigator.of(context).pop());
                      },
                      child: Text(PROFILE,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                      fontWeight: FontWeight.bold,
                                      color: maroonColor))
                          .tr(),
                    ),
                  ],
                ),
                SizedBox(
                  height: context.safePercentHeight * 1,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      elevation: 0.0,
      backgroundColor: Colors.transparent,
      child: _buildChild(context),
    );
  }
}
