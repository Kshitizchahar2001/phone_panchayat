// ignore_for_file: file_names, prefer_const_constructors_in_immutables, deprecated_member_use, prefer_const_constructors, avoid_print

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:geolocator/geolocator.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/firestoreModels/Review.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/individualProfessionalScreenData.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/professionalReviewService.dart';
import 'package:online_panchayat_flutter/screens/IndividualProfessionalScreen/professionalReviews.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class IndividualProfessionalScreen extends StatefulWidget {
  final Professional professional;
  final Location myLocation;

  IndividualProfessionalScreen({
    Key key,
    this.professional,
    this.myLocation,
  }) : super(key: key);

  @override
  _IndividualProfessionalScreenState createState() =>
      _IndividualProfessionalScreenState();
}

class _IndividualProfessionalScreenState
    extends State<IndividualProfessionalScreen> {
  NumberFormat f = NumberFormat('#######0.##');
  TextEditingController commentEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  IndividualProfessionalScreenData individualProfessionalScreenData;

  @override
  void initState() {
    individualProfessionalScreenData = IndividualProfessionalScreenData(
        professional: widget.professional,
        commentEditingController: commentEditingController,
        focusNode: focusNode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: individualProfessionalScreenData,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            widget.professional.name,
            style: Theme.of(context).textTheme.headline2.copyWith(
                fontSize:
                    responsiveFontSize(context, size: ResponsiveFontSizes.m10),
                fontWeight: FontWeight.w500),
          ),
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Flexible(
              child: ListView(
                padding: getPostWidgetSymmetricPadding(context),
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      CircleAvatar(
                        radius: context.safePercentHeight * 6,
                        backgroundColor: Colors.white,
                        foregroundImage: NetworkImage(
                            widget.professional.imageUrl ?? APP_ICON_URL),
                      ),
                      SizedBox(
                        width: context.safePercentWidth * 3,
                      ),
                      Flexible(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              widget.professional.name,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.m),
                                  ),
                            ),
                            Text(
                              widget.professional.profession,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ),
                            Text(
                              '${f.format(Geolocator.distanceBetween(widget.myLocation.lat, widget.myLocation.lon, widget.professional.point.location.lat, widget.professional.point.location.lon) / 1000.0)} ${KMS.tr()}',
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle2
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ).tr(),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: getPostWidgetSymmetricPadding(context),
                    child: Consumer<IndividualProfessionalScreenData>(
                      builder: (context, _, __) => Row(
                        children: [
                          RatingBar(
                            itemSize: 30.0,
                            initialRating: _.overallRating,
                            allowHalfRating: true,
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
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            f.format(_.overallRating),
                            style:
                                Theme.of(context).textTheme.subtitle2.copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                    ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: getPostWidgetSymmetricPadding(context),
                    child: Text(
                      widget.professional.descripton,
                      style: Theme.of(context).textTheme.subtitle2.copyWith(
                            fontWeight: FontWeight.normal,
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                          ),
                    ),
                  ),
                  Consumer<IndividualProfessionalScreenData>(
                    builder: (context, _, child) => ProfessionalReviews(
                      professional: _.professional,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              children: [
                Consumer<IndividualProfessionalScreenData>(
                  builder: (context, _, child) {
                    print(_.rating);
                    return RatingBar(
                      initialRating: _.rating.toDouble(),
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
                      onRatingUpdate: (newRating) {
                        _.rating = newRating.round();
                      },
                    );
                  },
                ),
                Row(
                  children: [
                    Flexible(
                      child: TextFormField(
                        textCapitalization: TextCapitalization.sentences,
                        readOnly: false,
                        controller: individualProfessionalScreenData
                            .commentEditingController,
                        cursorColor: KThemeLightGrey,
                        focusNode: individualProfessionalScreenData.focusNode,
                        showCursor: true,
                        style: Theme.of(context).textTheme.headline4.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                            fontWeight: FontWeight.normal),
                        maxLength: null,
                        maxLines: (true) ? null : 1,
                        decoration: InputDecoration(
                          // isDense: true,
                          border: InputBorder.none,
                          hintText: ADD_COMMENT.tr(),
                          hintStyle: Theme.of(context)
                              .textTheme
                              .headline4
                              .copyWith(
                                  fontSize: responsiveFontSize(context,
                                      size: ResponsiveFontSizes.s),
                                  color: lightGreySubheading),
                          fillColor:
                              Theme.of(context).inputDecorationTheme.fillColor,
                          filled: true,
                          contentPadding:
                              EdgeInsets.fromLTRB(15.0, 10.0, 15.0, 5.0),
                          enabledBorder: textFormFieldBorder(),
                          focusedBorder: textFormFieldBorder(),
                          errorBorder: textFormFieldBorder(),
                          focusedErrorBorder: textFormFieldBorder(),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () async {
                        if (commentEditingController.text.isEmpty ||
                            individualProfessionalScreenData.rating == 0) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                EMPTY_REVIEW.tr(),
                              ),
                            ),
                          );
                        } else {
                          performWriteOperationAfterConditionsCheck(
                            registrationInstructionText:
                                REGISTRATION_MESSAGE_BEFORE_REVIEW_PROFESSIONAL,
                            writeOperation: () async {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(
                                  await ProfessionalReviewService.addReview(
                                    widget.professional,
                                    Review(
                                      userName: Provider.of<GlobalDataNotifier>(
                                              context,
                                              listen: false)
                                          .localUser
                                          .name,
                                      id: Provider.of<GlobalDataNotifier>(
                                              context,
                                              listen: false)
                                          .localUser
                                          .id,
                                      comment: commentEditingController.text,
                                      rating: individualProfessionalScreenData
                                          .rating,
                                    ),
                                    individualProfessionalScreenData,
                                  ),
                                ),
                              ));
                            },
                            context: context,
                          );
                        }
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 8,
                        ),
                        child: Text(
                          POST,
                          style: Theme.of(context).textTheme.headline4.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s)),
                        ).tr(),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  OutlineInputBorder textFormFieldBorder() {
    return OutlineInputBorder(
        borderSide: BorderSide(
          color: Theme.of(context).inputDecorationTheme.fillColor,
          // color: Color.fromRGBO(255, 255, 255, 1),
          width: 0.0,
        ),
        borderRadius: BorderRadius.circular(10));
  }
}
