// ignore_for_file: file_names

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/models/LiveNews.dart';
import 'package:online_panchayat_flutter/services/services.dart';

class StateLiveNewsData {
  List<LiveNews> list;
  ValueNotifier<bool> loading;
  bool dataFetched;

  StateLiveNewsData() {
    list = <LiveNews>[];
    dataFetched = false;
    loading = ValueNotifier(false);
    fetchStories();
  }

  Future<List<LiveNews>> fetchStories() async {
    if (dataFetched) return list;
    loading.value = true;
    list = await Services.globalDataNotifier.gqlQueryService.searchNewsByPlace
        .searchNewsByPlace(
      placeId: Services.globalDataNotifier.localUser.state_id,
    );
    loading.value = false;
    dataFetched = true;
    return list;
  }
}
