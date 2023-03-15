// ignore_for_file: annotate_overrides, prefer_const_constructors, deprecated_member_use

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/matrimonialRequestStatus.dart';
import 'package:online_panchayat_flutter/models/MatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/call_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/sent_request_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/matrimonial_image_crousel.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/incoming_request_list_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/helperClasses/MatrimonialHelper.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/matrimonial_card_button.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createMatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/services/gqlQueryServices/getMatrimonialFollowRequest.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class IndividualMatch extends StatefulWidget {
  const IndividualMatch(
      {Key key,
      @required this.profile,
      this.incomingRequestListData,
      this.callListData,
      this.sentRequestListData})
      : super(key: key);

  final MatrimonialProfile profile;
  final IncomingRequestListData incomingRequestListData;
  final SentRequestListData sentRequestListData;
  final CallListData callListData;

  @override
  State<IndividualMatch> createState() => _IndividualMatchState();
}

class _IndividualMatchState extends State<IndividualMatch> {
  bool isIncomingRequest = false;
  MatrimonialRequestStatus callRequestStatus;
  CurrentMatrimonailProfileData _currentProfileData;
  MatrimonialProfile currentMatrimonialProfile;
  bool isCurrentUserProfile = false;

  void initState() {
    _currentProfileData =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);

    currentMatrimonialProfile = _currentProfileData.getMatrimonialProfile;

    isCurrentUserProfile =
        widget.profile.id == Services.globalDataNotifier.localUser.id;

    getCurrentUserFollowRequestStatus();

