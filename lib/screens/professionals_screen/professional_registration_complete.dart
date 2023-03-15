// ignore_for_file: annotate_overrides, prefer_const_constructors, deprecated_member_use, unnecessary_string_interpolations

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/find_professionals_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/services_constant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfessionalRegistrationComplete extends StatefulWidget {
  const ProfessionalRegistrationComplete(
      {Key key, @required this.registrationStatus})
      : super(key: key);
  final bool registrationStatus;

  @override
  State<ProfessionalRegistrationComplete> createState() =>
      _ProfessionalRegistrationCompleteState();
}

class _ProfessionalRegistrationCompleteState
    extends State<ProfessionalRegistrationComplete> {
  String image;
  FindProfessionalsData _findProfessionalsData;
  void initState() {
    image = widget.registrationStatus
        ? registrationSuccessGIF
        : registrationFailedGIF;

    /// Call _findProfessionalsData.getUser() to show the current user profile
    _findProfessionalsData =
        Provider.of<FindProfessionalsData>(context, listen: false);
    _findProfessionalsData.isRegisteredAsProfessional = null;
    _findProfessionalsData.getProfessional();
    super.initState();
  }

  void dispose() {
    // image.evict();
    CachedNetworkImage.evictFromCache(image);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String headingText = widget.registrationStatus ? "Welcome" : "Error...";
    String subHeadingText = widget.registrationStatus
        ? "You have taken first step to grow your bussiness. We are always ready to help you with your bussiness"
        : "There was some error ";

    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popUntil((route) => route.isFirst);
          },
        ),
        centerTitle: true,
        elevation: 2.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          "Registration Complete",
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.safePercentHeight * 1,
            horizontal: context.safePercentWidth * 1.7),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // SizedBox(height: context.safePercentHeight * 1.2),
            Card(
              color: Theme.of(context).cardColor,
              elevation: 0.0,
              child: Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      vertical: context.safePercentHeight * 0.8,
                      horizontal: context.safePercentWidth * 1.8),
                  child: Column(
                    children: [
                      Center(
                        child: Container(
                          padding: EdgeInsets.symmetric(
                              vertical: context.safePercentHeight * 1),
                          height: 150,
                          width: 150,
                          child:
                              // Image.network(
                              //     'https://firebasestorage.googleapis.com/v0/b/phone-p-312802.appspot.com/o/serviceImages%2Fverified5.gif?alt=media&token=74e4ecb8-10cc-488f-9587-095ebea7ae7e',
                              //     loadingBuilder:
                              //         (context, child, loadingProgress) {
                              //   if (loadingProgress == null) return child;
                              //   return RectangularImageLoading();
                              // }),
                              CachedNetworkImage(
                            imageUrl: image,
                            progressIndicatorBuilder:
                                (context, url, downloadProgress) {
                              return RectangularImageLoading();
                            },
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ),
                      ),
                      SizedBox(height: context.safePercentHeight * 1.2),
                      Text(
                        "$headingText ${Services.globalDataNotifier.localUser.name ?? ''}",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m),
                            color: widget.registrationStatus
                                ? maroonColor
                                : Colors.red,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: context.safePercentHeight * 1.2),
                      Center(
                        child: Text(
                          "$subHeadingText",
                          style: Theme.of(context).textTheme.headline1.copyWith(
                                fontSize: responsiveFontSize(context,
                                    size: ResponsiveFontSizes.m),
                                color: Colors.black,
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),

            SizedBox(height: context.safePercentHeight * 1.2),
            ElevatedButton(
              onPressed: () {
                FlutterShareMe().shareToWhatsApp(
                  imagePath: "assets/images/uttar_pradesh_image_2.jpg",
                  msg: referralSentence + "\n" + whatsappShareDynamicLink,
                );
              },
              child: Text("Invite Friends"),
              style: ElevatedButton.styleFrom(primary: maroonColor),
            ),
          ],
        ),
      ),
    );
  }
}
