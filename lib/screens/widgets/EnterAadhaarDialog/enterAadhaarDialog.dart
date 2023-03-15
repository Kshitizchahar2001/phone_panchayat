// ignore_for_file: file_names, use_key_in_widget_constructors, unnecessary_new, prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/EnterAadhaarDialog/aadhaarRules.dart';
import 'package:online_panchayat_flutter/screens/widgets/EnterAadhaarDialog/aadhaarVerificationStatus.dart';
import 'package:online_panchayat_flutter/services/gqlMutationService.dart';
import 'package:online_panchayat_flutter/services/notificationService.dart';
import 'package:online_panchayat_flutter/services/storageService.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'uploadAadhaarImageWidget.dart';
import 'aadhaarNumberInputWidget.dart';
import 'dart:io';

class EnterAadhaarDialog extends StatefulWidget {
  @override
  _EnterAadhaarDialogState createState() => _EnterAadhaarDialogState();
}

class _EnterAadhaarDialogState extends State<EnterAadhaarDialog> {
  @override
  Widget build(BuildContext context) {
    return Responsive(
      mobile: BuildResponsiveEnterAadhaarDialog(),
      tablet: BuildResponsiveEnterAadhaarDialog(),
      desktop: BuildResponsiveEnterAadhaarDialog(),
    );
  }
}

class BuildResponsiveEnterAadhaarDialog extends StatefulWidget {
  @override
  _BuildResponsiveEnterAadhaarDialogState createState() =>
      _BuildResponsiveEnterAadhaarDialogState();
}

class _BuildResponsiveEnterAadhaarDialogState
    extends State<BuildResponsiveEnterAadhaarDialog> {
  TextEditingController aadharNumberTextEditingController =
      new TextEditingController();
  GQLMutationService _gqlMutationService;
  GlobalDataNotifier _globalDataNotifier;
  FirebaseMessagingService _messagingService;
  int currentIndex = AadhaarRules.initialPage;
  PageController pageController;
  var currentTab;
  AadhaarInputData aadhaarInputData;

  submitAadhaarNumber() async {
    String uploadedAadhaarImageLink;
    showMaterialDialog(context);
    if (aadhaarInputData.pickedAadhaarImage != null) {
      print("uploading image to storage.....");
      uploadedAadhaarImageLink = await StorageService()
          .uploadAadhaarImageAndGetUrl(
              image: aadhaarInputData.pickedAadhaarImage,
              userId: _globalDataNotifier.localUser.id);
      print("uploading image to storage complete!");
    }

    try {
      await _gqlMutationService.updateUser
          .updateUserAadhaar(
              messagingService: _messagingService,
              notifierService: _globalDataNotifier,
              id: _globalDataNotifier.localUser.id,
              aadharNumber: aadharNumberTextEditingController.text,
              aadhaarImageUrl: uploadedAadhaarImageLink)
          .then((value) => Navigator.of(context).pop());
      if (AadhaarRules.isUserVerificationMandatory) {
        pageController.nextPage(
            duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
      } else
        Navigator.of(context).pop();
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  @override
  void initState() {
    aadhaarInputData = AadhaarInputData();
    pageController = PageController(initialPage: currentIndex);
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);

    // ignore: null_aware_before_operator
    if (((_globalDataNotifier.localUser.aadharNumber?.length ?? 0) > 0) ??
        false) {
      aadharNumberTextEditingController.text =
          _globalDataNotifier.localUser.aadharNumber;
    }
    currentTab = <Widget>[
      AadhaarNumberInputWidget(
        aadharNumberTextEditingController: aadharNumberTextEditingController,
        pageController: pageController,
      ),
      UploadAadhaarImageWidget(
        pageController: pageController,
        aadhaarInputData: aadhaarInputData,
        aadharNumberTextEditingController: aadharNumberTextEditingController,
        onSubmitted: submitAadhaarNumber,
      ),
      AadhaarVerificationStatus(
        aadharNumberTextEditingController: aadharNumberTextEditingController,
      ),
    ];
    super.initState();
  }

  @override
  void dispose() {
    aadharNumberTextEditingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _gqlMutationService = Provider.of<GQLMutationService>(context);
    _messagingService =
        Provider.of<FirebaseMessagingService>(context, listen: false);

    return WillPopScope(
      onWillPop: () async {
        if (pageController.page.toInt() == 1) {
          pageController.previousPage(
              duration: Duration(milliseconds: 500), curve: Curves.easeInOut);
          return false;
        } else {
          Navigator.pop(context);
          Navigator.pop(context);
        }
        return false;
      },
      child: Container(
        height: context.safePercentHeight * 75,
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(10),
        ),
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          children: currentTab,
          controller: pageController,
          onPageChanged: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

class AadhaarInputData {
  File pickedAadhaarImage;
}
