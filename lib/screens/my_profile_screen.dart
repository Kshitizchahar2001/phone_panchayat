// ignore_for_file: use_key_in_widget_constructors, prefer_const_literals_to_create_immutables, prefer_const_constructors, prefer_is_empty, curly_braces_in_flow_control_structures, avoid_print, unnecessary_string_interpolations, deprecated_member_use, sized_box_for_whitespace, await_only_futures, prefer_const_constructors_in_immutables

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/subscriptionType.dart';
import 'package:online_panchayat_flutter/enum/subscription_plan.dart';
import 'package:online_panchayat_flutter/models/AdditionalTehsil.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/models/UserSubscription.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/placeState.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/custom_snackbar.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/deleteAdditionalTehsil.dart';
import 'package:provider/provider.dart';
import '../constants/constants.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';

class MyProfile extends StatefulWidget {
  @override
  _MyProfileState createState() => _MyProfileState();
}

class _MyProfileState extends State<MyProfile> {
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeProvider = Provider.of<ThemeProvider>(context);
    GlobalDataNotifier globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);

    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: MY_PROFILE,
      ),
      body: Responsive(
        mobile: ResponsiveMyProfile(
          themeProvider: themeProvider,
          globalDataNotifier: globalDataNotifier,
        ),
        tablet: ResponsiveMyProfile(
          themeProvider: themeProvider,
          globalDataNotifier: globalDataNotifier,
        ),
        desktop: ResponsiveMyProfile(
          themeProvider: themeProvider,
          globalDataNotifier: globalDataNotifier,
        ),
      ),
    );
  }
}

class ResponsiveMyProfile extends StatelessWidget {
  final GlobalDataNotifier globalDataNotifier;
  final ThemeProvider themeProvider;

  void _onRemoveAdditionalTehsil(BuildContext context) async {
    await showGeneralDialog(
      context: context,
      pageBuilder: (ctx, a1, a2) => Container(),
      transitionBuilder: (context, animation, animation1, child) {
        var curve = Curves.bounceInOut.transform(animation.value);
        return Transform.scale(
          child: DeleteAdditionalTehsilDialog(
              initailItems: [],
              items: globalDataNotifier.additionalTehsilList.value),
          scale: curve,
        );
      },
      transitionDuration: Duration(milliseconds: 300),
    );
  }

  void _onCancelSubcriptionPlan(String subscriptionId) async {}

  const ResponsiveMyProfile(
      {Key key,
      @required this.themeProvider,
      @required this.globalDataNotifier})
      : super(key: key);

  bool get isUserHaveAdditionalTehsil {
    User currentUser = globalDataNotifier.localUser;
    if (currentUser.additionalTehsils != null &&
        globalDataNotifier.additionalTehsilList.value.length != 0) return true;

    return false;
  }

  List<UserSubscription> getUserSubscription() {
    List<UserSubscription> subscriptionPlanList = [];
    User currentUser = globalDataNotifier.localUser;

    if (currentUser.subscription != null &&
        currentUser.subscription.isNotEmpty) {
      for (int i = 0; i < currentUser.subscription.length; i++) {
        if (currentUser.subscription[i].planType ==
                SubscriptionType.RECURRING &&
            currentUser.subscription[i].status == Status.ACTIVE)
          subscriptionPlanList.add(currentUser.subscription[i]);
      }
    }

    print(currentUser.subscription);

    return subscriptionPlanList.toSet().toList();
  }

  List<SubscriptionPlan> getUsersOneTimePlansList() {
    List<SubscriptionPlan> oneTimePlanList = [];
    User currentUser = globalDataNotifier.localUser;
    if (currentUser.subscriptionPlan != null)
      oneTimePlanList.add(currentUser.subscriptionPlan);

    if (currentUser.subscriptionPlanList != null &&
        currentUser.subscriptionPlanList.isNotEmpty)
      oneTimePlanList.add(currentUser.subscriptionPlanList[0]);

    if (currentUser.subscription != null &&
        currentUser.subscription.isNotEmpty) {
      for (int i = 0; i < currentUser.subscription.length; i++) {
        if (currentUser.subscription[i].planType == SubscriptionType.ONE_TIME)
          oneTimePlanList.add(currentUser.subscription[i].subscriptionPlan);
      }
    }

    return oneTimePlanList.toSet().toList();
  }

