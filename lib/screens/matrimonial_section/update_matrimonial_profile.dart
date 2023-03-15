// ignore_for_file: unused_local_variable, await_only_futures, prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/education.dart';
import 'package:online_panchayat_flutter/enum/gotre.dart';
import 'package:online_panchayat_flutter/enum/maritalStatus.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/enum/profileFor.dart';
import 'package:online_panchayat_flutter/enum/rashi.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/main_screen/additional_tehsil_button.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_profile_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/service_dropdown.dart';
import 'package:online_panchayat_flutter/screens/widgets/instructionText.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createMatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/updateUser.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:online_panchayat_flutter/utils/showDialog.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class UpdateMatrimonialProfile extends StatefulWidget {
  const UpdateMatrimonialProfile({Key key, @required this.currentProfile})
      : super(key: key);

  final MatrimonialProfile currentProfile;

  @override
  State<UpdateMatrimonialProfile> createState() =>
      _UpdateMatrimonialProfileState();
}

class _UpdateMatrimonialProfileState extends State<UpdateMatrimonialProfile> {
  final _formKey = GlobalKey<FormState>();
  double _textFieldVerticalPadding;
  TextEditingController _nameTextEditingController;
  TextEditingController _casteTextEditingController;
  TextEditingController _mobileTextEditingController;
  TextEditingController _occupationTextEditingController;

  String instructionText;
  bool isErrorInProfileUpdate = false;

  List<Places> stateList = [];
  List<Places> districtList = [];

  UpdateMatrimonialProfileData _updateMatrimonialProfileData;
  CurrentMatrimonailProfileData _currentMatrimonailProfileData;

  void onSubmitForm() async {
    if (_formKey.currentState.validate()) {
      showMaterialDialog(context);
      _updateMatrimonialProfileData.name = _nameTextEditingController.text;
      _updateMatrimonialProfileData.caste = _casteTextEditingController.text;
      _updateMatrimonialProfileData.mobileNumber =
          "+91" + _mobileTextEditingController.text;
      _updateMatrimonialProfileData.occupation =
          _occupationTextEditingController.text;
      _updateMatrimonialProfileData.brothers.married = 0;
      _updateMatrimonialProfileData.sisters.married = 0;

      bool updateStatus = await CreateMatrimonialProfile()
          .updateMatrimonialProfile(profile: _updateMatrimonialProfileData);
      if (updateStatus) {
        updateUser();
        _currentMatrimonailProfileData.fetchMatrimonailProfile();

        AnalyticsService.firebaseAnalytics
            .logEvent(name: "matrimonial_profile_update", parameters: {
          "user_id": Services.globalDataNotifier.localUser.id ?? "",
          "mobile_no": _updateMatrimonialProfileData.mobileNumber ?? "",
          "gotre":
              _updateMatrimonialProfileData.gotre.toString().split(".").last ??
                  "",
          "state_id": _updateMatrimonialProfileData.state_id ?? "",
          "district_id": _updateMatrimonialProfileData.district_id ?? "",
          "occupation": _updateMatrimonialProfileData.occupation ?? "",
          "maritalStatus": _updateMatrimonialProfileData.maritalStatus
                  .toString()
                  .split(".")
                  .last ??
              "",
          "profileFor": _updateMatrimonialProfileData.profileFor
                  .toString()
                  .split(".")
                  .last ??
              "",
          "education": _updateMatrimonialProfileData.education
                  .toString()
                  .split(".")
                  .last ??
              "",
        });
      } else {
        Navigator.pop(context);
        setState(() {
          instructionText = ERROR_IN_UPDATE_USER.tr();
          isErrorInProfileUpdate = true;
        });
      }
      Navigator.of(context).pop();
      Navigator.of(context).pop();
    }
  }

  void updateUser() async {
    GlobalDataNotifier _globalDataNotifier = Services.globalDataNotifier;
    User _currentUser = _globalDataNotifier.localUser;
    // Update user object with subscription plan
    var variables = {
      "id": _currentUser.id,
      "lat": _currentUser.homeAdressLocation.lat,
      "lon": _currentUser.homeAdressLocation.lon,
      "expectedVersion": Services.firebaseMessagingService.userVersion,
      "isMatrimonialProfileComplete": true
    };

    bool result = await UpdateUser().updateUser(
      variables: variables,
      notifierService: _globalDataNotifier,
      messagingService: Services.firebaseMessagingService,
    );
  }

