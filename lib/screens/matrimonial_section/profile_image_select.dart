// ignore_for_file: annotate_overrides, avoid_print, prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers

import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/MatrimonialProfile.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/image_icon.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/screens/widgets/instructionText.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createMatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/custom_button.dart';
import 'package:online_panchayat_flutter/utils/showDialog.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class ProfileImageSelect extends StatefulWidget {
  const ProfileImageSelect({Key key}) : super(key: key);

  @override
  State<ProfileImageSelect> createState() => _ProfileImageSelectState();
}

class _ProfileImageSelectState extends State<ProfileImageSelect> {
  bool errorInUpdatingImages = false;
  File newProfilePic;
  ImagePicker _picker;
  CurrentMatrimonailProfileData _currentMatrimonailProfileData;
  MatrimonialProfile _matrimonialProfile;
  String currentProfilePic;

  void initState() {
    _picker = ImagePicker();
    _currentMatrimonailProfileData =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);
    _matrimonialProfile = _currentMatrimonailProfileData.currentUserProfile;
    getCurrentProfilePhoto();
    super.initState();
  }

  void getCurrentProfilePhoto() {
    if (_matrimonialProfile.profileImage != null) {
      currentProfilePic = _matrimonialProfile.profileImage;
      return;
    }
    if (_matrimonialProfile.images != null &&
        _matrimonialProfile.images.isNotEmpty) {
      currentProfilePic = _matrimonialProfile.images[0];
      return;
    }
    currentProfilePic = DEFAULT_USER_IMAGE_URL;
  }

  void takePhotoByCamera() async {
    File pickedImage;
    XFile image = await _picker.pickImage(
        source: ImageSource.camera, preferredCameraDevice: CameraDevice.front);
    if (image != null) {
      pickedImage = await RegistrationScreenUtilities.getCroppedImage(
          image.path,
          maxHeight: 500,
          maxWidth: 500,
          compressQuality: 100);
      if (pickedImage != null) {
        setState(() {
          newProfilePic = pickedImage;
        });
      }
    } else {
      print('No image selected.');
    }
  }

  void takePhotoByGallery() async {
    File pickedImage;
    XFile image = await _picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      pickedImage = await RegistrationScreenUtilities.getCroppedImage(
          image.path,
          maxHeight: 500,
          maxWidth: 500,
          compressQuality: 100);
      if (pickedImage != null) {
        setState(() {
          newProfilePic = pickedImage;
        });
      }
    } else {
      print('No image selected.');
    }
  }

  void uploadImagesToFirebase() async {
    showMaterialDialog(context);
    if (newProfilePic != null) {
      StorageService _storageService = StorageService();

      String imageUrl = await _storageService.uploadMatrimonailProfileImage(
        image: newProfilePic,
        imageName:
            _matrimonialProfile?.id ?? Services.globalDataNotifier.localUser.id,
      );

      /// Update all the links to user profile
      bool result;
      if (imageUrl != null) {
        result = await CreateMatrimonialProfile().updateMatrimonialProfileImage(
            id: _matrimonialProfile?.id ??
                Services.globalDataNotifier.localUser.id,
            image: imageUrl);
      }

      if (result) {
        _currentMatrimonailProfileData.fetchMatrimonailProfile();
        Navigator.of(context).pop();
        Navigator.of(context).pop();
      } else {
        setState(() {
          errorInUpdatingImages = true;
        });
        Navigator.of(context).pop();
      }
    } else {
      Navigator.of(context).pop();
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
          SELECT_PROFILE_PHOTO,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 0),
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
        child: Card(
          color: Theme.of(context).cardColor,
          elevation: 0,
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                if (errorInUpdatingImages) ...[
                  InstructionText(
                    text: UPDATE_IMAGES_ERROR,
                    textColor: Colors.red,
                    backgroundColor: Colors.red[50],
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 1,
                  ),
                ],
                SizedBox(height: context.safePercentHeight * 3),
                Container(
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(15.0)),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.safePercentWidth * 0),
                      child: newProfilePic == null
                          ? CachedNetworkImage(
                              fit: BoxFit.fitHeight,
                              imageUrl: currentProfilePic,
                              progressIndicatorBuilder:
                                  (context, url, downloadProgress) =>
                                      RectangularImageLoading(),
                              errorWidget: (context, url, error) =>
                                  Icon(Icons.error),
                            )
                          : Image.file(
                              newProfilePic,
                              fit: BoxFit.fitHeight,
                            ),
                    ),
                  ),
                ),
                SizedBox(
                  height: context.safePercentHeight * 1,
                ),
                Container(
                  decoration: BoxDecoration(
                      border: Border.all(color: maroonColor),
                      borderRadius: BorderRadius.circular(15.0)),
                  padding: EdgeInsets.symmetric(
                      vertical: context.safePercentHeight * 2.5,
                      horizontal: context.safePercentWidth * 4),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ImageSelectIcon(
                          icon: Icon(
                            Icons.add_a_photo_outlined,
                            color: maroonColor,
                            size: context.safePercentHeight * 4,
                          ),
                          text: Text(
                            TAKE_PHOTO,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    color: maroonColor,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.xs)),
                          ).tr(),
                          onPress: takePhotoByCamera,
                        ),
                        ImageSelectIcon(
                          icon: Icon(
                            Icons.image_search,
                            color: maroonColor,
                            size: context.safePercentHeight * 4,
                          ),
                          text: Text(
                            SELECT_PHOTO,
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                .copyWith(
                                    color: maroonColor,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.xs)),
                          ).tr(),
                          onPress: takePhotoByGallery,
                        ),
                      ]),
                ),
                SizedBox(
                  height: context.safePercentHeight * 5,
                ),
                Center(
                  child: CustomButton(
                    iconData: FontAwesomeIcons.chevronRight,
                    text: ADD_PHOTO,
                    buttonColor: maroonColor,
                    autoSize: true,
                    borderRadius: 10,
                    onPressed: uploadImagesToFirebase,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
