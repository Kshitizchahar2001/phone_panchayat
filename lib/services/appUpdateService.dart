// ignore_for_file: file_names, unnecessary_this

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/cupertino.dart';
import 'package:in_app_update/in_app_update.dart';

class AppUpdateService extends ChangeNotifier {
  AppUpdateInfo _updateInfo;

  bool infoAvailable;
  bool immediateUpdateAvailable;
  bool canStartFlexibleUpdate;
  bool canCompleteFlexibleUpdate;
  bool showCompleteUpdateDialog;

  AppUpdateService() {
    this.immediateUpdateAvailable = false;
    this.canStartFlexibleUpdate = false;
    this.canCompleteFlexibleUpdate = false;
    this.infoAvailable = false;
    this.showCompleteUpdateDialog = true;
  }

  Future<void> checkForUpdate() async {
    try {
      _updateInfo = await InAppUpdate.checkForUpdate();
      immediateUpdateAvailable = _updateInfo.immediateUpdateAllowed;
      canStartFlexibleUpdate = _updateInfo.flexibleUpdateAllowed;
      canCompleteFlexibleUpdate =
          _updateInfo?.installStatus == InstallStatus.downloaded;
      infoAvailable = true;
      notifyListeners();
    } catch (e, s) {
      infoAvailable = false;
      notifyListeners();
      FirebaseCrashlytics.instance
          .recordError("Error while checking for update " + e, s);
    }
  }

  void removeCompleteUpdateDialog() {
    this.showCompleteUpdateDialog = false;
    notifyListeners();
  }

  Future<void> startFlexibleUpdate() async {
    try {
      await InAppUpdate.startFlexibleUpdate();
      await checkForUpdate();
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error: cannot start flexible update " + e, s);
    }
  }

  Future<void> completeFlexibleUpdate() async {
    try {
      await InAppUpdate.completeFlexibleUpdate();
      await checkForUpdate();
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error : cannot complete flexible update " + e, s);
    }
  }

  Future<void> performImmediateUpdate() async {
    try {
      await InAppUpdate.performImmediateUpdate();
    } catch (e, s) {
      FirebaseCrashlytics.instance
          .recordError("Error : cannot perform immediate upate : " + e, s);
    }
  }
}