  @override
  void initState() {
    _updateMatrimonialProfileData =
        UpdateMatrimonialProfileData(widget.currentProfile);
    getStateList("country1");
    _textFieldVerticalPadding = 10.0;
    _nameTextEditingController = TextEditingController();
    _casteTextEditingController = TextEditingController();
    _mobileTextEditingController = TextEditingController();
    _occupationTextEditingController = TextEditingController();

    /// Updating from old profile
    _nameTextEditingController.text = widget.currentProfile.name ?? "";
    _casteTextEditingController.text = widget.currentProfile.caste ?? "";
    _occupationTextEditingController.text =
        widget.currentProfile.occupation ?? "";
    _mobileTextEditingController.text =
        RegistrationScreenUtilities.getNumberWithoutCountryCode(
                widget.currentProfile.mobileNumber) ??
            "";
    _updateMatrimonialProfileData.state_id = widget.currentProfile.state_id;
    _updateMatrimonialProfileData.district_id =
        widget.currentProfile.district_id;

    _currentMatrimonailProfileData =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);

    super.initState();
  }

  void getDistrictList(String parentId, PlaceType type) async {
    List<Places> placeList = [];
    placeList = await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(parentId: parentId, placeType: type);
    if (placeList != null) {
      setState(() {
        districtList = placeList;
      });
    }
  }

  void getStateList(String parentId) async {
    List<Places> placeList = [];
    placeList = await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(parentId: parentId);

    placeList.removeWhere(
        (element) => element.name_hi == null || element.name_hi == "");

    setState(() {
      stateList = placeList;
    });

    await getDistrictList(
        _updateMatrimonialProfileData.state_id, PlaceType.DISTRICT);
  }

  void onStateChanged(value) async {
    setState(() {
      _updateMatrimonialProfileData.state_id = value;
      _updateMatrimonialProfileData.district_id = null;
    });

    await getDistrictList(
        _updateMatrimonialProfileData.state_id, PlaceType.DISTRICT);
  }

  void onDistrictChange(value) async {
    setState(() {
      _updateMatrimonialProfileData.district_id = value;
    });
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
        centerTitle: false,
        elevation: 2.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          EDIT_PROFILE,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
        actions: [
          Padding(
            padding:
                EdgeInsets.symmetric(vertical: context.safePercentHeight * 1),
            child: CustomButtonWithIcon(
              icon: Icon(
                Icons.add_a_photo_outlined,
                size: 20.0,
                color: Colors.white,
              ),
              label: Text(ADD_PHOTO,
                      style: TextStyle(fontSize: 15, color: Colors.white))
                  .tr(),
              onClick: () {
                context.vxNav.push(Uri.parse(MyRoutes.addImagesForMatrimonial),
                    params: _updateMatrimonialProfileData);
              },
            ),
          ),
        ],
      ),
      body: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.safePercentHeight * 1.2,
              horizontal: context.safePercentWidth * 10),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  if (isErrorInProfileUpdate) ...[
                    InstructionText(
                      text: instructionText,
                      textColor: Colors.red,
                      backgroundColor: Colors.red[50],
                    ),
                  ],

                  ///Name field
                  ///
                  LabelAndCustomTextField(
                      label: NAME,
                      inputType: TextInputType.name,
                      textEditingController: _nameTextEditingController,
                      textCapitalization: TextCapitalization.words,
                      validator: RegistrationScreenUtilities
                          .emptyStringCheckValidator),
                  SizedBox(
                    height: _textFieldVerticalPadding,
                  ),

                  /// Caste field
                  ///
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

                  /// Gotre Dropdown
                  ///
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
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItems(Gotre.values),
                    value: _updateMatrimonialProfileData.gotre,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged: _updateMatrimonialProfileData.onGotreChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Profile For Dropdown
                  ///
                  Text(
                    PROFILE_FOR,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItems(ProfileFor.values),
                    value: _updateMatrimonialProfileData.profileFor,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged:
                        _updateMatrimonialProfileData.onProfileForChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Place Dropdowns
                  ///

                  Text(
                    PLACE,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: ServiceDropdown(
                          isExpanded: true,
                          dropDownItems: _updateMatrimonialProfileData
                              .makeDropDownList(stateList, context),
                          value: _updateMatrimonialProfileData.state_id,
                          hint: Text(
                            STATE,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ).tr(),
                          onChanged: onStateChanged,
                          borderRadius: 4,
                          dropDownValidator:
                              RegistrationScreenUtilities.dropDownValidator,
                        ),
                      ),
                      SizedBox(
                        width: context.safePercentWidth * 2,
                      ),
                      Expanded(
                        child: ServiceDropdown(
                          isExpanded: true,
                          dropDownItems: _updateMatrimonialProfileData
                              .makeDropDownList(districtList, context),
                          value: _updateMatrimonialProfileData.district_id,
                          hint: Text(
                            DISTRICT,
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ).tr(),
                          onChanged: onDistrictChange,
                          borderRadius: 4,
                          dropDownValidator:
                              RegistrationScreenUtilities.dropDownValidator,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Marital Status
                  ///
                  Text(
                    MARITAL_STATUS,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItems(MaritalStatus.values),
                    value: _updateMatrimonialProfileData.maritalStatus,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged:
                        _updateMatrimonialProfileData.onMaritalStatusChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Height
                  ///
                  Text(
                    HEIGHT,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItemsFromListOfString(
                            _updateMatrimonialProfileData.generateHeightList(
                                4, 7)),
                    value: _updateMatrimonialProfileData.height,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged: _updateMatrimonialProfileData.onHeightChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Education
                  ///
                  Text(
                    EDUCATION,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItems(Education.values),
                    value: _updateMatrimonialProfileData.education,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged: _updateMatrimonialProfileData.onEducationChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Occupation
                  ///
                  LabelAndCustomTextField(
                      label: OCCUPATION,
                      inputType: TextInputType.text,
                      textEditingController: _occupationTextEditingController,
                      textCapitalization: TextCapitalization.words,
                      validator: RegistrationScreenUtilities
                          .emptyStringCheckValidator),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  LabelAndCustomTextField(
                      label: MOBILE_NO,
                      maxLength: 10,
                      inputType: TextInputType.number,
                      textEditingController: _mobileTextEditingController,
                      textCapitalization: TextCapitalization.sentences,
                      prefix: Text("+91"),
                      validator: RegistrationScreenUtilities
                          .mobileNumberCheckValidator),

                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  Text(
                    NO_OF_BROTHERS,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItemsFromListOfString(
                            _updateMatrimonialProfileData.generateSiblingList(
                                0, 8)),
                    value: _updateMatrimonialProfileData.brothers.total,
                    hint: Text(
                      NO_OF_BROTHERS,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged:
                        _updateMatrimonialProfileData.onTotalBrotherChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),
                  Text(
                    NO_OF_SISTERS,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItemsFromListOfString(
                            _updateMatrimonialProfileData.generateSiblingList(
                                0, 8)),
                    value: _updateMatrimonialProfileData.sisters?.total,
                    hint: Text(
                      NO_OF_SISTERS,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged:
                        _updateMatrimonialProfileData.onTotalSisterChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
                  ),
                  SizedBox(
                    height: _textFieldVerticalPadding * 2,
                  ),

                  /// Rashi dropdown
                  ///
                  Text(
                    RASHI,
                    style: Theme.of(context).textTheme.headline3.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ).tr(),
                  SizedBox(
                    height: _textFieldVerticalPadding / 2,
                  ),
                  ServiceDropdown(
                    dropDownItems: _updateMatrimonialProfileData
                        .getDropdownItems(Rashi.values),
                    value: _updateMatrimonialProfileData.rashi,
                    hint: Text(
                      SELECT,
                      style: Theme.of(context).textTheme.headline3.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ).tr(),
                    onChanged: _updateMatrimonialProfileData.onRashiChanged,
                    borderRadius: 4,
                    dropDownValidator:
                        RegistrationScreenUtilities.dropDownValidator,
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
