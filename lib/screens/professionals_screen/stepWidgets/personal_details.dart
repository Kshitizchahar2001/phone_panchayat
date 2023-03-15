// ignore_for_file: must_be_immutable, avoid_print, deprecated_member_use, prefer_const_constructors

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:online_panchayat_flutter/utils/image_selector_bottom_sheet.dart';
import 'package:provider/provider.dart';

class PersonalDetails extends StatefulWidget {
  PersonalDetails({
    Key key,
    @required this.formKey,
    @required this.nameTextEditingController,
    @required this.mobileTextEditingController,
    @required this.whatsappTextEditingController,
    this.pickedImage,
  }) : super(key: key);

  final GlobalKey<FormState> formKey;
  final TextEditingController nameTextEditingController;
  final TextEditingController mobileTextEditingController;
  final TextEditingController whatsappTextEditingController;
  File pickedImage;

  @override
  State<PersonalDetails> createState() => _PersonalDetailsState();
}

class _PersonalDetailsState extends State<PersonalDetails> {
  GlobalDataNotifier _globalDataNotifier;
  User _currentUser;
  double textFieldVerticalPadding = 10.0;

  // Helper Methods
  Future getImage() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((image) async {
              if (image != null) {
                widget.pickedImage =
                    await RegistrationScreenUtilities.getCroppedImage(
                        image.path);
                setState(() {});
              } else {
                print('No image selected.');
              }
            })));
  }

  retrieveLostData() async {
    try {
      LostData data = await ImagePicker().getLostData();
      if (data.type == RetrieveType.image) {
        if (data.file != null) {
          setState(() async {
            widget.pickedImage =
                await RegistrationScreenUtilities.getCroppedImage(
                    data.file.path);
          });
        } else {
          print('No image selected.');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    if (Platform.isAndroid) {
      retrieveLostData();
    }

    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);

    // global Data notifier with local user
    _currentUser = _globalDataNotifier.localUser;
    widget.nameTextEditingController.text = _currentUser.name;
    widget.mobileTextEditingController.text =
        RegistrationScreenUtilities.getNumberWithoutCountryCode(
            _currentUser.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: widget.formKey,
      child: Column(
        children: [
          Center(
            child: InkWell(
                onTap: getImage,
                child: Builder(
                  builder: (context) {
                    return Stack(
                      children: [
                        (widget.pickedImage == null)
                            ? CircleAvatar(
                                radius: 60,
                                // radius: context.safePercentHeight * 10,
                                backgroundColor: Colors.white,
                                backgroundImage: NetworkImage(
                                    _currentUser.image ?? APP_ICON_URL),

                                // child: Align(
                                //   alignment:
                                //       Alignment.bottomCenter,
                                //   child: Padding(
                                //       padding:
                                //           const EdgeInsets.all(
                                //               8.0),
                                //       child: Image(
                                //         image: NetworkImage(
                                //             _currentUser.image),
                                //         fit: BoxFit.fill,
                                //       )),
                                // ),
                              )
                            : CircleAvatar(
                                radius: 60,
                                // radius: context.safePercentHeight * 10,
                                backgroundImage: Image.file(
                                  widget.pickedImage,
                                ).image,
                              ),
                        Positioned(
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                                border: Border.all(
                                  width: 0.2,
                                  color: Colors.blue,
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(3.0),
                              child: Icon(
                                FontAwesomeIcons.camera,
                                color: Colors.blue,
                                // color: Colors.green,
                                size: 12,
                              ),
                            ),
                          ),
                          bottom: 12.0,
                          right: 18.0,
                        ),
                      ],
                    );
                  },
                )),
          ),
          SizedBox(
            height: textFieldVerticalPadding,
          ),
          LabelAndCustomTextField(
              label: NAME,
              inputType: TextInputType.name,
              textEditingController: widget.nameTextEditingController,
              textCapitalization: TextCapitalization.words,
              validator: RegistrationScreenUtilities.emptyStringCheckValidator),
          SizedBox(
            height: textFieldVerticalPadding,
          ),
          LabelAndCustomTextField(
              enabled: false,
              label: MOBILE_NO,
              maxLength: 10,
              inputType: TextInputType.number,
              textEditingController: widget.mobileTextEditingController,
              textCapitalization: TextCapitalization.sentences,
              prefix: Text("+91"),
              validator:
                  RegistrationScreenUtilities.mobileNumberCheckValidator),
          SizedBox(
            height: textFieldVerticalPadding,
          ),
          LabelAndCustomTextField(
            label: WHATSAPP_NUMBER,
            maxLength: 10,
            inputType: TextInputType.number,
            textEditingController: widget.whatsappTextEditingController,
            textCapitalization: TextCapitalization.sentences,
            prefix: Text("+91"),
            validator: RegistrationScreenUtilities.mobileNumberCheckValidator,
          ),
          SizedBox(height: textFieldVerticalPadding),
        ],
      ),
    );
  }
}
