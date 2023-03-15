// ignore_for_file: library_prefixes, prefer_final_fields, deprecated_member_use, avoid_print, annotate_overrides, prefer_const_constructors, avoid_unnecessary_containers

import 'dart:io';

import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/gotre.dart';
import 'package:online_panchayat_flutter/enum/lookingFor.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/genderSelector.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/radioButton.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/service_dropdown.dart';
import 'package:online_panchayat_flutter/screens/widgets/customValidator.dart';
import 'package:online_panchayat_flutter/screens/widgets/instructionText.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/screens/widgets/DatePicker/dropdown_date_picker.dart'
    as datePicker;
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:online_panchayat_flutter/utils/image_selector_bottom_sheet.dart';
import 'package:online_panchayat_flutter/utils/showDialog.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonailPersonalDetails extends StatefulWidget {
  const MatrimonailPersonalDetails({Key key}) : super(key: key);

  @override
  State<MatrimonailPersonalDetails> createState() =>
      _MatrimonailPersonalDetailsState();
}

class _MatrimonailPersonalDetailsState
    extends State<MatrimonailPersonalDetails> {
  File pickedImage;
  bool imageNotFound = false;
  TextEditingController _nameTextEditingController;
  TextEditingController _casteTextEditingController;
  double _textFieldVerticalPadding;
  CheckValidity checkDateOfBirthValidity = DateValidator();
  datePicker.DropdownDatePickerData dropdownDatePickerData;
  CreateMatrimonialProfileData _matrimonialProfile;
  AuthenticationService _authenticationService;
  StorageService _storageService = StorageService();

  final _formKey = GlobalKey<FormState>();

  _initialiseDateInstance() {
    dropdownDatePickerData = datePicker.DropdownDatePickerData(
        firstDate: datePicker.ValidDate(year: 1900, month: 01, day: 01),
        initialDate: Services.globalDataNotifier.localUser.dateOfBirth != null
            ? datePicker.NullableValidDate(
                day: Services.globalDataNotifier.localUser.dateOfBirth
                    .getDateTime()
                    .day,
                month: Services.globalDataNotifier.localUser.dateOfBirth
                    .getDateTime()
                    .month,
                year: Services.globalDataNotifier.localUser.dateOfBirth
                    .getDateTime()
                    .year,
              )
            : datePicker.NullableValidDate(day: null, month: null, year: null),
        lastDate: datePicker.ValidDate(
          year: DateTime.now().year,
          month: DateTime.now().month,
          day: DateTime.now().day,
        ),
        ascending: false,
        dateFormat: datePicker.DateFormat.dmy,
        dateHint: datePicker.DateHint(
          year: YEAR.tr(),
          month: MONTH.tr(),
          day: DAY.tr(),
        ),
        underLine: Container());
  }

  retrieveLostData() async {
    try {
      LostData data = await ImagePicker().getLostData();
      if (data.type == RetrieveType.image) {
        if (data.file != null) {
          setState(() async {
            pickedImage = await RegistrationScreenUtilities.getCroppedImage(
                data.file.path,
                maxHeight: 500,
                maxWidth: 500,
                compressQuality: 100);
          });
        } else {
          print('No image selected.');
        }
      }
    } catch (e) {
      print(e);
    }
  }

  void initState() {
    if (Platform.isAndroid) {
      retrieveLostData();
    }
    _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    _matrimonialProfile = CreateMatrimonialProfileData();
    _textFieldVerticalPadding = 10.0;
    _initialiseDateInstance();
    _nameTextEditingController = TextEditingController();
    _casteTextEditingController = TextEditingController();
    super.initState();
  }

  void _radioButtonOnChanged(LookingFor value) {
    setState(() {
      _matrimonialProfile.lookingFor = value;
    });
  }

  Future getImage() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((image) async {
              if (image != null) {
                pickedImage = await RegistrationScreenUtilities.getCroppedImage(
                    image.path,
                    maxHeight: 500,
                    maxWidth: 500,
                    compressQuality: 100);
                setState(() {
                  imageNotFound = false;
                });
              } else {
                print('No image selected.');
              }
            })));
  }

  void onSubmitForm() async {
    checkDateOfBirthValidity.validate(dropdownDatePickerData.currentDate);
    bool allInputsAreValid =
        _formKey.currentState.validate() && checkDateOfBirthValidity.isValid;

    if (allInputsAreValid) {
      showMaterialDialog(context);
      String uploadedImageUrl;
      if (pickedImage != null) {
        uploadedImageUrl = await _storageService.uploadMatrimonailProfileImage(
          image: pickedImage,
          imageName: _authenticationService.getUserId(),
        );
      } else {
        setState(() {
          imageNotFound = true;
        });
        Navigator.of(context).pop();
        return;
      }

      DateTime selectedDateOfBirth = DateTime(
        dropdownDatePickerData.year,
        dropdownDatePickerData.month,
        dropdownDatePickerData.day,
      );

      try {
        selectedDateOfBirth = selectedDateOfBirth.add(Duration(hours: 8));
      } catch (e, s) {
        FirebaseCrashlytics.instance.recordError(
            "Error while adding duration to date in matrimonail Screen : " + e,
            s);
      }

      _matrimonialProfile.name = _nameTextEditingController.text;
      _matrimonialProfile.caste = _casteTextEditingController.text;
      _matrimonialProfile.image = uploadedImageUrl;
      _matrimonialProfile.dateOfBirth = selectedDateOfBirth;

      Navigator.of(context).pop();
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "matrimonial_personal_details_submit", parameters: {
        "user_id": Services.globalDataNotifier.localUser.id ?? "",
        "name": _matrimonialProfile.name ?? "",
        "caste": _matrimonialProfile.caste ?? "",
        "lookingFor":
            _matrimonialProfile.lookingFor.toString().split(".").last ?? "",
        "gender": _matrimonialProfile.gender.toString().split(".").last ?? ""
      });

      context.vxNav.push(Uri.parse(MyRoutes.matrimonialPlanScreen),
          params: _matrimonialProfile);
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
          PERSONAL_DETAILS,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.safePercentHeight * 1.2,
              horizontal: context.safePercentWidth * 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if (imageNotFound) ...[
                    InstructionText(
                      text: SELECT_PROFILE_PHOTO,
                      textColor: Colors.red,
                      backgroundColor: Colors.red[50],
                    ),
                  ],
                  Center(
                    child: InkWell(
                        onTap: getImage,
                        child: Builder(
                          builder: (context) {
                            return Stack(
                              children: [
                                (pickedImage == null)
                                    ? CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .background,
                                        backgroundImage: Image.network(
                                                _matrimonialProfile
                                                        .images.isNotEmpty
                                                    ? _matrimonialProfile
                                                        .images[0]
                                                    : DEFAULT_USER_IMAGE_URL)
                                            .image,
                                      )
                                    : CircleAvatar(
                                        radius: 60,
                                        backgroundColor: Theme.of(context)
                                            .colorScheme
                                            .background,

                                        // radius: context.safePercentHeight * 10,
                                        backgroundImage: Image.file(
                                          pickedImage,
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
                                  bottom: 10.0,
                                  right: 14.0,
                                ),
                              ],
                            );
                          },
                        )),
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  LabelAndCustomTextField(
                      label: NAME,
                      inputType: TextInputType.name,
                      textEditingController: _nameTextEditingController,
                      textCapitalization: TextCapitalization.words,
                      validator: RegistrationScreenUtilities
                          .emptyStringCheckValidator),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      DATE_OF_BIRTH,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                  ),
                  datePicker.DropdownDatePicker(
                    dropdownDatePickerData: dropdownDatePickerData,
                  ),
                  CustomValidator(checkValidity: checkDateOfBirthValidity),
                  SizedBox(
                    height: _textFieldVerticalPadding,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      GENDER,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  GenderSelector(
                    profileData: _matrimonialProfile,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  LabelAndCustomTextField(
                      label: CASTE,
                      inputType: TextInputType.text,
                      textEditingController: _casteTextEditingController,
                      textCapitalization: TextCapitalization.words,
                      validator: RegistrationScreenUtilities
                          .emptyStringCheckValidator),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  Text(
                    SELECT_GOTRE,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems:
                        _matrimonialProfile.getDropdownItems(Gotre.values),
                    value: _matrimonialProfile.gotre,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged: _matrimonialProfile.onGotreChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 5.0),
                    child: Text(
                      LOOKING_FOR,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding / 4,
                  ),
                  RadioButton(
                    value: _matrimonialProfile.lookingFor,
                    onChanged: _radioButtonOnChanged,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  Center(
                    child: CustomButton(
                      iconData: FontAwesomeIcons.chevronRight,
                      text: SUBMIT,
                      buttonColor: maroonColor,
                      autoSize: true,
                      borderRadius: 10,
                      onPressed: onSubmitForm,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
