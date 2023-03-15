// ignore_for_file: annotate_overrides, await_only_futures, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:amplify_flutter/amplify_flutter.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/subscription_plan.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/current_matrimonail_profile_data.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/matrimonial_profile_data.dart';
import 'package:online_panchayat_flutter/screens/payement_gateway/razorpay_payment.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/custom_snackbar.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/createMatrimonialProfile.dart';
import 'package:online_panchayat_flutter/services/gqlMutationServices/updateUser.dart';
import 'package:online_panchayat_flutter/services/remoteConfigService.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/globalDataNotifier.dart';
import 'package:provider/provider.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonialPlan extends StatefulWidget {
  const MatrimonialPlan({Key key, @required this.matrimonialProfile})
      : super(key: key);
  final CreateMatrimonialProfileData matrimonialProfile;

  @override
  State<MatrimonialPlan> createState() => _MatrimonialPlanState();
}

class _MatrimonialPlanState extends State<MatrimonialPlan> {
  RazorpayPayment _razorpayPayment;
  CurrentMatrimonailProfileData _currentMatrimonailProfileData;
  Map<String, dynamic> matrimonialPriceConfig;

  bool loading = false;
  bool errorInLoadingPrice = false;

  void initState() {
    matrimonialPriceConfig = RemoteConfigService.matrimonialPriceConfig;
    if (matrimonialPriceConfig == null) {
      errorInLoadingPrice = true;
    }

    _currentMatrimonailProfileData =
        Provider.of<CurrentMatrimonailProfileData>(context, listen: false);
    _razorpayPayment = RazorpayPayment(
        _handlePaymentSuccess, _handlePaymentError, _handleExternalWallet);
    super.initState();
  }

  void dispose() {
    _razorpayPayment.clearRazorpay();
    super.dispose();
  }

  bool doesUserHavePlan() {
    User localUser = Services.globalDataNotifier.localUser;
    if (localUser != null &&
        localUser.subscriptionPlanList != null &&
        localUser.subscriptionPlanList
            .contains(SubscriptionPlan.MATRIMONIAL_PROFILE)) return true;

    return false;
  }

