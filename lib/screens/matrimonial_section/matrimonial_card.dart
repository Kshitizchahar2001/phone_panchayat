// ignore_for_file: annotate_overrides, prefer_const_constructors, deprecated_member_use

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/call_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/incoming_request_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/helperClasses/MatrimonialHelper.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/sent_request_list_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonialCard extends StatefulWidget {
  const MatrimonialCard({
    Key key,
    @required this.matrimonialProfile,
    @required this.currentUserProfile,
  }) : super(key: key);

  final MatrimonialProfile matrimonialProfile;
  final MatrimonialProfile currentUserProfile;

  @override
  State<MatrimonialCard> createState() => _MatrimonialCardState();
}

class _MatrimonialCardState extends State<MatrimonialCard> {
  IncomingRequestListData incomingRequestListData;
  SentRequestListData sentRequestListData;
  CallListData callListData;
  void initState() {
    incomingRequestListData =
        Provider.of<IncomingRequestListData>(context, listen: false);
    sentRequestListData =
        Provider.of<SentRequestListData>(context, listen: false);
    callListData = Provider.of<CallListData>(context, listen: false);

    super.initState();
  }

  int get age {
    DateTime birthYear =
        DateTime(widget.matrimonialProfile.dateOfBirth.getDateTime().year);
    DateTime today = DateTime.now();
    return ((today.difference(birthYear).inDays) / 365).round();
  }

  @override
  Widget build(BuildContext context) {
    String profileImage = MatrimonialHelper.getProfileImage(
        currentProfile: widget.matrimonialProfile);
    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: context.safePercentWidth * 2,
          vertical: context.safePercentHeight * 1),
      child: InkWell(
        onTap: () {
          context.vxNav.push(Uri.parse(MyRoutes.individualMatch), params: [
            widget.matrimonialProfile,
            incomingRequestListData,
            callListData,
            sentRequestListData
          ]);
        },
        child: Card(
          color: Theme.of(context).cardColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          elevation: 2.0,
          child: Row(
            children: [
              // Image

              CachedNetworkImage(
                fit: BoxFit.cover,
                imageUrl: profileImage,
                imageBuilder: (context, imageProvider) => Container(
                  width: context.safePercentWidth * 35,
                  height: context.safePercentHeight * 20,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                          image: imageProvider, fit: BoxFit.cover)),
                ),
                progressIndicatorBuilder: (context, url, downloadProgress) =>
                    RectangularImageLoading(),
                errorWidget: (context, url, error) => Icon(Icons.error),
              ),

              SizedBox(
                width: context.safePercentWidth * 5,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(
                    height: context.safePercentHeight * 1.2,
                  ),
                  FittedBox(
                    fit: BoxFit.fitWidth,
                    child: Text(
                      widget.matrimonialProfile.name,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m),
                          fontWeight: FontWeight.w500),
                    ),
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 1.2,
                  ),
                  Row(
                    children: [
                      Text(
                        "${AGE.tr()} : ${age ?? " - "}",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                            ),
                      ),
                      SizedBox(
                        width: context.safePercentWidth * 1,
                      ),
                      Text(
                        "${HEIGHT.tr()} : ${widget.matrimonialProfile.height ?? " - "}",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 0.7,
                  ),
                  Text(
                    "${GOTRE.tr()} : ${enumToString(widget.matrimonialProfile.gotre).tr() ?? " - "}",
                    style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                        ),
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 0.7,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on_outlined,
                        color: maroonColor,
                        size: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s),
                      ),
                      SizedBox(
                        width: context.safePercentWidth * 0.5,
                      ),
                      Text(
                        "${MatrimonialHelper.getDistrictName(context: context, profile: widget.matrimonialProfile) ?? "India"}, ${MatrimonialHelper.getStateName(context: context, profile: widget.matrimonialProfile) ?? ""}",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                            ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 1.4,
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 0.8,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
