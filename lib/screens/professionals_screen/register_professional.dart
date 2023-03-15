// ignore_for_file: prefer_const_constructors_in_immutables, prefer_final_fields, curly_braces_in_flow_control_structures, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace, duplicate_ignore

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_geo_hash/geohash.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/Professional.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/services_constant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/stepWidgets/personal_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/stepWidgets/shop_details.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/stepWidgets/work_details.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
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

import 'helperClasses/work_details.dart';

class RegisterProfessionalForm extends StatefulWidget {
  RegisterProfessionalForm({
    Key key,
  }) : super(key: key);

  @override
  _RegisterProfessionalFormState createState() =>
      _RegisterProfessionalFormState();
}

class _RegisterProfessionalFormState extends State<RegisterProfessionalForm> {
  int _currentFormStep = 0;
  List<GlobalKey<FormState>> _stepperFormKeys = [
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>(),
    GlobalKey<FormState>()
  ];
  double _textFieldVerticalPadding = 10.0;
  bool _isLoading = false;

  List<File> _workImages = [];

  ImagePicker _picker = ImagePicker();
  File _pickedImage;
  StorageService _storageService;
  LocationNotifier locationNotifier;

  /// Work detail Object which holds values for Occupataion, work speciality and work experience
  WorkDetail _workDetail;

  final _formKey = GlobalKey<FormState>();

  ScrollController _scrollController = ScrollController();

  GlobalDataNotifier _globalDataNotifier;
  GQLMutationService _gqlMutationService;
  User _currentUser;

  /// Text editing controllers for every text field used in form
  TextEditingController _nameTextEditingController = TextEditingController();
  TextEditingController _shopNameTextEditingController =
      TextEditingController();
  TextEditingController _mobileTextEditingController = TextEditingController();
  TextEditingController _whatsappNumberTextEditingController =
      TextEditingController();
  TextEditingController _descriptionTextEditingController =
      TextEditingController();
  TextEditingController _locationTextEditingController =
      TextEditingController(text: PLEASE_SELECT_ADDRESS.tr());

  @override
  void initState() {
    locationNotifier = Provider.of<LocationNotifier>(context, listen: false);
    locationNotifier.addListener(updateLocationTextField);
    _gqlMutationService =
        Provider.of<GQLMutationService>(context, listen: false);

    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _storageService = StorageService();

    _currentUser = _globalDataNotifier.localUser;
    _workDetail = WorkDetail();

    super.initState();
  }

  @override
  void dispose() {
    _locationTextEditingController.dispose();
    _nameTextEditingController.dispose();
    _mobileTextEditingController.dispose();
    _whatsappNumberTextEditingController.dispose();

    _descriptionTextEditingController.dispose();

    _shopNameTextEditingController.dispose();
    _scrollController.dispose();
    locationNotifier.removeListener(updateLocationTextField);

    super.dispose();
  }

  updateLocationTextField() {
    _locationTextEditingController.text = (locationNotifier.address != null)
        ? locationNotifier.address.addressLine.toString()
        : PLEASE_SELECT_ADDRESS.tr();
  }

  Future<void> pickWorkImages() async {
    List<XFile> images = await _picker.pickMultiImage();
    if (images != null) {
      for (XFile xFile in images) {
        File image = await RegistrationScreenUtilities.getCroppedImage(
            xFile.path,
            compressQuality: 100,
            maxHeight: 400,
            maxWidth: 400);
        _workImages.add(image);
      }
      setState(() {});
    }
  }

  void onRemoveWorkImage(index) {
    setState(() {
      _workImages.removeAt(index);
    });
  }

  // Work details Methods

  Future<List> getWorkImageUrlList() async {
    List<String> urlList = [];
    for (int i = 0; i < _workImages.length; i++) {
      urlList.add(await _storageService.uploadWorkImages(
          image: _workImages[i],
          userId: "+91" + _mobileTextEditingController.text,
          imageIndex: i));
    }
    return urlList;
  }

  Future<void> updateUserDetails() async {
    if (_pickedImage == null &&
        _currentUser.name == _nameTextEditingController.text) return;
    String uploadedImageUrl;
    if (_pickedImage != null)
      uploadedImageUrl = await _storageService.uploadProfilePicAndGetUrl(
        image: _pickedImage,
        userId: _currentUser.id ?? _currentUser.mobileNumber,
      );

    /// Call for user update
    await _gqlMutationService.updateUser.updateUserProfile(
        notifierService: _globalDataNotifier,
        messagingService:
            Provider.of<FirebaseMessagingService>(context, listen: false),
        name: _nameTextEditingController.text,
        image: uploadedImageUrl ?? _currentUser.image,
        gender: _currentUser.gender,
        designation: _currentUser.designation,
        homeAdressLocation: _currentUser.homeAdressLocation,
        id: _currentUser.id);
  }

