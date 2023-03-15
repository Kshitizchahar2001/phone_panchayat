// ignore_for_file: file_names, prefer_is_empty, prefer_const_constructors, await_only_futures, deprecated_member_use, curly_braces_in_flow_control_structures

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/placeType.dart';
import 'package:online_panchayat_flutter/enum/subscriptionType.dart';
import 'package:online_panchayat_flutter/enum/subscription_plan.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/models/Status.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/models/UserSubscription.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/place.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/placeIdentifierTile.dart';
import 'package:online_panchayat_flutter/screens/additional_tehsil_select/tehsil_checkbox.dart';
import 'package:online_panchayat_flutter/screens/payement_gateway/razorpay_payment.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/custom_snackbar.dart';
import 'package:online_panchayat_flutter/services/SharedPreferenceService/sharedPreferenceService.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createAdditionalTehsil.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createUserSubscription.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class AdditionalTehsilPlaceList extends StatefulWidget {
  final Place place;
  const AdditionalTehsilPlaceList({
    Key key,
    @required this.place,
  }) : super(key: key);

  @override
  _AdditionalTehsilPlaceListState createState() =>
      _AdditionalTehsilPlaceListState();
}

class _AdditionalTehsilPlaceListState extends State<AdditionalTehsilPlaceList> {
  TextEditingController textEditingController;
  bool loading = false;
  RazorpayPayment _razorpayPayment;
  String subscriptionId;

  @override
  void initState() {
    widget.place.initialisePlaceList();

    textEditingController = TextEditingController();
    textEditingController.addListener(listener);
    _razorpayPayment = RazorpayPayment(
        _handlePaymentSuccess, _handlePaymentError, _handleExternalWallet);

    super.initState();
  }

  @override
  void dispose() {
    textEditingController.removeListener(listener);
    textEditingController.dispose();
    _razorpayPayment.clearRazorpay();
    super.dispose();
  }

  void listener() {
    widget.place.searchBarTextFieldListener(textEditingController.text);
  }

