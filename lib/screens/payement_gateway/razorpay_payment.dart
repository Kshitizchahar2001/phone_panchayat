// ignore_for_file: prefer_const_constructors

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/payement_gateway/order_id.dart';
import 'package:online_panchayat_flutter/screens/payement_gateway/subscription.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/custom_snackbar.dart';
import 'package:online_panchayat_flutter/services/services.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

class RazorpayPayment {
  Razorpay _razorpay;

  RazorpayPayment(Function handlePaymentSuccess, Function handlePaymentError,
      Function handleExternalWallet) {
    _razorpay = Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, handleExternalWallet);
  }

  /// Get order id and process to open checkout
  void processOrderPayment(BuildContext context, int amount, String planName,
      {String description = "Phone Panchayat Service"}) async {
    var options = {
      "amount": amount,
      "currency": "INR",
    };

    String orderId = await RazorpayOrderId().getOrderId(options);

    if (orderId == null) {
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(context,
          CANNOT_PROCESS_PAYMENT, Icon(Icons.error, color: Colors.white)));
      return;
    }

    /// If we get orderId then we open razorpay page
    openCheckout(amount, orderId, planName, description: description);
  }

  /// Process Subscription Payments
  Future<String> processSubscriptionPayment(BuildContext context, int amount,
      String planId, String planName, int numberOfBillingCycles,
      {int expireTimestamp,
      String description = "Phone Panchayat Service"}) async {
    var subscriptionOptions = {
      "plan_id": razorpayAdditionalTehsilPlanId,
      "total_count": numberOfBillingCycles,
      "expire_by": expireTimestamp,
      "quantity": 1,
      "customer_notify": 1,
      "notes": {
        "customer_id": Services.globalDataNotifier.localUser.id ?? "",
        "planName": planName ?? "MULTIPLE_TEHSIL"
      }
    };

    String subscriptionId =
        await RazorpaySubscription().createSubscription(subscriptionOptions);

    if (subscriptionId == null) {
      ScaffoldMessenger.of(context).showSnackBar(showResultSnackBar(context,
          CANNOT_PROCESS_PAYMENT, Icon(Icons.error, color: Colors.white)));
      return null;
    }

    /// If we get orderId then we open razorpay page
    openCheckout(amount, subscriptionId, planName,
        description: description, isSubscription: true);

    return subscriptionId;
  }

////
  void openCheckout(int amount, String paymentId, String planName,
      {String description, bool isSubscription = false}) async {
    var options = {
      'key': razorpayApiKey,
      'amount': amount,
      'currency': "INR",
      'name': 'Phone Panchayat',
      'description': description,
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      'prefill': {
        'contact': Services.globalDataNotifier.localUser.id,
        'subscriptionPlan': planName
      },
      'method': {'wallet': false},
      'notes': {
        'user_id': Services.globalDataNotifier.localUser.id ?? "",
        'user_area': Services.globalDataNotifier.localUser.area ?? "",
      }
    };

    if (isSubscription) {
      options.addEntries({'subscription_id': paymentId}.entries);
    } else {
      options.addEntries({'order_id': paymentId}.entries);
    }

    try {
      _razorpay.open(options);
    } catch (e, s) {
      FirebaseCrashlytics.instance.recordError(e, s);
    }
  }

  void clearRazorpay() {
    _razorpay.clear();
  }
}
