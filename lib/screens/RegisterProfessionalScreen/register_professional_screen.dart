// ignore_for_file: prefer_const_constructors_in_immutables, prefer_const_constructors, deprecated_member_use, curly_braces_in_flow_control_structures, avoid_print, use_key_in_widget_constructors

import 'dart:io';

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';

import 'package:image_cropper/image_cropper.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/firestoreModels/Profession.dart';
import 'package:online_panchayat_flutter/firestoreModels/point.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/firestoreModels/Professional.dart';
import 'package:online_panchayat_flutter/screens/RegisterProfessionalScreen/registerProfessional.dart';
import 'package:online_panchayat_flutter/screens/widgets/OperationCompletionStatusDialog.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class RegisterProfessionalScreen extends StatefulWidget {
  final Professional professional;
  RegisterProfessionalScreen({
    Key key,
    this.professional,
  }) : super(key: key);

  @override
  _RegisterProfessionalScreenState createState() =>
      _RegisterProfessionalScreenState();
}

class _RegisterProfessionalScreenState
    extends State<RegisterProfessionalScreen> {
  Location location;
  String userId;
  Profession chooseProfession;
  final _formKey = GlobalKey<FormState>();

  TextEditingController nameEditingController = TextEditingController(),
      contactNoEditingController = TextEditingController();
  File image;
  File pickedImage;
  String imageUrl = DEFAULT_USER_IMAGE_URL;
  LocationNotifier locationNotifier;
  TextEditingController locationTextEditingController = TextEditingController(),
      descriptionEditingController = TextEditingController();
  Profession dropDownValue;
  List<Profession> availableProfessions;
  GlobalDataNotifier globalDataNotifier;
  bool professionSelected;
  bool professionAdded = false;

  @override
  void initState() {
    chooseProfession = Profession(
        id: null, en: CHOOSE_PROFESSION.tr(), hi: CHOOSE_PROFESSION.tr());
    dropDownValue = chooseProfession;
    globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    var user = globalDataNotifier.localUser;
    userId = user.id;
    location = user.homeAdressLocation;
    nameEditingController.text = user.name;
    contactNoEditingController.text = user.mobileNumber.substring(3);
    availableProfessions = [];

    if (widget.professional != null) {
      nameEditingController.text = widget.professional.name;
      Profession previouslySelectedProfession = Profession(
        id: widget.professional.profession,
        en: widget.professional.profession,
        hi: widget.professional.profession,
      );
      availableProfessions.insert(0, previouslySelectedProfession);
      dropDownValue = previouslySelectedProfession;
      imageUrl = widget.professional.imageUrl;
      descriptionEditingController.text = widget.professional.descripton;
    }

    locationNotifier = Provider.of<LocationNotifier>(context, listen: false);
    locationNotifier.addListener(updateLocationTextField);

    availableProfessions.insert(0, chooseProfession);
    availableProfessions.addAll(globalDataNotifier.availableProfessionals);

    super.initState();
  }

  @override
  void dispose() {
    nameEditingController.dispose();
    contactNoEditingController.dispose();
    availableProfessions.removeAt(0);
    locationNotifier.removeListener(updateLocationTextField);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    updateLocationTextField();
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: REGISTER_YOURSELF_AS_PROFESSIONAL.tr(),
      ),
      body: Container(
        color: Theme.of(context).cardColor,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: getPostWidgetSymmetricPadding(context,
                vertical: 0, horizontal: 5),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                Center(
                  child: InkWell(
                      onTap: getImage,
                      child: (pickedImage == null)
                          ? CircleAvatar(
                              radius: context.safePercentHeight * 10,
                              backgroundColor: Colors.white,
                              child: Align(
                                alignment: Alignment.bottomCenter,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: Image(
                                      image:
                                          NetworkImage(DEFAULT_USER_IMAGE_URL)),
                                ),
                              ),
                            )
                          : CircleAvatar(
                              radius: context.safePercentHeight * 10,
                              backgroundImage: Image.file(
                                pickedImage,
                              ).image,
                            )),
                ),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                InkWell(
                  onTap: getImage,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "+",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                            ),
                      ),
                      SizedBox(
                        width: 5,
                      ),
                      Text(
                        ADD_PHOTO,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s),
                            ),
                      ).tr(),
                    ],
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 4,
                ),
                LabelAndCustomTextField(
                    label: NAME,
                    inputType: TextInputType.name,
                    textEditingController: nameEditingController,
                    textCapitalization: TextCapitalization.words,
                    hintText: NAME,
                    validator: emptyStringCheckValidator),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                LabelAndCustomTextField(
                  label: CONTACT_NO,
                  inputType: TextInputType.numberWithOptions(decimal: true),
                  textEditingController: contactNoEditingController,
                  hintText: CONTACT_NO,
                  validator: emptyStringCheckValidator,
                  readOnly: true,
                ),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                Text(
                  PROFESSION,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s)),
                ).tr(),
                SizedBox(
                  height: context.safePercentHeight * 2,
                ),
                DropdownButton<Profession>(
                  isExpanded: true,
                  value: dropDownValue,
                  icon: Icon(Icons.arrow_downward),
                  onChanged: (widget.professional == null)
                      ? (newValue) {
                          setState(() {
                            // if (newValue == 'Other')
                            //   showAddProfessionDialog();
                            // else
                            dropDownValue = newValue;
                            if (dropDownValue.id != null)
                              professionSelected = true;
                          });
                        }
                      : null,
                  items: availableProfessions
                      .map<DropdownMenuItem<Profession>>((e) =>
                          DropdownMenuItem(
                            child: Text(
                              // e.hi,
                              (UtilityService.getCurrentLocale(context) == 'hi')
                                  ? e.hi
                                  : e.en,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline2
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s10),
                                      fontWeight: FontWeight.w500),
                            ),
                            value: e,
                          ))
                      .toList(),
                ),
                SizedBox(
                  height: 5,
                ),
                (professionSelected == false)
                    ? Text(
                        CHOOSE_PROFESSION.tr(),
                        style: TextStyle(
                          color: Colors.red,
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 5,
                ),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                LabelAndCustomTextField(
                    label: DESCRIPTION,
                    inputType: TextInputType.multiline,
                    hintText: ADD_DESCRIPTION,
                    textEditingController: descriptionEditingController,
                    validator: emptyStringCheckValidator),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                Text(
                  LOCATION,
                  style: Theme.of(context).textTheme.headline3.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.s)),
                ).tr(),
                SizedBox(
                  height: context.safePercentHeight * 2,
                ),
                InkWell(
                  onTap: () {
                    context.vxNav.push(
                      Uri.parse(MyRoutes.selectLocationRoute),
                    );
                  },
                  child: CustomTextField(
                    readOnly: true,
                    multiLines: true,
                    textEditingController: locationTextEditingController,
                    enabled: false,
                    validator: (data) =>
                        locationFieldValidator(locationNotifier.address),
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 3,
                ),
                InkWell(
                  onTap: () {
                    context.vxNav.push(
                      Uri.parse(MyRoutes.selectLocationRoute),
                    );
                  },
                  child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.grey[300])),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          CHANGE_LOCATION,
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            color: KThemeLightGrey,
                          ),
                        ).tr(),
                        SizedBox(
                          width: context.safePercentWidth * 5,
                        ),
                        Icon(
                          Icons.location_on_sharp,
                          color: maroonColor,
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 5,
                ),
                CustomButton(
                  text: SUBMIT,
                  buttonColor: maroonColor,
                  autoSize: true,
                  onPressed: () async {
                    if (_formKey.currentState.validate()) {
                      if (dropDownValue.id == null) {
                        setState(() {
                          professionSelected = false;
                        });
                        return;
                        // show error return
                      }

                      showMaterialDialog(context);

                      if (pickedImage != null) {
                        imageUrl = await StorageService()
                            .uploadProfessionalImageAndGetUrl(
                                image: pickedImage, userId: userId);
                      }
                      bool registrationSuccessful = true;

                      try {
                        await RegisterProfessional.registerProfessional(
                            Professional(
                          name: nameEditingController.text,
                          profession: dropDownValue.id,
                          contactNo: int.parse(contactNoEditingController.text),
                          imageUrl: imageUrl,
                          descripton: descriptionEditingController.text,
                          point: Point(location: locationNotifier.location),
                          docId: (widget.professional == null)
                              ? null
                              : widget.professional.docId,
                          totalReviews: 0,
                          totalStars: 0,
                        )).then((value) {
                          AnalyticsService.firebaseAnalytics.logEvent(
                              name: "registered_as_professional",
                              parameters: {
                                "profession": dropDownValue.id,
                              });
                        });
                      } catch (e, s) {
                        registrationSuccessful = false;
                        FirebaseCrashlytics.instance.recordError(e, s);
                      }

                      Navigator.of(context).pop();
                      Navigator.of(context).pop();

                      showDialog(
                        context: context,
                        builder: (_) => Material(
                          type: MaterialType.transparency,
                          child: Center(
                            child: Padding(
                                padding: getPostWidgetSymmetricPadding(context,
                                    horizontal: 8),
                                child: OperationCompletionStatusDialog(
                                  heading: (widget.professional == null)
                                      ? registrationSuccessful
                                          ? REGISTRATION_SUCCESSFUL
                                          : REGISTRATION_FAILED
                                      : registrationSuccessful
                                          ? UPDATION_SUCCESSFUL
                                          : UPDATION_FAILED,
                                  subheading: (widget.professional == null)
                                      ? registrationSuccessful
                                          ? REGISTRATION_SUCCESSFUL_DESCRIPTION
                                          : REGISTRATION_FAILED_DESCRIPTION
                                      : registrationSuccessful
                                          ? UPDATION_SUCCESSFUL_DESCRIPTION
                                          : UPDATION_FAILED_DESCRIPTION,
                                )),
                          ),
                        ),
                      );
                    }
                  },
                ),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future getFile() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((file) async {
              if (file != null) {
                var croppedImage = await ImageCropper().cropImage(
                  sourcePath: file.path,
                );

                setState(() {
                  image = croppedImage as File;
                });
              } else {
                print('No file selected.');
              }
            })));
  }

  Future getImage() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((image) async {
              if (image != null) {
                cropImage(image.path);
              } else {
                print('No image selected.');
              }
            })));
  }

  cropImage(String imagePath) async {
    var croppedImage = await ImageCropper().cropImage(
        sourcePath: imagePath,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressQuality: 80,
        maxHeight: 200,
        maxWidth: 200);

    setState(() {
      pickedImage = croppedImage as File;
    });
  }

  updateLocationTextField() {
    locationTextEditingController.text = (locationNotifier.address != null)
        ? locationNotifier.address.addressLine.toString()
        : PLEASE_SELECT_ADDRESS.tr();
  }

  String locationFieldValidator(var address) {
    if (address == null ||
        address.addressLine == null ||
        address.addressLine == '') return PLEASE_SELECT_ADDRESS.tr();
    return null;
  }

  String emptyStringCheckValidator(String input) {
    if (input == '' || input == null) return THIS_FIELD_IS_MANDATORY.tr();
    return null;
  }
}

class LabelAndCustomTextField extends StatelessWidget {
  final Function validator;
  final String label;
  final bool multiLines;
  final TextEditingController textEditingController;
  final TextInputType inputType;
  final TextCapitalization textCapitalization;
  final String hintText;
  final bool readOnly;
  LabelAndCustomTextField({
    this.label,
    this.textEditingController,
    this.inputType,
    this.validator,
    this.textCapitalization,
    this.multiLines = false,
    this.hintText,
    this.readOnly,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline3.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ).tr(),
        SizedBox(
          height: context.safePercentHeight * 2,
        ),
        CustomTextField(
          multiLines: multiLines,
          inputType: inputType,
          textEditingController: textEditingController,
          validator: validator,
          textCapitalization: textCapitalization,
          hintText: hintText.tr(),
          readOnly: readOnly,
        ),
        SizedBox(
          height: context.safePercentHeight * 3,
        ),
      ],
    );
  }
}