  void onProcessPayment() async {
    bool isUserHavePlan = doesUserHavePlan();

    if ((matrimonialPriceConfig != null &&
            matrimonialPriceConfig["askForPrice"] == true) &&
        !isUserHavePlan) {
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "matrimonial_payment_process", parameters: {
        "user_id": Services.globalDataNotifier.localUser.id ?? "",
        "lookingFor":
            widget.matrimonialProfile.lookingFor.toString().split(".").last ??
                "",
        "gotre":
            widget.matrimonialProfile.gotre.toString().split(".").last ?? "",
        "caste": widget.matrimonialProfile.caste ?? ""
      });

      int price =
          RemoteConfigService.matrimonialPriceConfig["actualPrice"] * 100;
      String planName = enumToString(SubscriptionPlan.MATRIMONIAL_PROFILE);

      await _razorpayPayment.processOrderPayment(context, price, planName,
          description: "Matrimonial Fees");
    } else if ((matrimonialPriceConfig != null &&
            matrimonialPriceConfig["askForPrice"] == false) ||
        isUserHavePlan) {
      await createMatrmonialProfile(context);

      Navigator.pop(context);
      Navigator.pop(context);
      context.vxNav.push(Uri.parse(MyRoutes.shareMatrimonialPlan));
      return;
    } else {
      showSnackBar(context, CANNOT_PROCESS_PAYMENT,
          Icon(Icons.error, color: Colors.white));
    }
  }

  // -------------------------  Payment Methods -------------------------------
  void _handlePaymentSuccess(PaymentSuccessResponse response) async {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "matrimonial_payment_success", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "order_id": response.orderId ?? "",
      "payment_id": response.paymentId ?? "",
      "signature": response.signature ?? ""
    });

    /// ON payment success
    ///Update subscription for user
    await updateUser(context);

    ///
    /// Create user in matrimonial table

    await createMatrmonialProfile(context);

    ///Show screen to share
    Navigator.pop(context);
    Navigator.pop(context);
    context.vxNav.push(Uri.parse(MyRoutes.shareMatrimonialPlan));
  }

  void createMatrmonialProfile(BuildContext context) async {
    setState(() {
      loading = true;
    });
    bool result = await CreateMatrimonialProfile().createMatrimonialProfile(
        matrimonialProfile: widget.matrimonialProfile);

    /// Success Snackbar
    if (result) {
      await _currentMatrimonailProfileData.fetchMatrimonailProfile();
      showSnackBar(context, PROFILE_CREATED,
          Icon(Icons.check_circle, color: Colors.white));

      AnalyticsService.firebaseAnalytics
          .logEvent(name: "matrimonial_profile_created", parameters: {
        "user_id": Services.globalDataNotifier.localUser.id ?? "",
        "gotre": widget.matrimonialProfile.gotre.toString().split(".").last,
        "lookingFor":
            widget.matrimonialProfile.lookingFor.toString().split(".").last,
        "gender": widget.matrimonialProfile.gender.toString().split(".").last
      });
    } else {
      showSnackBar(context, PROFILE_CREATION_FAILED,
          Icon(Icons.error, color: Colors.white));

      /// Adding analytics to handle failure
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "matrimonial_profile_add_failed", parameters: {
        "user_id": Services.globalDataNotifier.localUser.id ?? "",
      });
    }

    setState(() {
      loading = false;
    });
  }

  void updateUser(BuildContext context) async {
    GlobalDataNotifier _globalDataNotifier = Services.globalDataNotifier;
    User _currentUser = _globalDataNotifier.localUser;
    // Update user object with subscription plan
    var variables = {
      "id": _currentUser.id,
      "lat": _currentUser.homeAdressLocation.lat,
      "lon": _currentUser.homeAdressLocation.lon,
      "expectedVersion": Services.firebaseMessagingService.userVersion,
      "subscriptionPlanList": [
        enumToString(SubscriptionPlan.MATRIMONIAL_PROFILE)
      ],
      "isMatrimonialProfileComplete": false
    };

    bool result = await UpdateUser().updateUser(
      variables: variables,
      notifierService: _globalDataNotifier,
      messagingService: Services.firebaseMessagingService,
    );

    if (result) {
      showSnackBar(context, SUBSCRIPTION_SUCCESS,
          Icon(Icons.verified_user, color: Colors.white));
      return;
    }

    showSnackBar(
        context, SUBSCRIPTION_FAILED, Icon(Icons.error, color: Colors.white));

    /// Adding analytics to handle failure
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "matrimonial_subscription_add_failed", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
    });
  }

  /// Method to show snack bar
  void showSnackBar(BuildContext context, String message, Widget icon) {
    ScaffoldMessenger.of(context)
        .showSnackBar(showResultSnackBar(context, message, icon));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "matrimonial_payment_failed", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "error_code": response.code ?? "",
      "error_message": response.message ?? ""
    });
    // // Show status to user
    showSnackBar(
        context, PAYMENT_ERROR, Icon(Icons.payments, color: Colors.white));
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "matrimonial_wallet_payment", parameters: {
      "user_id": Services.globalDataNotifier.localUser.id ?? "",
      "wallet_name": response.walletName ?? "",
    });
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
          SUBSCRIPTION_PLAN,
          style: Theme.of(context).textTheme.headline2.copyWith(
              color: maroonColor,
              fontSize:
                  responsiveFontSize(context, size: ResponsiveFontSizes.m)),
        ).tr(),
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(
            vertical: context.safePercentHeight * 2,
            horizontal: context.safePercentWidth * 3),
        child: errorInLoadingPrice
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    CANNOT_PROCESS_PAYMENT,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.m)),
                  ).tr(),
                  SizedBox(
                    height: context.safePercentHeight * 2,
                  ),
                  ElevatedButton(
                    onPressed: () => Navigator.of(context).pop(),
                    child: Text(
                      GO_BACK,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s),
                          color: Colors.white),
                    ).tr(),
                    style: ElevatedButton.styleFrom(primary: maroonColor),
                  ),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "1",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.xl),
                            fontWeight: FontWeight.bold,
                            color: maroonColor),
                      ),
                      SizedBox(
                        width: context.safePercentWidth * 3,
                      ),
                      Text(
                        "One Time Plan",
                        style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.l),
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                  Divider(
                    color: maroonColor,
                    thickness: 2.0,
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.safePercentWidth * 5),
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      elevation: 2.0,
                      color: lightGreySubheading,
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                            vertical: context.safePercentHeight * 2),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10.0),
                                  color: Colors.white),
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: context.safePercentWidth * 4,
                                    vertical: context.safePercentHeight * 1.5),
                                child: Text(
                                  matrimonialPriceConfig["displayPrice"] ??
                                      "R̶S̶ ̶9̶9̶9̶/̶-̶",
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                          fontSize: responsiveFontSize(context,
                                              size: ResponsiveFontSizes.m),
                                          fontWeight: FontWeight.bold,
                                          color: maroonColor),
                                ),
                              ),
                            ),
                            SizedBox(
                              height: context.safePercentHeight * 2.5,
                            ),
                            Text(
                              OFFER_PRICE,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.m),
                                  ),
                            ).tr(),
                            SizedBox(
                              height: context.safePercentHeight * 0.7,
                            ),
                            Text(
                              "Only RS ${matrimonialPriceConfig["actualPrice"] ?? "99"}/-",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.l),
                                      fontWeight: FontWeight.bold,
                                      color: maroonColor),
                            )
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 5,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.safePercentWidth * 5),
                    child: Table(
                      border: TableBorder.all(
                          color: lightGreySubheading,
                          style: BorderStyle.solid,
                          width: 1.5,
                          borderRadius: BorderRadius.circular(5)),
                      columnWidths: {
                        0: FlexColumnWidth(15),
                        1: FlexColumnWidth(5)
                      },
                      children: [
                        TableRow(children: [
                          TableColumn(
                            displayWidget: Text(
                              'Price',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.m),
                                      fontWeight: FontWeight.w700,
                                      color: maroonColor),
                            ),
                          ),
                          TableColumn(
                            displayWidget: Text(
                              '${matrimonialPriceConfig["actualPrice"] ?? "99"}',
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.m),
                                      fontWeight: FontWeight.w700,
                                      color: maroonColor),
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableColumn(
                            displayWidget: Text(
                              LIST_OF_MATCHES,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ).tr(),
                          ),
                          TableColumn(
                            displayWidget: Icon(
                              Icons.check,
                              size: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m),
                              color: maroonColor,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableColumn(
                            displayWidget: Text(
                              PHONE_NUMBER,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                    fontSize: responsiveFontSize(context,
                                        size: ResponsiveFontSizes.s),
                                  ),
                            ).tr(),
                          ),
                          TableColumn(
                            displayWidget: Icon(
                              Icons.check,
                              size: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m),
                              color: maroonColor,
                            ),
                          ),
                        ]),
                        TableRow(children: [
                          TableColumn(
                            displayWidget: Text(
                              VIEW_MULTIPLE_IMAGES,
                              style: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(
                                      fontSize: responsiveFontSize(context,
                                          size: ResponsiveFontSizes.s),
                                      fontWeight: FontWeight.w400),
                            ).tr(),
                          ),
                          TableColumn(
                            displayWidget: Icon(
                              Icons.check,
                              size: responsiveFontSize(context,
                                  size: ResponsiveFontSizes.m),
                              color: maroonColor,
                            ),
                          ),
                        ]),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: context.safePercentHeight * 5,
                  ),
                ],
              ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: SizedBox(
        width: context.safePercentWidth * 55,
        child: FloatingActionButton(
          backgroundColor: maroonColor,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30.0)),
          elevation: 5.0,
          child: Padding(
            padding: EdgeInsets.symmetric(
                vertical: context.safePercentHeight * 0.3,
                horizontal: context.safePercentWidth * 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  DO_PAYMENT,
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m),
                      color: Colors.white,
                      fontWeight: FontWeight.w600),
                ).tr(),
                SizedBox(width: context.safePercentWidth * 1.5),
                // Icon(
                //   Icons.app_registration_rounded,
                //   color: maroonColor,
                //   size:
                //       responsiveFontSize(context, size: ResponsiveFontSizes.m),
                // ),
              ],
            ),
          ),
          onPressed: onProcessPayment,
        ),
      ),
    );
  }
}

class TableColumn extends StatelessWidget {
  const TableColumn({Key key, @required this.displayWidget}) : super(key: key);

  final Widget displayWidget;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          left: context.safePercentWidth * 5,
          top: context.safePercentHeight * 0.4,
          bottom: context.safePercentHeight * 0.4,
          right: context.safePercentWidth * 0.5),
      child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.safePercentHeight * 0.7),
                child: displayWidget)
          ]),
    );
  }
}
