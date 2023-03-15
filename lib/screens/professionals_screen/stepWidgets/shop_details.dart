// ignore_for_file: prefer_typing_uninitialized_variables, duplicate_ignore

// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';

import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopDetails extends StatelessWidget {
  const ShopDetails({
    Key key,
    @required this.formKey,
    @required this.shopNameTextEditingController,
    @required this.locationTextEditingController,
    @required this.descriptionTextEditingController,
    @required this.updateLocationTextField,
    @required this.address,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController shopNameTextEditingController;
  final TextEditingController locationTextEditingController;
  final TextEditingController descriptionTextEditingController;
  final Function updateLocationTextField;
  final  address;

  @override
  Widget build(BuildContext context) {
    double textFieldVerticalPadding = 10.0;
    updateLocationTextField();
    return Form(
      key: formKey,
      child: Column(
        children: [
          SizedBox(height: textFieldVerticalPadding * 2),
          LabelAndCustomTextField(
            label: SHOP_NAME,
            inputType: TextInputType.text,
            textEditingController: shopNameTextEditingController,
            textCapitalization: TextCapitalization.sentences,
            validator: RegistrationScreenUtilities.emptyStringCheckValidator,
          ),
          SizedBox(
            height: textFieldVerticalPadding,
          ),
          InkWell(
            onTap: () {
              context.vxNav.push(
                Uri.parse(MyRoutes.selectLocationRoute),
              );
            },
            child: LabelAndCustomTextField(
              enabled: false,
              label: SHOP_ADDRESS,
              multiLines: true,
              inputType: TextInputType.text,
              textEditingController: locationTextEditingController,
              textCapitalization: TextCapitalization.sentences,
              validator: (data) =>
                  RegistrationScreenUtilities.locationFieldValidator(address),
              suffixIcon: Icon(
                Icons.location_on,
                color: maroonColor.withOpacity(0.8),
              ),
            ),
          ),
          SizedBox(
            height: textFieldVerticalPadding,
          ),
          LabelAndCustomTextField(
            label: SHOP_DESCRIPTION,
            multiLines: true,
            inputType: TextInputType.text,
            textEditingController: descriptionTextEditingController,
            textCapitalization: TextCapitalization.sentences,
            validator: RegistrationScreenUtilities.emptyStringCheckValidator,
          ),
          SizedBox(height: textFieldVerticalPadding * 2),
        ],
      ),
    );
  }
}
