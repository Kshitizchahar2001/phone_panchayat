
// ignore_for_file: file_names

import 'package:connectivity/connectivity.dart';
import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/enum/connectivityStatus.dart';

class ConnectivityService extends ChangeNotifier {
  ConnectivityStatus connectivityStatus = ConnectivityStatus.Cellular;
  ConnectivityStatus oldConnectivityStatus;

  ConnectivityService() {
    initialiseConnectivityStatus();
    Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
      oldConnectivityStatus = connectivityStatus;
      connectivityStatus = _getStatusFromResult(result);
      notifyListeners();
    });
  }

  ConnectivityStatus _getStatusFromResult(ConnectivityResult result) {
    switch (result) {
      case ConnectivityResult.mobile:
        return ConnectivityStatus.Cellular;
        break;
      case ConnectivityResult.wifi:
        return ConnectivityStatus.Wifi;
        break;
      case ConnectivityResult.none:
        return ConnectivityStatus.Offline;
        break;
      default:
        return ConnectivityStatus.Offline;
    }
  }

  void initialiseConnectivityStatus() async {
    connectivityStatus =
        _getStatusFromResult(await Connectivity().checkConnectivity());
    notifyListeners();
  }
}
