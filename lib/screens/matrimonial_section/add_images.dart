// ignore_for_file: annotate_overrides, unnecessary_string_interpolations, avoid_unnecessary_containers, prefer_const_constructors, avoid_print, deprecated_member_use

import 'dart:io';
import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:image_picker/image_picker.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/RegistrationScreen/registrationScreenUtilities.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/delete_icon.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/widgets/image_icon.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/screens/widgets/instructionText.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createMatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';

class AddMatrimonialImages extends StatefulWidget {
  const AddMatrimonialImages({Key key, @required this.profile})
      : super(key: key);

  @override
  State<AddMatrimonialImages> createState() => _AddMatrimonialImagesState();
  final CreateMatrimonialProfileData profile;
}

class _AddMatrimonialImagesState extends State<AddMatrimonialImages> {
  int _currentCrouselIndex = 0;
  final CarouselController _controller = CarouselController();
  final _picker = ImagePicker();
  List<File> selectedImage = [];
  List<String> deletedImagesList = [];
  CurrentMatrimonailProfileData _currentMatrimonailProfileData;
  bool errorInUpdatingImages = false;
  bool autoPlay = false;

  void initState() {
    _currentMatrimonailProfileData =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);
    getAutoPlay();
    super.initState();
  }

  /// Generate randomString for image name
  String generateRandomString(int len) {
    var r = Random();
    return String.fromCharCodes(
        List.generate(len, (index) => r.nextInt(33) + 89));
  }

  void uploadImagesToFirebase() async {
    showMaterialDialog(context);
    if (selectedImage.isNotEmpty || deletedImagesList.isNotEmpty) {
      StorageService _storageService = StorageService();
      List<String> urlList = [];
      for (int i = 0; i < selectedImage.length; i++) {
        urlList.add(await _storageService.uploadMatrimonailProfileImage(
          image: selectedImage[i],
          imageName: widget.profile.id + "${generateRandomString(5)}",
        ));
      }

      /// Delete firebase images
      if (deletedImagesList.isNotEmpty) {
        for (int i = 0; i < deletedImagesList.length; i++) {
          await _storageService.deleteMatrimonialImage(
              url: deletedImagesList[i]);
        }
      }

      List<String> allImageUrls = [];
      allImageUrls.addAll(urlList);
      if (widget.profile.images != null) {
        allImageUrls.addAll(widget.profile.images);
      }

      /// Update all the links to user profile
      bool result = await CreateMatrimonialProfile().updateMatrimonialImages(
          id: widget.profile.id, imageList: allImageUrls);

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

  void deleteFirebaseStorageImage(String imageUrl) {
    setState(() {
      bool result = widget.profile.images.remove(imageUrl);
      if (result) deletedImagesList.add(imageUrl);
    });
    getAutoPlay();
  }

  void deleteLocalImage(File image) {
    setState(() {
      selectedImage.remove(image);
    });
    getAutoPlay();
  }

  void getAutoPlay() {
    int totalNumberOfImages = 0;
    if (widget.profile.images != null && widget.profile.images.isNotEmpty) {
      totalNumberOfImages = totalNumberOfImages + widget.profile.images.length;
    }
    if (selectedImage.isNotEmpty) {
      totalNumberOfImages = totalNumberOfImages + selectedImage.length;
    }

    if (totalNumberOfImages > 1) {
      setState(() {
        autoPlay = true;
      });
      return;
    }
    setState(() {
      autoPlay = false;
    });
  }

  void checkForAutoPlay(int index) {
    if (widget.profile.images != null) {
      int totalImages = widget.profile.images.length + selectedImage.length;
      if (totalImages - 1 == index) {
        setState(() {
          autoPlay = false;
        });
      } else {
        setState(() {
          autoPlay = true;
        });
      }
    } else {
      if (selectedImage.length - 1 == index) {
        setState(() {
          autoPlay = false;
        });
      } else {
        setState(() {
          autoPlay = true;
        });
      }
    }
  }

  List<Widget> get imageSliders {
    List<Widget> images = [];
    if (widget.profile.images != null) {
      images.addAll(widget.profile.images
          .map((item) => Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.safePercentWidth * 0),
                        child: CachedNetworkImage(
                          fit: BoxFit.fitHeight,
                          imageUrl: item,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  RectangularImageLoading(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                    ),
                  ),
                  DeleteIcon(
                    onTap: () => deleteFirebaseStorageImage(item),
                  ),
                ],
              ))
          .toList());
    }
    if (selectedImage.isNotEmpty) {
      images.addAll(selectedImage
          .map((item) => Stack(
                alignment: Alignment.topRight,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      child: Padding(
                          padding: EdgeInsets.symmetric(
                              horizontal: context.safePercentWidth * 0),
                          child: Image.file(
                            item,
                            fit: BoxFit.fitHeight,
                          )),
                    ),
                  ),
                  DeleteIcon(
                    onTap: () => deleteLocalImage(item),
                  ),
                ],
              ))
          .toList());
    }
    return images;
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
          selectedImage.add(pickedImage);
        });
        getAutoPlay();
      }
    } else {
      print('No image selected.');
    }
  }

  void takePhotoByGallery() async {
    XFile image = await _picker.pickImage(source: ImageSource.gallery);
    File pickedImage;
    if (image != null) {
      pickedImage = await RegistrationScreenUtilities.getCroppedImage(
          image.path,
          maxHeight: 500,
          maxWidth: 500,
          compressQuality: 100);
      if (pickedImage != null) {
        setState(() {
          selectedImage.add(pickedImage);
        });
        getAutoPlay();
      }
    } else {
      print('No image selected.');
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
          ADD_PHOTO,
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
                CarouselSlider(
                  items: imageSliders,
                  carouselController: _controller,
                  options: CarouselOptions(
                      height: context.safePercentHeight * 55,
                      autoPlayInterval: Duration(seconds: 2),
                      autoPlay: autoPlay,
                      enlargeCenterPage: false,
                      aspectRatio: 16 / 9,
                      viewportFraction: 1,
                      onPageChanged: (index, reason) {
                        setState(() {
                          _currentCrouselIndex = index;
                        });
                        checkForAutoPlay(index);
                      }),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: imageSliders.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 10.0,
                        height: 10.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? lightGreySubheading
                                    : Colors.black)
                                .withOpacity(_currentCrouselIndex == entry.key
                                    ? 0.9
                                    : 0.4)),
                      ),
                    );
                  }).toList(),
                ),
                SizedBox(height: context.safePercentHeight * 3),
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
