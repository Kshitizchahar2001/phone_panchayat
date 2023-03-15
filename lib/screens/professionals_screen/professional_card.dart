// ignore_for_file: curly_braces_in_flow_control_structures, unnecessary_new, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use, prefer_final_fields, annotate_overrides, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/models/ReviewResult.dart';
import 'package:online_panchayat_flutter/screens/find_professionals_screen.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/individual_professional_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/call_icon.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/custom_snackbar.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/whatsapp_icon.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfessionalCard extends StatelessWidget {
  final Professional professional;
  final Location myLocation;

  const ProfessionalCard(
      {Key key, @required this.professional, @required this.myLocation})
      : super(key: key);

  double get professionalRating {
    if (professional.totalStars == null || professional.totalReviews == null)
      return 0.0;
    if (professional.totalStars == 0) return 0.0;
    return (professional.totalStars / professional.totalReviews).toDouble();
  }

  @override
  Widget build(BuildContext context) {
    NumberFormat f = NumberFormat('#######0.##');
    return Padding(
      padding: getPostWidgetSymmetricPadding(
        context,
        horizontal: 0,
        vertical: 0.0,
      ),
      child: InkWell(
        onTap: () {
          FocusScope.of(context).requestFocus(new FocusNode());
          context.vxNav.push(Uri.parse(MyRoutes.seeProfessionalProfile),
              params: [professional, myLocation]);
        },
        child: AnimatedSize(
          duration: Duration(milliseconds: 250),
          curve: Curves.fastOutSlowIn,
          child: Card(
            color: Theme.of(context).cardColor,
            shadowColor: Theme.of(context).shadowColor,
            elevation: 2,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      CircleAvatar(
                          backgroundColor: lightGreySubheading,
                          backgroundImage: Image.network(
                                  professional.user.image ?? APP_ICON_URL)
                              .image),
                      SizedBox(
                        width: context.safePercentWidth * 2.5,
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              FittedBox(
                                child: Text(
                                  '${capitalise(professional.shopName ?? professional.user.name)}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline2
                                      .copyWith(
                                          fontSize: responsiveFontSize(context,
                                              size: ResponsiveFontSizes.m),
                                          fontWeight: FontWeight.w400),
                                ),
                              ),
                              SizedBox(height: context.safePercentHeight * 0.5),
                              (professional.shopAddressLine == null)
                                  ? Text(
                                      '${capitalise(professional.user.name)}',
                                      style: TextStyle(
                                        color: lightGreySubheading,
                                        fontWeight: FontWeight.normal,
                                        fontSize: responsiveFontSize(context,
                                            size: ResponsiveFontSizes.xs),
                                      ),
                                    )
                                  : Text(
                                      '${capitalise(professional.shopAddressLine)}',
                                      style: TextStyle(
                                        color: lightGreySubheading,
                                        fontWeight: FontWeight.normal,
                                        fontSize: responsiveFontSize(context,
                                            size: ResponsiveFontSizes.xs),
                                      ),
                                    ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(width: context.safePercentWidth * 3),
                      Text(
                        '${f.format(Geolocator.distanceBetween(myLocation.lat, myLocation.lon, professional.shopLocation.lat, professional.shopLocation.lon) / 1000.0)} ${KMS.tr()}',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: lightGreySubheading,
                          fontWeight: FontWeight.normal,
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.xs),
                        ),
                      ).tr(),
                    ],
                  ),
                  SizedBox(height: context.safePercentHeight * 0.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Text(
                        "${professionalRating.toStringAsFixed(1)} / 5",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                            color: lightGreySubheading),
                      ),
                      SizedBox(width: context.safePercentWidth * 2),
                      Expanded(
                        child: RatingBar(
                          itemSize: 30.0,
                          initialRating: professionalRating,
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
                      CallIcon(professional: professional),
                      WhatsappIcon(professional: professional),
                    ],
                  ),
                  SizedBox(height: context.safePercentHeight * 0.8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(
                        "${WORK_EXPERIENCE.tr()} : ${professional.workExperience} ${YEAR.tr()}",
                        style: Theme.of(context).textTheme.headline2.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                            ),
                      ).tr(),
                    ],
                  ),
                  // SizedBox(height: context.safePercentHeight * 0.8),
                  if (professional.id !=
                      Services.globalDataNotifier.localUser.id)
                    ChangeNotifierProvider<IndividualProfessionalData>(
                      create: (_) => IndividualProfessionalData(
                          professional: professional),
                      builder: (context, child) => CardComment(
                        professional: professional,
                      ),
                    ),
                  // CardComment(
                  //   professional: professional,
                  // ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class CardComment extends StatefulWidget {
  const CardComment({
    Key key,
    @required this.professional,
  }) : super(key: key);

  final Professional professional;

  @override
  State<CardComment> createState() => _CardCommentState();
}

