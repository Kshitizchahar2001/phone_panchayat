// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/individual_professional_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_details_card.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_personal_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_profile_top.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_reviews_section.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_shop_adddress_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_shop_description_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_work_images.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/professionalProfile/professional_work_speciality.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class IndividualProfessional extends StatefulWidget {
  final Professional professional;
  final Location myLocation;

  IndividualProfessional({
    Key key,
    this.professional,
    this.myLocation,
  }) : super(key: key);

  @override
  _IndividualProfessionalState createState() => _IndividualProfessionalState();
}

class _IndividualProfessionalState extends State<IndividualProfessional> {
  NumberFormat f = NumberFormat('#######0.##');
  TextEditingController commentEditingController = TextEditingController();
  FocusNode focusNode = FocusNode();
  IndividualProfessionalData _individualProfessionalData;
  bool _isCurrentUserIsProfessional;

  @override
  void initState() {
    _individualProfessionalData = IndividualProfessionalData(
      professional: widget.professional,
    );

    _individualProfessionalData.loadReviewsFromDatabase();
    _isCurrentUserIsProfessional =
        Services.globalDataNotifier.localUser.id == widget.professional.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: _individualProfessionalData,
      child: Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: maroonColor),
          title: FittedBox(
            child: Text(
              '${widget.professional.shopName ?? widget.professional.user.name}',
              style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m),
                  color: maroonColor),
            ),
          ),
        ),
        body: ListView(
          children: [
            /// Top section of professional profile page which shows banner images
            /// and profile image with the name and current rating of professional
            ProfessionalProfileTop(
              professional: widget.professional,
              isCurrentUserIsProfessional: _isCurrentUserIsProfessional,
            ),

            /// Personal Details card
            /// Only showing this card if current user is a professiona
            /// Contains mobile number and whatsapp number of user
            if (_isCurrentUserIsProfessional)
              ProfessionalProfileSectionWithPadding(
                childWidget: ProfessionalPersonalDetails(
                  mobileNumber: widget.professional.mobileNumber,
                  whatsappNumber: widget.professional.whatsappNumber,
                ),
              ),

            /// Shop Address Card
            /// Shows address line of shop and distance from current user
            ProfessionalProfileSectionWithPadding(
                childWidget: ProfessionalShopAddressDetails(
              isCurrentUserIsProfessional: _isCurrentUserIsProfessional,
              shopAddressLine: widget.professional.shopAddressLine,
              shopLocation: widget.professional.shopLocation,
              userLocation: widget.myLocation,
            )),

            /// Shop Description Card
            /// Shows description of shop and also work experience of user
            ProfessionalProfileSectionWithPadding(
              childWidget: ProfessionalShopDescriptionDetails(
                shopDescription: widget.professional.shopDescription,
                workExperience: widget.professional.workExperience,
              ),
            ),

            /// Work speciality card
            /// Shows professionals work speciality in a chip style
            ProfessionalProfileSectionWithPadding(
              childWidget: ProfessionalWorkSpeciality(
                workSpeciality: widget.professional.workSpeciality,
              ),
            ),

            /// Work Images card
            /// Shows work images of professional
            /// widget shows conditionaly only when work images are uploaded by professional
            if (widget.professional.workImages != null &&
                widget.professional.workImages.isNotEmpty)
              ProfessionalProfileSectionWithPadding(
                childWidget: ProfessionalWorkImages(
                  workImages: widget.professional.workImages,
                ),
              ),

            /// Reviews card
            /// Shows reviews of professional if there is some present
            ProfessionalProfileSectionWithPadding(
              childWidget: ProfessionalReviewsSection(),
            ),
            SizedBox(height: context.safePercentHeight * 1.8),
          ],
        ),
      ),
    );
  }
}
