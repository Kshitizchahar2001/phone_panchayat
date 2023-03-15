// ignore_for_file: library_prefixes, overridden_fields, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_final_fields, unnecessary_new, avoid_print, deprecated_member_use, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/genderSelector.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenData.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/widgets/DatePicker/dropdown_date_picker.dart'
    as datePicker;
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/customValidator.dart';
import 'package:online_panchayat_flutter/screens/widgets/instructionText.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';

import 'package:online_panchayat_flutter/utils/utils.dart';

class EditProfileForm extends Registration {
  EditProfileForm() : super(profileData: EditProfile());
}

class CreateProfileForm extends Registration {
  @override
  final String message;
  CreateProfileForm({
    this.message,
  }) : super(
          message: message,
          profileData: CreateProfile(),
        );
}

class Registration extends StatelessWidget {
  final String message;
  final ProfileData profileData;
  Registration({
    this.message,
    @required this.profileData,
  });
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: PROFILE_DETAILS.tr(),
      ),
      backgroundColor: Theme.of(context).colorScheme.background,
      body: Responsive(
        mobile: BuildResponsiveRegistration(
          message: message,
          profileData: profileData,
        ),
        desktop: BuildResponsiveRegistration(
          message: message,
          profileData: profileData,
        ),
        tablet: BuildResponsiveRegistration(
          message: message,
          profileData: profileData,
        ),
      ),
    );
  }
}

class BuildResponsiveRegistration extends StatefulWidget {
  final String message;
  final ProfileData profileData;

  BuildResponsiveRegistration({
    Key key,
    this.message,
    @required this.profileData,
  }) : super(key: key);

  @override
  _BuildResponsiveRegistrationState createState() =>
      _BuildResponsiveRegistrationState();
}