class _CardCommentState extends State<CardComment> {
  String commentText;
  final TextEditingController _commentTextController = TextEditingController();
  bool showSubmitButton = false;
  FocusNode _textFieldFocusNode = FocusNode();
  IndividualProfessionalData _individualProfessionalData;

  void initState() {
    _individualProfessionalData =
        Provider.of<IndividualProfessionalData>(context, listen: false);
    super.initState();
  }

  void dispose() {
    _textFieldFocusNode.dispose();
    _commentTextController.dispose();
    super.dispose();
  }

  void textFieldValueOnChanged(value) {
    commentText = value;
    if (commentText.trim().isNotBlank) {
      setState(() {
        showSubmitButton = true;
      });
    } else {
      setState(() {
        showSubmitButton = false;
      });
    }
  }

  void _showRatingAlertDialog(BuildContext context) {
    bool inValidRating = false;
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (ctx) {
          return StatefulBuilder(builder: (context, setState) {
            return AlertDialog(
              title: Center(
                child: Text(
                  RATE_PROFESSIONAL,
                  style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m10)),
                ).tr(),
              ),
              content: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (inValidRating)
                    Text(
                      INVALID_RATING,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                            color: Colors.red,
                          ),
                    ).tr(),
                  RatingBar(
                    initialRating: 0.0,
                    minRating: 1.0,
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
                    onRatingUpdate: (newRating) {
                      _individualProfessionalData.rating = newRating.round();
                      print(newRating);
                    },
                  ),
                ],
              ),
              actions: <Widget>[
                TextButton(
                  child: const Text(SUBMIT).tr(),
                  onPressed: () async {
                    performWriteOperationAfterConditionsCheck(
                        registrationInstructionText:
                            REGISTRATION_MESSAGE_BEFORE_POST_CREATION,
                        writeOperation: () async {
                          /// Check for inValid rating which is 0
                          if (_individualProfessionalData.rating == 0.0) {
                            setState(() {
                              inValidRating = true;
                            });
                            return;
                          }

                          /// Add reviews
                          ReviewResult result =
                              await _individualProfessionalData.addReview(
                                  content: commentText);
                          showSnackBar(result);

                          setState(() {
                            showSubmitButton = false;
                          });
                          Navigator.of(context).pop();
                        },
                        context: context);
                  },
                ),
              ],
            );
          });
        });
  }

  void showSnackBar(ReviewResult result) {
    if (result == ReviewResult.ADDED)
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(
          context,
          REVIEW_ADDED_SUCCESSFULLY,
          Icon(Icons.check_circle, color: Colors.white)));
    else if (result == ReviewResult.UPDATED)
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(
          context,
          REVIEW_UPDATED_SUCCESFFULY,
          Icon(Icons.update_outlined, color: Colors.white)));
    else
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(
          context, REVIEW_ADD_ERROR, Icon(Icons.error, color: Colors.white)));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashFactory: NoSplash.splashFactory,
      focusColor: Colors.transparent,
      onTap: () {
        _textFieldFocusNode.hasFocus
            ? _textFieldFocusNode.unfocus()
            : _textFieldFocusNode.requestFocus();
      },
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: context.safePercentHeight * 1),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "${COMMENTS.tr()} : ",
                style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s),
                    ),
              ).tr(),
              SizedBox(width: context.safePercentWidth * 1),
              Expanded(
                child: TextField(
                  controller: _commentTextController,
                  focusNode: _textFieldFocusNode,
                  onChanged: textFieldValueOnChanged,
                  maxLines: null,
                  cursorColor: maroonColor,
                  decoration: InputDecoration(
                    hintText: ADD_COMMENT.tr(),
                    isDense: true,
                    contentPadding: EdgeInsets.symmetric(
                      vertical: 3,
                      horizontal: 5,
                    ),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightGreySubheading),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: maroonColor),
                    ),
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: lightGreySubheading),
                    ),
                  ),
                  keyboardType: TextInputType.multiline,
                ),
              ),
              SizedBox(width: context.safePercentWidth * 1.5),
              // if (showSubmitButton)
              AnimatedOpacity(
                duration: Duration(milliseconds: 1000),
                opacity: showSubmitButton ? 1.0 : 0.0,
                curve: Curves.fastOutSlowIn,
                child: ElevatedButton(
                  onPressed: showSubmitButton
                      ? () {
                          _textFieldFocusNode.unfocus();
                          _showRatingAlertDialog(
                            context,
                          );
                          _commentTextController.clear();
                        }
                      : null,
                  child: Text(SUBMIT).tr(),
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.all(0),
                    primary: maroonColor,
                    textStyle: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                          color: Colors.white,
                        ),
                  ),
                ),
              )
            ]),
      ),
    );
  }
}
