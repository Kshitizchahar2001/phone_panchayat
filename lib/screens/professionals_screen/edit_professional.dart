// ignore_for_file: prefer_final_fields, unnecessary_new, curly_braces_in_flow_control_structures, avoid_print, deprecated_member_use, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_geo_hash/geohash.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/labelAndCustomTextField.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/find_professionals_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/helperClasses/work_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/services_constant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/stepWidgets/work_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/AuthenticationService/authenticationService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createProfessional.dart';
import 'package:online_panchayat_flutter/services/locationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';
import 'dart:io';
import 'package:online_panchayat_flutter/utils/utils.dart';

class EditProfessional extends StatefulWidget {
  const EditProfessional({Key key, @required this.professional})
      : super(key: key);

  final Professional professional;

  @override
  _EditProfessionalState createState() => _EditProfessionalState();
}

class _EditProfessionalState extends State<EditProfessional> {
  double textFieldVerticalPadding = 10.0;
  File pickedImage;

  bool getLocationFromProfessional = true;

  WorkDetail _workDetail = WorkDetail();
  final _formKey = GlobalKey<FormState>();
  ScrollController _scrollController = ScrollController();
  GQLMutationService _gqlMutationService;
  LocationNotifier locationNotifier;
  GlobalDataNotifier _globalDataNotifier;
  AuthenticationService _authenticationService;
  FindProfessionalsData _findProfessionalsData;
  String deviceToken;
  StorageService _storageService = StorageService();
  TextEditingController _nameTextEditingController =
      new TextEditingController();
  TextEditingController _mobileNumberTextEditingController =
      new TextEditingController();
  TextEditingController _whatsappNumberTextEditingController =
      new TextEditingController();
  TextEditingController _shopNameTextEditingController =
      new TextEditingController();
  TextEditingController _shopDescriptionTextEditingController =
      new TextEditingController();

  final picker = ImagePicker();
  FocusNode _blankFocusNode = FocusNode();
  TextEditingController locationTextEditingController = TextEditingController();

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

    _findProfessionalsData =
        Provider.of<FindProfessionalsData>(context, listen: false);

    _nameTextEditingController.text = widget.professional.user.name;
    _mobileNumberTextEditingController.text =
        RegistrationScreenUtilities.getNumberWithoutCountryCode(
            widget.professional.mobileNumber);
    _whatsappNumberTextEditingController.text =
        RegistrationScreenUtilities.getNumberWithoutCountryCode(
            widget.professional.whatsappNumber);
    _shopNameTextEditingController.text = widget.professional.shopName;
    _shopDescriptionTextEditingController.text =
        widget.professional.shopDescription;
    // locationTextEditingController.text = widget.profileData.homeAdressName;

    locationNotifier.addListener(updateLocationTextField);

