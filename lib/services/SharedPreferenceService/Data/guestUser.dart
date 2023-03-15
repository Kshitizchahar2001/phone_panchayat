// ignore_for_file: file_names

import 'package:online_panchayat_flutter/services/SharedPreferenceService/Data/keyConstants.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/Models/GuestUser.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceDataStorage.dart';

class GuestUserStorage {
  SharedPreferenceDataStorage tag;
  SharedPreferenceDataStorage area;
  SharedPreferenceDataStorage stateId;
  SharedPreferenceDataStorage districtId;

  GuestUser obj;

  GuestUserStorage() {
    tag = SharedPreferenceDataStorage(
        keyName: guestUserTag, dataType: DataType.String);
    area = SharedPreferenceDataStorage(
        keyName: guestUserArea, dataType: DataType.String);
    stateId = SharedPreferenceDataStorage(
        keyName: guestUserStateId, dataType: DataType.String);
    districtId = SharedPreferenceDataStorage(
        keyName: guestUserDistrictId, dataType: DataType.String);
    obj = getData();
  }

  Future<void> setData(GuestUser data) async {
    await tag.set(data.tag);
    await area.set(data.area);
    await districtId.set(data.districtId);
    await stateId.set(data.stateId);
  }

  GuestUser getData() {
    return GuestUser(
      tag: tag.get(),
      area: area.get(),
      districtId: districtId.get(),
      stateId: stateId.get(),
    );
  }

  Future<void> remove() async {
    await tag.remove();
    await area.remove();
    await stateId.remove();
    await districtId.remove();
  }
}