  /// On Additional Tehsil Button clicked
  void onAddTehsils() async {
    /// Check if user have selected atleast one tehsil
    if (widget.place.getSelectedPlaceIds.length == 0) {
      showSnackBar(
          context, SELECT_ONE_TEHSIL, Icon(Icons.error, color: Colors.white));
      return;
    }

    setState(() {
      loading = true;
    });

    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_add", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "subscription":
          Services.globalDataNotifier.localUser.subscriptionPlan ?? "",
      "subscriptionId": subscriptionId ?? ""
    });

    String localSubId =
        await SharedPreferenceService.fetchAdditionalTehsilSubscriptionId();

    /// Check for Subscription Plan
    if (CheckForPremiumUser.checkForAdditionalTehsilPlan(
            Services.globalDataNotifier.localUser) ||
        localSubId != null) {
      await createTehsil(context);
    } else {
      /// Show payment Gateway
      String description = 'Multiple Tehsil Recurring Subscription';
      // await _razorpayPayment.processOrderPayment(
      //     RemoteConfigService.multipleTehsilPrice, context,
      //     description: description);

      int timeStamp =
          DateTime.now().add(Duration(minutes: 30)).millisecondsSinceEpoch;
      String planName = enumToString(SubscriptionPlan.MULTIPLE_TEHSIL);
      subscriptionId = await _razorpayPayment.processSubscriptionPayment(
          context,
          RemoteConfigService.multipleTehsilPrice,
          razorpayAdditionalTehsilPlanId,
          planName,
          additionalTehsilPaymentCycleCount,
          expireTimestamp: timeStamp,
          description: description);
    }
    setState(() {
      loading = false;
    });
  }

  void createTehsil(BuildContext context) async {
    setState(() {
      loading = true;
    });
    bool result = await CreateAdditionalTehsil()
        .addTehsilList(tehsilIds: Place.selectedPlaceIds);

    /// Success Snackbar
    if (result) {
      showSnackBar(context, TEHSIL_ADD_SUCCESS,
          Icon(Icons.check_circle, color: Colors.white));
    } else {
      showSnackBar(
          context, TEHSIL_ADD_FAILED, Icon(Icons.error, color: Colors.white));
    }

    setState(() {
      loading = false;
    });

    // Send back to home screen
    Place.selectedPlaceIds = [];
    Navigator.popUntil(context, (route) => route.isFirst);
  }

  void updateUserSubscription(BuildContext context) async {
    User _currentUser = Services.globalDataNotifier.localUser;
    // Update user object with subscription plan

    UserSubscription result = await CreateUserSubscription()
        .createUserSubscription(
            userId: _currentUser.id,
            subscriptionPlan: SubscriptionPlan.MULTIPLE_TEHSIL,
            planType: SubscriptionType.RECURRING,
            status: Status.ACTIVE,
            subscriptionId: subscriptionId);

    if (result != null) {
      showSnackBar(context, SUBSCRIPTION_SUCCESS,
          Icon(Icons.verified_user, color: Colors.white));

      /// Add data to current user profile
      if (_currentUser.subscription != null) {
        _currentUser.subscription.add(result);
      } else {
        await Services.gqlQueryService.getUserById.getUserById(
            notifierService: Services.globalDataNotifier,
            messagingService: Services.firebaseMessagingService,
            usernameOfLoggedInUser: _currentUser.id);
      }
      return;
    } else {
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "UserSubscription_add_failed", parameters: {
        "user_id": Services.globalDataNotifier.localUser.id ?? "",
        "subscription_plan": "MULTIPLE_TEHSIL" ?? "",
        "subscription_id": subscriptionId ?? ""
      });

      /// Set subscription to local storage
      SharedPreferenceService.setAdditionalTehsilSubscriptionId(subscriptionId);
      showSnackBar(
          context, SUBSCRIPTION_FAILED, Icon(Icons.error, color: Colors.white));
    }
  }

  void showSnackBar(BuildContext context, String message, Widget icon) {
    ScaffoldMessenger.of(context)
        .showSnackBar(showResultSnackBar(context, message, icon));
  }

  // -------------------------  Payment Methods -------------------------------
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_payment_success", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "order_id": response.orderId ?? "",
      "payment_id": response.paymentId ?? "",
      "signature": response.signature ?? "",
      "subscription_id": subscriptionId ?? ""
    });

    // Payment Successfull Snackbar
    showSnackBar(
        context, PAYMENT_SUCCESS, Icon(Icons.payments, color: Colors.white));
    // Update user's Subscription plan
    await updateUserSubscription(context);

    // Create additonal Tehsils
    await createTehsil(context);

    // Show screen to share
    context.vxNav.push(Uri.parse(MyRoutes.shareAdditionalTehsil));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_payment_failed", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "error_code": response.code ?? "",
      "error_message": response.message ?? "",
      "subscription_id": subscriptionId ?? "",
      "response": response.toString() ?? "",
    });
    // Show status to user
    showSnackBar(
        context, PAYMENT_ERROR, Icon(Icons.payments, color: Colors.white));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "additional_tehsil_wallet_payment", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "wallet_name": response.walletName ?? "",
      "subscription_id": subscriptionId ?? ""
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget?.place?.label.toString(),
            style: Theme.of(context).textTheme.headline1.copyWith(
                  fontSize: responsiveFontSize(
                    context,
                    size: ResponsiveFontSizes.s10,
                  ),
                ),
          ).tr(),
          actions: [
            Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.safePercentHeight * 1.5,
                  horizontal: context.safePercentWidth * 1),
              child: ElevatedButton(
                onPressed: loading ? null : onAddTehsils,
                child: Text(ADD,
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(
                              context,
                              size: ResponsiveFontSizes.s10,
                            ),
                            color: Colors.white))
                    .tr(),
                style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(
                        vertical: context.safePercentHeight * 0.7,
                        horizontal: context.safePercentWidth * 1.3),
                    primary: maroonColor,
                    alignment: Alignment.center,
                    elevation: 0,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20.0))),
              ),
            ),
          ],
        ),
        backgroundColor: Theme.of(context).colorScheme.background,
        body: ChangeNotifierProvider<Place>.value(
          value: widget.place,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.bottomCenter,
              children: [
                Container(
                  alignment: Alignment.topCenter,
                  constraints: BoxConstraints.expand(),
                  child: Image(
                    fit: BoxFit.fitWidth,
                    image: AssetImage(widget.place.image),
                  ),
                ),
                Column(
                  children: [
                    SizedBox(height: context.safePercentHeight * 1),
                    Flexible(
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.safePercentWidth * 10),
                        child: Card(
                          elevation: 2.0,
                          child: Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color:
                                    Theme.of(context).colorScheme.background),
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                  vertical: context.safePercentHeight * 1.2,
                                  horizontal: context.safePercentWidth * 2),
                              child: Text(PAYMENT_INFO,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline1
                                          .copyWith(
                                              fontSize: responsiveFontSize(
                                                context,
                                                size: ResponsiveFontSizes.s10,
                                              ),
                                              color: maroonColor,
                                              fontWeight: FontWeight.bold))
                                  .tr(),
                            ),
                          ),
                        ),
                      ),
                      flex: 2,
                    ),
                    SizedBox(height: context.safePercentHeight * 2.3),
                    Padding(
                      padding: EdgeInsets.symmetric(
                          horizontal: context.safePercentWidth * 10),
                      child: Card(
                        elevation: 2.0,
                        child: Container(
                            color: Theme.of(context).colorScheme.background,
                            child: TextField(
                              autofocus: false,
                              decoration: InputDecoration(
                                suffixIcon: Icon(
                                  FontAwesomeIcons.search,
                                  size: 20,
                                ),
                                // prefix: Icon(FontAwesomeIcons.search),
                                errorStyle: TextStyle(color: Colors.red),
                                focusColor: maroonColor,
                                enabledBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                focusedBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                errorBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                disabledBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                focusedErrorBorder: textFormFieldBorder(context,
                                    color: Colors.transparent),
                                hintText: "खोजें",
                                hintStyle: Theme.of(context)
                                    .textTheme
                                    .headline3
                                    .copyWith(
                                      fontWeight: FontWeight.normal,
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                    ),
                              ),
                              // maxLines: multiLines,
                              keyboardType: TextInputType.name,
                              controller: textEditingController,
                              textCapitalization: TextCapitalization.sentences,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontWeight: FontWeight.normal,
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            )),
                      ),
                    ),
                    SizedBox(height: context.safePercentHeight * 0.5),
                    Flexible(
                      flex: 10,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: context.safePercentWidth * 10),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .colorScheme
                                .background
                                .withOpacity(1.0),
                            borderRadius: BorderRadius.circular(5),
                            border:
                                Border.all(width: 1.0, color: Colors.grey[200]),
                          ),
                          child: loading
                              ? Center(
                                  child: CircularProgressIndicator(),
                                )
                              : Consumer<Place>(
                                  builder: (context, value, child) {
                                    if (value.loading)
                                      return Center(
                                        child: CircularProgressIndicator(
                                          valueColor:
                                              AlwaysStoppedAnimation<Color>(
                                                  maroonColor),
                                          // strokeWidth: 3,
                                        ),
                                      );
                                    else if (value.matchedKeywordsList.length >
                                        0)
                                      return CupertinoScrollbar(
                                        isAlwaysShown: true,
                                        child: ListView.builder(
                                          physics: BouncingScrollPhysics(),
                                          itemCount:
                                              value.matchedKeywordsList.length +
                                                  1,
                                          itemBuilder: (context, index) {
                                            if (index ==
                                                value.matchedKeywordsList
                                                    .length) {
                                              return Container();
                                            } else {
                                              Places places = value
                                                  .matchedKeywordsList[index];
                                              return places.type !=
                                                      PlaceType.TEHSIL
                                                  ? InkWell(
                                                      onTap: () async {
                                                        await widget.place
                                                            .onAdditionalTehsilSelectItemTap(
                                                                context,
                                                                places);
                                                      },
                                                      child:
                                                          PlaceIdentifierTile(
                                                        places: places,
                                                      ),
                                                    )
                                                  : TehsilCheckBoxList(
                                                      places: places,
                                                    );
                                            }
                                          },
                                        ),
                                      );
                                    else
                                      return Container();
                                  },
                                ),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        ));
  }
}

OutlineInputBorder textFormFieldBorder(BuildContext context, {Color color}) {
  return OutlineInputBorder(
    borderSide: BorderSide(width: 1.25, color: color),
    borderRadius: BorderRadius.circular(4),
  );
}