  @override
  Widget build(BuildContext context) {
    List<UserSubscription> subscriptionPlanList = getUserSubscription();
    List<SubscriptionPlan> oneTimePlanList = getUsersOneTimePlansList();
    bool isPremiumUser =
        CheckForPremiumUser.isPremiumUser(globalDataNotifier.localUser);
    var designationText = isPremiumUser
        ? "Premium ${globalDataNotifier.localUser.designation ?? ""}"
        : "${globalDataNotifier.localUser.designation ?? ""}";
    return Container(
      constraints: BoxConstraints.expand(),
      // color: Colors.white,
      child: SingleChildScrollView(
        child: Padding(
          padding: getPostWidgetSymmetricPadding(context, horizontal: 1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Card(
                child: Container(
                  decoration: CheckForPremiumUser.isPremiumUser(
                          globalDataNotifier.localUser)
                      ? BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage(premium_user_background),
                              fit: BoxFit.fill))
                      : null,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 6,
                        width: double.infinity,
                      ),
                      CircleAvatar(
                        backgroundColor: Colors.white,
                        radius: context.safePercentHeight * 7,
                        backgroundImage:
                            globalDataNotifier.localUser.image != null
                                ? Image.network(
                                    globalDataNotifier.localUser.image,
                                  ).image
                                : null,
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        "${globalDataNotifier.localUser.name ?? ""}",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m),
                            fontWeight: FontWeight.bold,
                            color: isPremiumUser ? Colors.white : null),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Text(
                        designationText ?? "",
                        style: Theme.of(context).textTheme.headline3.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s),
                            color: yellowColor),
                      ),
                      SizedBox(
                        height: 12,
                      ),
                      CustomButton(
                        text: EDIT_PROFILE.tr(),
                        onPressed: () {
                          context.vxNav.push(Uri.parse(MyRoutes.editProfile));
                        },
                        edgeInsets:
                            EdgeInsets.symmetric(vertical: 6, horizontal: 10),
                        borderRadius: 100,
                        iconData: FontAwesomeIcons.chevronRight,
                        textColor: Colors.white,
                        buttonColor: finnColor,
                        boxShadow: [],
                        autoSize: false,
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s10),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding:
                      getPostWidgetSymmetricPadding(context, horizontal: 4),
                  child: InkWell(
                    onTap: () {
                      context.vxNav.push(Uri.parse(MyRoutes.placeList),
                          params: PlaceState());
                    },
                    child: UserFieldTile(
                      label: TEHSIL,
                      text: globalDataNotifier.localUser.area ?? "",
                      showDivider: false,
                      button: Row(
                        children: [
                          Text(
                            CHANGE_TEHSIL.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: maroonColor,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s)),
                          ),
                          Icon(
                            FontAwesomeIcons.chevronRight,
                            color: maroonColor,
                            size: 12,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              Card(
                child: Padding(
                  padding:
                      getPostWidgetSymmetricPadding(context, horizontal: 4),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 4,
                      ),
                      UserFieldTile(
                        label: DATE_OF_BIRTH,
                        text: globalDataNotifier.localUser.dateOfBirth
                            ?.toString(),
                      ),
                      SizedBox(
                        height: context.safePercentHeight * 2,
                      ),
                      UserFieldTile(
                        label: ADDRESS,
                        text: globalDataNotifier.localUser.homeAdressName,
                      ),
                      SizedBox(
                        height: context.safePercentHeight * 2,
                      ),
                      UserFieldTile(
                        label: AADHAR_NUMBER,
                        text: globalDataNotifier.localUser.aadharNumber ?? "",
                        showDivider: false,
                      ),
                    ],
                  ),
                ),
              ),
              if (isPremiumUser && oneTimePlanList.isNotEmpty) ...[
                Card(
                  child: Padding(
                    padding:
                        getPostWidgetSymmetricPadding(context, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "One Time Plan",
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s)),
                        ).tr(),
                        SizedBox(
                          height: context.safePercentHeight * 1,
                        ),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            children: oneTimePlanList.map((planName) {
                              return Container(
                                  margin:
                                      EdgeInsets.only(right: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: maroonColor),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  child:
                                      Text(enumToString(planName) ?? "").tr());
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (isPremiumUser && subscriptionPlanList.isNotEmpty) ...[
                Card(
                  child: Padding(
                    padding:
                        getPostWidgetSymmetricPadding(context, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          SUBSCRIPTION_PLAN,
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s)),
                        ).tr(),
                        SizedBox(
                          height: context.safePercentHeight * 1,
                        ),
                        Container(
                          width: double.infinity,
                          child: Column(
                            children: subscriptionPlanList.map((plan) {
                              return Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Container(
                                      margin: EdgeInsets.only(
                                          right: 5.0, bottom: 5.0),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          color: maroonColor),
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8.0, horizontal: 12.0),
                                      child: Text(enumToString(
                                                  plan.subscriptionPlan) ??
                                              "")
                                          .tr()),
                                  CustomButton(
                                    text: CANCEL,
                                    onPressed: () async =>
                                        await _onCancelSubcriptionPlan(
                                            plan.subscriptionId),
                                    edgeInsets: EdgeInsets.symmetric(
                                        vertical: 6, horizontal: 10),
                                    borderRadius: 100,
                                    iconData: FontAwesomeIcons.chevronRight,
                                    textColor: Colors.white,
                                    buttonColor: lightGreySubheading,
                                    boxShadow: [],
                                    autoSize: false,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                                ],
                              );
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
              if (isUserHaveAdditionalTehsil) ...[
                Card(
                  child: Padding(
                    padding:
                        getPostWidgetSymmetricPadding(context, horizontal: 4),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          ADDITIONAL_TEHSIL,
                          style: Theme.of(context).textTheme.headline3.copyWith(
                              fontSize: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.s)),
                        ).tr(),
                        SizedBox(
                          height: context.safePercentHeight * 1,
                        ),
                        Container(
                          width: double.infinity,
                          child: Wrap(
                            children: globalDataNotifier
                                .additionalTehsilList.value
                                .map((additionalTehsil) {
                              return Container(
                                  margin:
                                      EdgeInsets.only(right: 5.0, bottom: 5.0),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: maroonColor),
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.0, horizontal: 12.0),
                                  child: Text(GetPlaceName.getPlaceName(
                                      additionalTehsil.place, context)));
                            }).toList(),
                          ),
                        ),
                        SizedBox(
                          height: context.safePercentHeight * 1,
                        ),
                        Center(
                          child: CustomButton(
                            text: REMOVE_ADDITIONAL_TEHSIL.tr(),
                            onPressed: () async =>
                                await _onRemoveAdditionalTehsil(context),
                            edgeInsets: EdgeInsets.symmetric(
                                vertical: 6, horizontal: 10),
                            borderRadius: 100,
                            iconData: FontAwesomeIcons.chevronRight,
                            textColor: Colors.white,
                            buttonColor: finnColor,
                            boxShadow: [],
                            autoSize: false,
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.s10),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class UserFieldTile extends StatelessWidget {
  final String label;
  final String text;
  final Widget button;
  final bool showDivider;
  UserFieldTile({
    @required this.label,
    @required this.text,
    this.button,
    this.showDivider = true,
  });
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.headline3.copyWith(
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.s)),
        ).tr(),
        SizedBox(
          height: context.safePercentHeight * 1,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              text?.toString() ?? "",
              style: Theme.of(context).textTheme.headline1.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s)),
            ),
            button ?? const SizedBox(),
          ],
        ),
        SizedBox(
          height: context.safePercentHeight * 1,
        ),
        showDivider
            ? Divider(
                color: KThemeLightGrey,
                height: 1,
                indent: context.safePercentWidth * 1,
                endIndent: context.safePercentWidth * 1,
              )
            : const SizedBox(),
      ],
    );
  }
}