  Future<void> verifyAndSubmitDetails() async {
    // Check for form validation
    if (_formKey.currentState.validate()) {
      /// Update user profile
      await updateUserDetails();

      // work image list upload
      List<String> imageUrlList;
      if (_workImages.isNotEmpty) imageUrlList = await getWorkImageUrlList();

      // Get location
      Location shopLocation = locationNotifier.location ?? Location();

      /// Get geohash for shop location
      MyGeoHash fluttergeo = MyGeoHash();
      String geoHash = fluttergeo.geoHashForLocation(
        GeoPoint(shopLocation.lat, shopLocation.lon),
        precision: 10,
      );

      // Get values of all other parameters and convert to Professional Object
      Professional professional = Professional(
        id: _currentUser.id,
        geoHash: geoHash,
        totalReviews: 0,
        totalStars: 0,
        mobileNumber: "+91" + _mobileTextEditingController.text,
        whatsappNumber: "+91" + _whatsappNumberTextEditingController.text,
        shopName: _shopNameTextEditingController.text,
        shopLocation: shopLocation,
        shopDescription: _descriptionTextEditingController.text,
        occupationName: _workDetail.occupationValue["name"] ?? "",
        occupationId: _workDetail.occupationValue["id"] ?? "",
        workSpeciality:
            _workDetail.workSpecialities.map<String>((e) => e["name"]).toList(),
        workSpecialityId:
            _workDetail.workSpecialities.map<String>((e) => e["id"]).toList(),
        // workExperience: workExperienceValue,
        workImages: imageUrlList,
        shopAddressLine: _locationTextEditingController.text,
        workExperience: _workDetail.workExperience,
      );
      bool registrationStatus = await CreateAndUpdateProfessional()
          .createProfessionalInDatabase(professional: professional);

      if (registrationStatus) {
        AnalyticsService.firebaseAnalytics.logEvent(
            name: "sp_professional_registration_success",
            parameters: {
              "user_id": _currentUser.id ?? "",
              "whatsapp_number": professional.whatsappNumber ?? "",
              "shop_name": professional.shopName ?? "",
            });
      } else {
        AnalyticsService.firebaseAnalytics
            .logEvent(name: "sp_professional_registration_failed", parameters: {
          "user_id": _currentUser.id ?? "",
          "whatsapp_number": professional.whatsappNumber ?? "",
          "shop_name": professional.shopName ?? "",
        });
      }

      // Push user to registration complete screen
      context.vxNav.replace(
          Uri.parse(MyRoutes.professionalRegistrationComplete),
          params: registrationStatus);
    }
  }

  void onStepContinue() async {
    final isLastStep = _currentFormStep == getSteps().length - 1;
    FocusScope.of(context).unfocus();
    if (isLastStep) {
      setState(() {
        _isLoading = true;
      });
      // Verify and submit Details
      await verifyAndSubmitDetails();
      return;
    }
    if (_stepperFormKeys[_currentFormStep].currentState.validate()) {
      if (!isLastStep) {
        setState(() {
          _currentFormStep += 1;
        });
      }
    }
  }

  void onStepCancel() {
    FocusScope.of(context).unfocus();
    _currentFormStep == 0
        ? null
        : setState(() {
            _currentFormStep -= 1;
          });
  }