    super.initState();
  }

  void onSendCallRequest() async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "send_call_request", parameters: {
      "requesterId": currentMatrimonialProfile.id ??
          Services.globalDataNotifier.localUser.id ??
          "",
      "gotre": widget.profile.gotre.toString().split(".").last ?? "",
      "responderId": widget.profile.id ?? "",
    });

    /// Send Follow Request
    bool result = await CreateMatrimonialFollowRequest().createFollowRequest(
        requesterId: currentMatrimonialProfile.id ??
            Services.globalDataNotifier.localUser.id,
        responderId: widget.profile.id);
    if (result) {
      setState(() {
        callRequestStatus = MatrimonialRequestStatus.PENDING;
      });
      widget.sentRequestListData.getSentRequestList();
    }
  }

  void getCurrentUserFollowRequestStatus() async {
    MatrimonialFollowRequest followRequestByCurrentUser =
        await GetMatrimonialFollowRequest()
            .getFollowRequestByRequesterAndResponder(
                requesterId: currentMatrimonialProfile.id,
                responderId: widget.profile.id);

    if (followRequestByCurrentUser != null) {
      setState(() {
        callRequestStatus = followRequestByCurrentUser.status;
      });
      return;
    }

    MatrimonialFollowRequest followRequestByMatrimonialProfile =
        await GetMatrimonialFollowRequest()
            .getFollowRequestByRequesterAndResponder(
                requesterId: widget.profile.id,
                responderId: currentMatrimonialProfile.id);

    if (followRequestByMatrimonialProfile != null) {
      setState(() {
        callRequestStatus = followRequestByMatrimonialProfile.status;
        isIncomingRequest = true;
      });
    }
  }

  void onRejectFollowRequest() async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "reject_call_request", parameters: {
      "requesterId": currentMatrimonialProfile.id ??
          Services.globalDataNotifier.localUser.id ??
          "",
      "gotre": widget.profile.gotre.toString().split(".").last ?? "",
      "responderId": widget.profile.id ?? "",
    });
    bool result = await CreateMatrimonialFollowRequest().updateFollowRequest(
        requesterId: widget.profile.id,
        responderId: currentMatrimonialProfile.id,
        status: MatrimonialRequestStatus.REJECTED);
    if (result) {
      setState(() {
        callRequestStatus = MatrimonialRequestStatus.REJECTED;
      });
      widget.incomingRequestListData.getIncomingRequestList();
    }
  }

  void onAcceptFollowRequest() async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "accept_call_request", parameters: {
      "requesterId": currentMatrimonialProfile.id ??
          Services.globalDataNotifier.localUser.id ??
          "",
      "gotre": widget.profile.gotre.toString().split(".").last ?? "",
      "responderId": widget.profile.id ?? "",
    });
    bool result = await CreateMatrimonialFollowRequest().updateFollowRequest(
        requesterId: widget.profile.id,
        responderId: currentMatrimonialProfile.id,
        status: MatrimonialRequestStatus.APPROVED);
    if (result) {
      setState(() {
        callRequestStatus = MatrimonialRequestStatus.APPROVED;
      });
      widget.incomingRequestListData.getIncomingRequestList();
      widget.callListData.getAllContacts();
    }
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
          DETAILED_INFO,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.safePercentHeight * 2,
            horizontal: context.safePercentWidth * 3),
        child: SingleChildScrollView(
          child: Column(
            children: [
              InkWell(
                onTap: () {
                  context.vxNav
                      .push(Uri.parse(MyRoutes.showMatchImages), params: [
                    widget.profile,
                    isCurrentUserProfile,
                    isIncomingRequest,
                    callRequestStatus,
                    onSendCallRequest,
                    onAcceptFollowRequest,
                    onRejectFollowRequest
                  ]);
                },
                child: MatrimonialImageCrousel(
                    imageList: MatrimonialHelper.getImagesList(
                        profile: widget.profile),
                    crouselHeight: context.safePercentHeight * 37),
              ),
              SizedBox(
                height: context.safePercentHeight * 2,
              ),
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: lightGreySubheading.withOpacity(0.5),
                    ),
                    borderRadius: BorderRadius.circular(15.0)),
                padding: EdgeInsets.only(
                    top: context.safePercentHeight * 2,
                    bottom: context.safePercentHeight * 2,
                    left: context.safePercentWidth * 8),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        widget.profile.name,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontWeight: FontWeight.bold,
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.l)),
                      ),
                      SizedBox(height: context.safePercentHeight * 1.7),
                      InfoRow(heading: CASTE, value: widget.profile.caste),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                        heading: GOTRE,
                        value: enumToString(widget.profile.gotre).tr(),
                      ),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                        heading: HEIGHT,
                        value: widget.profile.height ?? " - ",
                      ),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                        heading: MARITAL_STATUS,
                        value: enumToString(widget.profile.maritalStatus).tr(),
                      ),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                        heading: EDUCATION,
                        value: widget.profile.education != null
                            ? enumToString(widget.profile.education).tr()
                            : " - ",
                      ),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                        heading: OCCUPATION,
                        value: widget.profile.occupation,
                      ),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                          heading: NO_OF_BROTHERS,
                          value: widget.profile.brothers?.total != null
                              ? "${widget.profile.brothers?.total ?? " - "} Brothers"
                              : " - "),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                          heading: NO_OF_SISTERS,
                          value: widget.profile.sisters?.total != null
                              ? "${widget.profile.sisters?.total ?? " - "} Sisters"
                              : " - "),
                      SizedBox(height: context.safePercentHeight * 1),
                      InfoRow(
                          heading: RASHI,
                          value: widget.profile.rashi != null
                              ? enumToString(widget.profile.rashi).tr()
                              : " - "),
                      SizedBox(height: context.safePercentHeight * 1),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.location_on_outlined,
                            color: maroonColor,
                            size: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m),
                          ),
                          SizedBox(width: context.safePercentWidth * 1),
                          Text(
                            "${MatrimonialHelper.getStateName(context: context, profile: widget.profile) ?? "India"}, ${MatrimonialHelper.getDistrictName(context: context, profile: widget.profile) ?? ""}",
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ),
                        ],
                      ),
                    ]),
              ),
              SizedBox(
                height: context.safePercentHeight * 3,
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
                        params: widget.profile);
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
                  onPressed: onSendCallRequest,
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
                  onPressed: () =>
                      MatrimonialHelper.onCallPressed(widget.profile),
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
      ),
    );
  }
}

class InfoRow extends StatelessWidget {
  const InfoRow({Key key, this.heading, this.value}) : super(key: key);

  final String heading;
  final String value;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.headline2.copyWith(
        fontSize: responsiveFontSize(context, size: ResponsiveFontSizes.s));
    return Row(
      children: [
        Text(
          heading ?? " - ",
          style: textStyle,
        ).tr(),
        SizedBox(width: context.safePercentWidth * 1),
        Text(":", style: textStyle),
        SizedBox(width: context.safePercentWidth * 1),
        Text(value ?? " - ", style: textStyle),
      ],
    );
  }
}
