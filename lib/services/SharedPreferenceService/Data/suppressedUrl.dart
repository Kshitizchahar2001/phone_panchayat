// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceDataStorage.dart';

class SuppressedUrlStorage {
  SharedPreferenceDataStorage name;
  SharedPreferenceDataStorage suppressedUrl;
  SharedPreferenceDataStorage showWebPage;

  SuppressedUrl obj;

  SuppressedUrlStorage() {
    name = SharedPreferenceDataStorage(
        keyName: 'suppressedUrlName', dataType: DataType.String);
    suppressedUrl = SharedPreferenceDataStorage(
        keyName: 'suppressedUrl', dataType: DataType.String);
    showWebPage = SharedPreferenceDataStorage(
        keyName: 'showWebPage', dataType: DataType.BOOL);
    obj = getData();
  }

  Future<void> setData(SuppressedUrl data) async {
    await name.set(data.name);
    await suppressedUrl.set(data.url);
    await showWebPage.set(data.showWebPage);
  }

  SuppressedUrl getData() {
    return SuppressedUrl(
      name: name.get(),
      url: suppressedUrl.get(),
      showWebPage: showWebPage.get(),
    );
  }

  Future<void> remove() async {
    await name.remove();
    await suppressedUrl.remove();
    await showWebPage.remove();
  }
}

class SuppressedUrl {
  String name;
  String url;
  bool showWebPage;
  SuppressedUrl({
    @required this.name,
    @required this.url,
    @required this.showWebPage,
  });
}