  Widget controlsBuilder(
      BuildContext context, ControlsDetails controlsDetails) {
    return Row(
      children: [
        TextButton(
          onPressed: controlsDetails.onStepContinue,
          child: Text(
            _currentFormStep != getSteps().length - 1 ? SUBMIT : REGISTER_NOW,
            style: Theme.of(context).textTheme.bodyText1,
          ).tr(),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(maroonColor),
              minimumSize: MaterialStateProperty.all<Size>(Size(100.0, 30.0))),
        ),
        SizedBox(width: context.safePercentWidth * 3),
        if (_currentFormStep != 0)
          TextButton(
            onPressed: controlsDetails.onStepCancel,
            child: Text(
              CANCEL,
              style: Theme.of(context).textTheme.bodyText1,
            ).tr(),
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(
                Colors.grey,
              ),
              minimumSize: MaterialStateProperty.all<Size>(Size(100.0, 30.0)),
            ),
          ),
      ],
    );
  }

  List<Widget> get workImageListForGridView {
    return _workImages
        .asMap()
        .map(
          (i, image) => MapEntry(
            i,
            Stack(
              fit: StackFit.expand,
              children: [
                // ignore: sized_box_for_whitespace
                Container(
                  height: 100,
                  width: 100,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(2.0),
                    child: Image.file(
                      File(image.path),
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                Positioned(
                  right: -7,
                  top: -7,
                  child: Container(
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                          shape: BoxShape.circle, color: maroonColor),
                      child: IconButton(
                        padding: EdgeInsets.all(0.0),
                        icon: Icon(
                          Icons.delete,
                          color: Colors.white,
                          size: 18.0,
                        ),
                        onPressed: () => onRemoveWorkImage(i),
                      )),
                ),
              ],
            ),
          ),
        )
        .values
        .toList();
  }

  List<Step> getSteps() {
    TextStyle stepsTextStyle = Theme.of(context).textTheme.headline2.copyWith(
        fontSize: responsiveFontSize(context, size: ResponsiveFontSizes.s));
    return [
      Step(
        state: _currentFormStep > 0 ? StepState.complete : StepState.indexed,
        isActive: _currentFormStep == 0,
        title: Text(PERSONAL_DETAILS, style: stepsTextStyle).tr(),
        content: PersonalDetails(
          formKey: _stepperFormKeys[0],
          nameTextEditingController: _nameTextEditingController,
          mobileTextEditingController: _mobileTextEditingController,
          whatsappTextEditingController: _whatsappNumberTextEditingController,
          pickedImage: _pickedImage,
        ),
      ),
      Step(
        state: _currentFormStep > 2 ? StepState.complete : StepState.indexed,
        isActive: _currentFormStep == 2,
        title: Text(WORK_DETAILS, style: stepsTextStyle).tr(),
        content: WorkDetails(
          formKey: _stepperFormKeys[2],
          workDetail: _workDetail,
        ),
      ),
      Step(
        state: _currentFormStep > 1 ? StepState.complete : StepState.indexed,
        isActive: _currentFormStep == 1,
        title: Text(SHOP_DETAILS, style: stepsTextStyle).tr(),
        content: ShopDetails(
          formKey: _stepperFormKeys[1],
          shopNameTextEditingController: _shopNameTextEditingController,
          locationTextEditingController: _locationTextEditingController,
          descriptionTextEditingController: _descriptionTextEditingController,
          address: locationNotifier.address,
          updateLocationTextField: updateLocationTextField,
        ),
      ),
      Step(
        state: _currentFormStep > 3 ? StepState.complete : StepState.indexed,
        isActive: _currentFormStep == 3,
        title: Text(
          WORK_IMAGES,
          style: stepsTextStyle,
        ).tr(),
        content: ListView(
          physics: ClampingScrollPhysics(),
          shrinkWrap: true,
          children: [
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: maroonColor,
              ),
              child: IconButton(
                color: Colors.white,
                icon: Icon(Icons.add_a_photo_outlined),
                // label: Text("Select Images",
                //     style: Theme.of(context).textTheme.bodyText1),
                onPressed: pickWorkImages,
              ),
            ),
            SizedBox(height: _textFieldVerticalPadding * 2),
            if (_workImages.isNotEmpty) ...[
              GridView.count(
                physics: ClampingScrollPhysics(),
                shrinkWrap: true,
                crossAxisCount: 2,
                crossAxisSpacing: 5.0,
                mainAxisSpacing: 5.0,
                children: workImageListForGridView,
              ),
            ],
            SizedBox(height: _textFieldVerticalPadding * 2),
          ],
        ),
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 2.0,
        iconTheme: IconThemeData(color: maroonColor),
        title: Text(
          REGISTER_YOURSELF_AS_PROFESSIONAL,
          style: Theme.of(context).textTheme.headline1.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Card(
        elevation: 2.0,
        color: Theme.of(context).cardColor,
        child: ListView(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: context.safePercentHeight * 0.4),
            Card(
              elevation: 0.0,
              color: Theme.of(context).cardColor,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(5.0)),
                // child: Stack(
                //   children: <Widget>[
                child: Padding(
                  padding: EdgeInsets.symmetric(
                      horizontal: context.safePercentWidth * 0),
                  child: CachedNetworkImage(
                    imageUrl: registerPageBannerImage,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) =>
                            RectangularImageLoading(),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
              ),
            ),

            ///
            _isLoading
                ? Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: context.safePercentHeight * 5),
                    child: Center(
                      child: CircularProgressIndicator(
                        color: maroonColor,
                      ),
                    ),
                  )
                : Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.safePercentWidth * 1),
                    child: Form(
                      key: _formKey,
                      child: Container(
                        // height: 700.0,
                        width: double.infinity,
                        child: Theme(
                          data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                            primary: maroonColor,
                            onSurface: maroonColor,
                          )),
                          child: Stepper(
                            elevation: 2.0,
                            physics: ClampingScrollPhysics(),
                            type: StepperType.vertical,
                            steps: getSteps(),
                            currentStep: _currentFormStep,
                            // onStepTapped: (step) => setState(() {
                            //   _currentStep = step;
                            // }),
                            onStepCancel: onStepCancel,
                            onStepContinue: onStepContinue,
                            controlsBuilder: controlsBuilder,
                          ),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );
  }
}