class _BuildResponsiveRegistrationState
    extends State<BuildResponsiveRegistration> {
  double textFieldVerticalPadding = 10.0;
  File pickedImage;
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  GQLMutationService _gqlMutationService;
  LocationNotifier locationNotifier;
  GlobalDataNotifier _globalDataNotifier;
  AuthenticationService _authenticationService;
  String deviceToken;
  StorageService _storageService = StorageService();
  TextEditingController nameTextEditingController = new TextEditingController();
  TextEditingController designationTextEditingController =
      new TextEditingController();
  TextEditingController homeAddressTextEditingController =
      new TextEditingController();
  TextEditingController dateOfBirthTextEditingController =
      new TextEditingController();

  CheckValidity checkDateOfBirthValidity = DateValidator();

  final picker = ImagePicker();
  FocusNode _blankFocusNode = FocusNode();
  TextEditingController locationTextEditingController =
      TextEditingController(text: PLEASE_SELECT_ADDRESS.tr());

  datePicker.DropdownDatePickerData dropdownDatePickerData;

  Future getImage() async {
    showModalBottomSheet(
        backgroundColor: Colors.transparent,
        context: context,
        builder: ((builder) => BottomSheetWidget((image) async {
              if (image != null) {
                pickedImage = await RegistrationScreenUtilities.getCroppedImage(
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
            pickedImage = await RegistrationScreenUtilities.getCroppedImage(
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
    _gqlMutationService =
        Provider.of<GQLMutationService>(context, listen: false);
    locationNotifier = Provider.of<LocationNotifier>(context, listen: false);
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _authenticationService =
        Provider.of<AuthenticationService>(context, listen: false);
    deviceToken = Provider.of<FirebaseMessagingService>(context, listen: false)
        .getUpToDateDeviceToken;

    nameTextEditingController.text = widget.profileData.name;
    designationTextEditingController.text = widget.profileData.designation;
    // locationTextEditingController.text = widget.profileData.homeAdressName;
    homeAddressTextEditingController.text = widget.profileData.homeAdressName;
    locationNotifier.addListener(updateLocationTextField);

    try {
      _initialiseDateInstance();
    } catch (e) {
      print("exception in date obj");
    }

    super.initState();
  }

  _initialiseDateInstance() {
    dropdownDatePickerData = datePicker.DropdownDatePickerData(
        firstDate: datePicker.ValidDate(year: 1900, month: 01, day: 01),
        initialDate: datePicker.NullableValidDate(
          day: widget.profileData.dateOfBirth?.day,
          month: widget.profileData.dateOfBirth?.month,
          year: widget.profileData.dateOfBirth?.year,
        ),
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

  @override
  void dispose() {
    locationTextEditingController.dispose();
    designationTextEditingController.dispose();
    homeAddressTextEditingController.dispose();
    _scrollController.dispose();
    locationNotifier.removeListener(updateLocationTextField);
    super.dispose();
  }

  updateLocationTextField() {
    locationTextEditingController.text = (locationNotifier.address != null)
        ? locationNotifier.address.addressLine.toString()
        : PLEASE_SELECT_ADDRESS.tr();
  }

  @override
  Widget build(BuildContext context) {
    updateLocationTextField();

    return Container(
      constraints: BoxConstraints.expand(),
      width: double.infinity,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            FocusScope.of(context).requestFocus(_blankFocusNode);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InstructionText(text: widget.message),
              Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.safePercentWidth * 8),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ResponsiveHeight(
                        heightRatio: 2,
                      ),
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
                                                    widget.profileData.image)
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
                        height: textFieldVerticalPadding,
                      ),
                      LabelAndCustomTextField(
                          label: NAME,
                          inputType: TextInputType.name,
                          textEditingController: nameTextEditingController,
                          textCapitalization: TextCapitalization.words,
                          validator: RegistrationScreenUtilities
                              .emptyStringCheckValidator),
                      SizedBox(
                        height: textFieldVerticalPadding,
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
                        height: textFieldVerticalPadding,
                      ),
                      LabelAndCustomTextField(
                          label: DESIGNATION,
                          inputType: TextInputType.text,
                          textEditingController:
                              designationTextEditingController,
                          textCapitalization: TextCapitalization.sentences,
                          validator: RegistrationScreenUtilities
                              .emptyStringCheckValidator),
                      SizedBox(
                        height: textFieldVerticalPadding,
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
                        height: textFieldVerticalPadding / 4,
                      ),
                      GenderSelector(
                        profileData: widget.profileData,
                      ),
                      SizedBox(
                        height: textFieldVerticalPadding,
                      ),
                      LabelAndCustomTextField(
                          label: HOME_ADDRESS,
                          multiLines: true,
                          inputType: TextInputType.text,
                          textEditingController:
                              homeAddressTextEditingController,
                          textCapitalization: TextCapitalization.sentences,
                          validator: RegistrationScreenUtilities
                              .emptyStringCheckValidator),
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
                          label: LOCATION,
                          multiLines: true,
                          inputType: TextInputType.text,
                          textEditingController: locationTextEditingController,
                          textCapitalization: TextCapitalization.sentences,
                          validator: (data) => RegistrationScreenUtilities
                              .locationFieldValidator(locationNotifier.address),
                          suffixIcon: Icon(
                            Icons.location_on,
                            color: maroonColor.withOpacity(0.8),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: textFieldVerticalPadding * 2,
                      ),
                      Center(
                        child: CustomButton(
                          iconData: FontAwesomeIcons.chevronRight,
                          text: SUBMIT,
                          buttonColor: maroonColor,
                          autoSize: true,
                          borderRadius: 10,
                          onPressed: () async {
                            checkDateOfBirthValidity
                                .validate(dropdownDatePickerData.currentDate);
                            bool allInputsAreValid =
                                _formKey.currentState.validate() &&
                                    checkDateOfBirthValidity.isValid;

                            if (allInputsAreValid) {
                              showMaterialDialog(context);
                              String uploadedImageUrl;
                              if (pickedImage != null)
                                uploadedImageUrl = await _storageService
                                    .uploadProfilePicAndGetUrl(
                                  image: pickedImage,
                                  userId: _authenticationService.getUserId(),
                                );

                              DateTime selectedDateOfBirth = DateTime(
                                dropdownDatePickerData.year,
                                dropdownDatePickerData.month,
                                dropdownDatePickerData.day,
                              );

                              try {
                                selectedDateOfBirth =
                                    selectedDateOfBirth.add(Duration(hours: 8));
                              } catch (e, s) {
                                FirebaseCrashlytics.instance.recordError(
                                    "Error while adding duration to date in registration screen : " +
                                        e,
                                    s);
                              }
                              await _gqlMutationService.updateUser
                                  .updateUserProfile(
                                id: _globalDataNotifier.localUser.id,
                                messagingService:
                                    Provider.of<FirebaseMessagingService>(
                                        context,
                                        listen: false),
                                notifierService: _globalDataNotifier,
                                homeAdressLocation:
                                    locationNotifier.location ?? Location(),
                                name: nameTextEditingController.text,
                                image: uploadedImageUrl ??
                                    widget.profileData.image,
                                designation:
                                    designationTextEditingController.text,
                                gender: widget.profileData.gender.value,
                                homeAdressName: homeAddressTextEditingController
                                            .text.length >
                                        0
                                    ? homeAddressTextEditingController.text
                                    : null,
                                dateOfBirth: TemporalDate(selectedDateOfBirth),
                              )
                                  .then((value) {
                                AnalyticsService.firebaseAnalytics.logSignUp(
                                  signUpMethod: "mobile_number",
                                );
                              });
                              Navigator.pop(context);
                              Navigator.pop(context);
                            } else {
                              _scrollController.animateTo(0.0,
                                  duration: Duration(milliseconds: 500),
                                  curve: Curves.easeInOut);
                            }
                          },
                        ),
                      ),
                      SizedBox(
                        height: textFieldVerticalPadding * 4,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