    _workDetail.occupationValue = occupationValueFromOccupationId();
    _workDetail.workSpecialities = workSpelityFromWorkSpelialityIds();
    _workDetail.workSpecialityItems =
        _workDetail.occupationValue["subServices"];
    _workDetail.workExperience = widget.professional.workExperience;
    super.initState();
  }

  @override
  void dispose() {
    locationTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _mobileNumberTextEditingController.dispose();
    _whatsappNumberTextEditingController.dispose();
    _shopNameTextEditingController.dispose();
    _shopDescriptionTextEditingController.dispose();
    _scrollController.dispose();
    locationNotifier.removeListener(updateLocationTextField);
    super.dispose();
  }

  /// Methods used for work details informations
  void occupationValueOnChanged(value) {
    setState(() {
      if (_workDetail.occupationValue != value)
        _workDetail.workSpecialities = null;

      _workDetail.occupationValue = value;
      _workDetail.workSpecialityItems = value["subServices"];
    });
  }

  void workSpecilityOnConfirm(values) {
    print(values);
    setState(() {
      _workDetail.workSpecialities = null;
      _workDetail.workSpecialities = values;
    });
  }

  void workExperienceOnChanged(value) {
    setState(() {
      _workDetail.workExperience = value;
    });
  }

  Map occupationValueFromOccupationId() {
    String occupationId = widget.professional.occupationId;
    List<Map> occupation =
        serviceList.where((service) => occupationId == service["id"]).toList();
    if (occupation != null || occupation.isNotEmpty) return occupation[0];
    return null;
  }

  List<Map> workSpelityFromWorkSpelialityIds() {
    List<Map> workSpeciality = _workDetail.occupationValue["subServices"]
        .where((service) =>
            widget.professional.workSpecialityId.contains(service["id"]))
        .toList();
    return workSpeciality;
  }

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

  updateLocationTextField() {
    if (widget.professional.shopLocation != null &&
        getLocationFromProfessional) {
      locationNotifier.setLocationAndAddress(widget.professional.shopLocation);
      getLocationFromProfessional = false;
    }
    locationTextEditingController.text = (locationNotifier.address != null)
        ? locationNotifier.address.addressLine.toString()
        : PLEASE_SELECT_ADDRESS.tr();
  }

  Future<void> updateUserDetails() async {
    if (pickedImage == null &&
        _globalDataNotifier.localUser.name == _nameTextEditingController.text)
      return;
    String uploadedImageUrl;
    if (pickedImage != null)
      uploadedImageUrl = await _storageService.uploadProfilePicAndGetUrl(
        image: pickedImage,
        userId: _authenticationService.getUserId(),
      );

    /// Call for user update
    await _gqlMutationService.updateUser.updateUserProfile(
        notifierService: _globalDataNotifier,
        messagingService:
            Provider.of<FirebaseMessagingService>(context, listen: false),
        name: _nameTextEditingController.text,
        image: uploadedImageUrl ?? _globalDataNotifier.localUser.image,
        gender: _globalDataNotifier.localUser.gender,
        designation: _globalDataNotifier.localUser.designation,
        homeAdressLocation: _globalDataNotifier.localUser.homeAdressLocation,
        id: _globalDataNotifier.localUser.id);
  }

  ///
  Future<void> onSubmitEditProfile() async {
    if (_formKey.currentState.validate()) {
      showMaterialDialog(context);
      await updateUserDetails();

      // Get location
      Location shopLocation = locationNotifier.location ?? Location();

      /// Get geohash for shop location
      MyGeoHash fluttergeo = MyGeoHash();
      String geoHash = fluttergeo.geoHashForLocation(
        GeoPoint(shopLocation.lat, shopLocation.lon),
        precision: 10,
      );

      Professional professional = Professional(
        id: widget.professional.id,
        geoHash: geoHash,
        totalReviews: 0,
        totalStars: 0,
        mobileNumber: "+91" + _mobileNumberTextEditingController.text,
        whatsappNumber: "+91" + _whatsappNumberTextEditingController.text,
        shopName: _shopNameTextEditingController.text,
        shopLocation: shopLocation,
        shopDescription: _shopDescriptionTextEditingController.text,
        occupationName: _workDetail.occupationValue["name"] ?? "",
        occupationId: _workDetail.occupationValue["id"] ?? "",
        workSpeciality:
            _workDetail.workSpecialities.map<String>((e) => e["name"]).toList(),
        workSpecialityId:
            _workDetail.workSpecialities.map<String>((e) => e["id"]).toList(),
        // workExperience: workExperienceValue,
        workImages: widget.professional.workImages,
        shopAddressLine: locationTextEditingController.text,
        workExperience: _workDetail.workExperience,
      );
      bool registrationStatus = await CreateAndUpdateProfessional()
          .updateProfessional(professional: professional);
      if (registrationStatus) {
        _findProfessionalsData.updateProfessionalComplete = true;
        _findProfessionalsData.fetchProfessional();
      }
      Navigator.pop(context);
      context.vxNav.returnAndPush(registrationStatus);

      // Navigator.pop(context, registrationStatus);
    } else {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    updateLocationTextField();

    return Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(color: maroonColor),
          title: FittedBox(
            child: Text(
              EDIT_PROFILE,
              style: Theme.of(context).textTheme.headline2.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.m),
                  color: maroonColor),
            ).tr(),
          ),
        ),
        body: Container(
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
                                            ? CachedNetworkImage(
                                                imageUrl: widget.professional
                                                        .user.image ??
                                                    APP_ICON_URL,
                                                progressIndicatorBuilder:
                                                    (context, url,
                                                            downloadProgress) =>
                                                        RectangularImageLoading(),
                                                imageBuilder:
                                                    (context, imageProvider) =>
                                                        CircleAvatar(
                                                  radius: 60,
                                                  backgroundImage:
                                                      imageProvider,
                                                ),
                                                errorWidget:
                                                    (context, url, error) =>
                                                        Icon(Icons.error),
                                              )
                                            : CircleAvatar(
                                                radius: 60,
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
                                              padding:
                                                  const EdgeInsets.all(3.0),
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
                              textEditingController: _nameTextEditingController,
                              textCapitalization: TextCapitalization.words,
                              validator: RegistrationScreenUtilities
                                  .emptyStringCheckValidator),
                          SizedBox(
                            height: textFieldVerticalPadding,
                          ),
                          LabelAndCustomTextField(
                              label: MOBILE_NO,
                              maxLength: 10,
                              enabled: false,
                              prefix: Text("+91"),
                              inputType: TextInputType.text,
                              textEditingController:
                                  _mobileNumberTextEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: RegistrationScreenUtilities
                                  .mobileNumberCheckValidator),
                          SizedBox(
                            height: textFieldVerticalPadding,
                          ),
                          LabelAndCustomTextField(
                              maxLength: 10,
                              label: WHATSAPP_NUMBER,
                              inputType: TextInputType.text,
                              prefix: Text("+91"),
                              textEditingController:
                                  _whatsappNumberTextEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: RegistrationScreenUtilities
                                  .mobileNumberCheckValidator),
                          SizedBox(
                            height: textFieldVerticalPadding,
                          ),

                          /// Select work
                          WorkDetailDropDowns(
                            workDetail: _workDetail,
                            occupationOnChanged: occupationValueOnChanged,
                            workSpecilityOnConfirm: workSpecilityOnConfirm,
                            workExperienceOnChanged: workExperienceOnChanged,
                          ),
                          SizedBox(
                            height: textFieldVerticalPadding,
                          ),

                          LabelAndCustomTextField(
                              label: SHOP_NAME,
                              // multiLines: true,
                              inputType: TextInputType.text,
                              textEditingController:
                                  _shopNameTextEditingController,
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
                              textEditingController:
                                  locationTextEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: (data) => RegistrationScreenUtilities
                                  .locationFieldValidator(
                                      locationNotifier.address),
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
                              textEditingController:
                                  _shopDescriptionTextEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              validator: RegistrationScreenUtilities
                                  .emptyStringCheckValidator),
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
                              onPressed: onSubmitEditProfile,
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
        ));
  }
}
