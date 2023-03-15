// ignore_for_file: file_names, unnecessary_this

import 'package:flutter/cupertino.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/district.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'place.dart';
import 'package:easy_localization/easy_localization.dart';

class PlaceState extends Place {
  static Map<String, Locale> statesLocale = <String, Locale>{
    'state1': Locales.hindi, //rajasthan
    'state2': Locales.hindi, //up
    // 'state3': Locales.english, //delhi
  };
  // :

  PlaceState() {
    this.image = india_image_2;
    this.label = SELECT_STATE;
  }

  @override
  Future<List<Places>> getItems() async {
    placeList = await Services.gqlQueryService.searchPlacedByParentIdAndType
        .searchPlacedByParentIdAndType(
      parentId: 'country1',
    );
    placeList.removeWhere(
        (element) => element.name_hi == null || element.name_hi == "");
    return placeList;
  }

  @override
  onAdditionalTehsilSelectItemTap(BuildContext context, Places places) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_state_selected", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "state_id": places?.id ?? "",
      "state_name_hi": places?.name_hi ?? "",
      "state_name_en": places?.name_en ?? "",
    });
    context.vxNav.push(Uri.parse(MyRoutes.selectAdditionalTehsil),
        params: District(state: places));
  }

  @override
  onItemTap(BuildContext context, Places places) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "state_selected", parameters: {
      "state_id": places?.id ?? "",
      "state_name_hi": places?.name_hi ?? "",
      "state_name_en": places?.name_en ?? "",
    });
    context.vxNav
        .push(
      Uri.parse(
        MyRoutes.placeList,
      ),
      params: District(state: places),
    )
        .then((val) async {
      switchLocale(context, places);
      // todo: uncomment to implement functionality
    });
  }

  switchLocale(BuildContext context, Places selectedState) async {
    ThemeProvider themeProvider =
        Provider.of<ThemeProvider>(context, listen: false);

    await context
        .setLocale(PlaceState.statesLocale[selectedState.id] ?? Locales.hindi);
    themeProvider.notifyThemeProviderListeners();
  }

  @override
  onTapBottomButton(BuildContext context) {
    throw UnimplementedError();
  }

  @override
  Future<void> signupWithSuggestion(BuildContext context) {
    throw UnimplementedError();
  }
}
