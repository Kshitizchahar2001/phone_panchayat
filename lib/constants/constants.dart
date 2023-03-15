// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/firestoreModels/point.dart';
import 'package:online_panchayat_flutter/models/Location.dart';

import '../firestoreModels/Panchayat.dart';

const PROFILE_PIC_STORAGE_BUCKET_NAME = "userProfilePic";
const MATRIMONAIL_IMAGES_BUCKET_NAME = "matrimonialImages";
const DEFAULT_USER_IMAGE_URL =
    "https://firebasestorage.googleapis.com/v0/b/phone-p-312802.appspot.com/o/app_icon.png?alt=media&token=bde27607-3527-4490-a2f5-35dd9c0c4379";
const WORK_IMAGES_STORAGE_BUCKET_NAME = "ProfessionalWorkImages";
const POST_IMAGE_STORAGE_BUCKET_NAME = "postImageUploads";
const POST_VIDEO_STORAGE_BUCKET_NAME = "postVideoUploads";
const AADHAAR_IMAGE_STORAGE_BUCKET_NAME = "aadhaarImageUploads";
const Color KThemeDarkGrey = Color(0xff000000);
const NOTIFICATION_EVENT_TYPE_COMMENT = 'COMMENT';
const NOTIFICATION_EVENT_TYPE_REACTION = 'REACTION';
// const Color KThemeDarkGrey = Color(0xff182036);
const Color KThemeLightGrey = Color(0xFF707070);
const Color cardBackgroundDark = Color(0xFF272727);
const Color lightGreySubheading = Color(0xff959595);
const Color lightBlueBrightColor = Color(0xff2F89FC);
const Color maroonColor = Color(0xffD80047);
const Color yellowColor = Color(0xffEFD345);
const Color finnColor = Color(0xff634252);
const Color lightPink = Color(0xffEF99B5);
// Color maroonColor = Color(0xff223BB7);

// Color maroonColor = Color(0xff940922);
const Color textFieldFillColor = Color(0xffF8F8F8);
Color textFieldShadowColor = Colors.grey[400];
//// Old google map api key
//const String kGoogleApiKey = "AIzaSyBhQtUAAaMyp63hKPrOnGbKdnCxol97ZL0";

/// New google map api key
const String kGoogleApiKey = "AIzaSyB-69_dtDIv6Hk2IaYaTXKqRR2zueOmXWk";

/// Razorpay API Key
const String razorpayApiKey = "rzp_live_BH1ej6Owlhxs2u";
const String razorpayApiSecret = "VyOpipwvJgwnWecORrXaPhIv";
const String razorpayOrdersApiEndpoint = "https://api.razorpay.com/v1/orders";

///Test Enviornment
// const String razorpayAdditionalTehsilTestPlan = "plan_KBmtmKwVKZrbv8";

// const String razorpayTestApiKey = "rzp_test_MscR4oclZz3rSS";
// const String razorpayTestApiSecret = "JIwsGP7tXOJrHakbuFP559Ep";

/// Subscription Based Endpoints
const String razorpayAdditionalTehsilPlanId = "plan_K9qWZqjJr46UN2";
const int additionalTehsilPaymentCycleCount = 12;
const String razorpayCreateSubscription =
    "https://api.razorpay.com/v1/subscriptions";

const String cancelSubscription1 = "https://api.razorpay.com/v1/subscriptions/";
const String cancelSubcription2 = "/cancel";
// const String kGoogleApiKey = "AIzaSyDJhmQWIYJuuzh9UKOA4oR7xGR_EpNF05M";
// const String kGoogleApiKey = "AIzaSyBlyhD0vrhYc7DmiIEGqI6zh5o1F-oNZtQ";

const TextStyle drawerTextStyle =
    TextStyle(fontWeight: FontWeight.normal, color: Colors.white);

const TextStyle postContentTextStyle = TextStyle(
  fontWeight: FontWeight.w600,
);

const AdminTagForPostsAtTheEnd = "-1";
const AdminTagForPostsAtTheBeginning = "-100";
// posts created in admin pincode will be visible to all users irrespective of their pincode.
// these posts will be listed after all the user created posts are listed.

//appa host Url
const APP_HOST_URL = "https://phonepanchayat.com";
const DYNAMIC_LINKS_URL_PREFIX = "https://phonepanchayat.com/post";
const DYNAMIC_LINKS_REFERRAL_URL_PREFIX = "https://phonepanchayat.com/refer";

//app icon url
const APP_ICON_URL =
    'https://phonepanchayat.com/icons/android-chrome-192x192.png';

const String lastNextTokenEqualToNull = 'THE_END';

const Gangapur_pincode = "322201";

const List<Offset> shadows = [
  Offset(0.0, 2.0),
  // Offset(0.0, -2.0),
  Offset(2.0, 0.0),
  Offset(-2.0, 0.0),
];

Location temporarilyHardcodedlocation = Location(
  lat: 26.9124,
  lon: 75.7873,
);

Panchayat temporarilyHardcodedPanchayat = Panchayat(
  imageURL: DEFAULT_USER_IMAGE_URL,
  panchayatName: "जयपुर",
  pincode: "322201",
  point: Point(
    location: temporarilyHardcodedlocation,
    geoHash: 'tsttdft9j',
  ),
);

const String notificationIcon = "ic_launcher";
const String NO_ITEM_SELECTED = "no_item_selected";

const String districtColllection = "All_Districts";
const String ruralColllection = "rural";
const String urbanCollection = "urban";
const String gramPanchayatCollection = "GramPanchayat";
const String tehsilCollection = "tehsil";

const String referralSentence =
    "अपने क्षेत्र की अपनी ऐप्प | अपने आस पास की  गतिविधियॉ, घटनाए एवं अपडेट तुरंत हम तक पंहुचा देती है | अपने क्षेत्र के मुद्दों को उठाने के लिए आप भी मेरी तरह फ़ोन पंचायत के सदस्य बनिये और डाउनलोड कीजिये फ़ोन पंचायत ऍप | ";
const String appDownloadLink =
    'https://play.google.com/store/apps/details?id=com.panchayat.online';
const String whatsappShareDynamicLink =
    'https://phonepanchayat.com/refer/whatsapp';

const invitedByQueryPrameter = "invitedBy";

const int multipleTehsilAmount = 10;
const int matrimonialAmount = 99;
const BANNER = "banner";