/// Popup to select Additional Tehsil
class DeleteAdditionalTehsilDialog extends StatefulWidget {
  final List<AdditionalTehsils> items;
  final List<AdditionalTehsils> initailItems;
  const DeleteAdditionalTehsilDialog(
      {Key key, @required this.items, this.initailItems})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _DeleteAdditionalTehsilDialogState();
}

class _DeleteAdditionalTehsilDialogState
    extends State<DeleteAdditionalTehsilDialog> {
  // this variable holds the selected items
  final List<AdditionalTehsils> _selectedItems = [];
  bool loading = false;

  @override
  void initState() {
    if (widget.initailItems != null) _selectedItems.addAll(widget.initailItems);
    super.initState();
  }

// This function is triggered when a checkbox is checked or unchecked
  void _itemChange(AdditionalTehsils itemValue, bool isSelected) {
    setState(() {
      if (isSelected) {
        _selectedItems.add(itemValue);
      } else {
        _selectedItems.remove(itemValue);
      }
    });
  }

  // this function is called when the Cancel button is pressed
  void _cancel() {
    Navigator.pop(context);
  }

// this function is called when the Submit button is tapped
  void _submit() async {
    setState(() {
      loading = true;
    });
    List<String> selectedTehsilIds = _selectedItems
        .map((additionalTehsil) => additionalTehsil.place.id)
        .toList();

    bool result = await DeleteAdditionalTehsils()
        .removeAdditionalTehsilList(tehsilIds: selectedTehsilIds);

    if (result) {
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(
          context,
          TEHSIL_REMOVE_SUCCESS,
          Icon(Icons.check_circle, color: Colors.white)));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(context,
          TEHSIL_REMOVE_FAILED, Icon(Icons.error, color: Colors.white)));
    }

    setState(() {
      loading = false;
    });

    Navigator.popUntil(context, (route) => route.isFirst);
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(
        SELECT_TEHSIL_TO_REMOVE,
        style: Theme.of(context).textTheme.headline1.copyWith(
            fontSize: responsiveFontSize(context, size: ResponsiveFontSizes.m)),
      ).tr(),
      content: SingleChildScrollView(
        child: loading
            ? Center(
                child: CircularProgressIndicator(),
              )
            : ListBody(
                children: widget.items
                    .map((item) => CheckboxListTile(
                          value: _selectedItems.contains(item),
                          title: Text(
                              GetPlaceName.getPlaceName(item.place, context)),
                          controlAffinity: ListTileControlAffinity.leading,
                          onChanged: (isChecked) =>
                              _itemChange(item, isChecked),
                        ))
                    .toList(),
              ),
      ),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(25.0)),
      actions: [
        TextButton(
          child: Text(CANCEL,
              style: TextStyle(
                color: lightBlueBrightColor,
              )).tr(),
          onPressed: _cancel,
          style: TextButton.styleFrom(primary: lightGreySubheading),
        ),
        TextButton(
          child: Text(REMOVE).tr(),
          onPressed: _selectedItems.length > 0 ? _submit : null,
          style: TextButton.styleFrom(primary: maroonColor),
        ),
      ],
    );
  }
}
