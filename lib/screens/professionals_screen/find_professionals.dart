// ignore_for_file: prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_const_literals_to_create_immutables, deprecated_member_use

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share_me/flutter_share_me.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/Location.dart';
import 'package:online_panchayat_flutter/models/User.dart';
import 'package:online_panchayat_flutter/screens/main_screen/additional_tehsil_button.dart';
import 'package:online_panchayat_flutter/screens/main_screen/drawer.dart';
import 'package:online_panchayat_flutter/screens/main_screen/mainScreenAppBar.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/find_professionals_data.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/crousel.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/image_section.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/repair_section.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/services_constant.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/service_avatar_list.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class FindProfessionals extends StatefulWidget {
  const FindProfessionals({Key key}) : super(key: key);

  @override
  _FindProfessionalsState createState() => _FindProfessionalsState();
}

class _FindProfessionalsState extends State<FindProfessionals>
    with
        SingleTickerProviderStateMixin,
        AutomaticKeepAliveClientMixin<FindProfessionals> {
  /// Required override for wantKeepAlive
  @override
  bool get wantKeepAlive => true;

  /// Keep state of this class
  /// class variables
  AnimationController _animationController;
  Animation<double> _animation;
  ScrollController _listScrollController;
  GlobalDataNotifier _globalDataNotifier;
  User _currentUser;
  FindProfessionalsData _findProfessionalsData;
  bool _scrollToBottomEventLogged = false;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.80,
      upperBound: 1.0,
      value: 1.0,
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack);

    /// List scroll controller
    /// sending a firebase event when scroll reaches to bottom
    _listScrollController = ScrollController();
    _listScrollController.addListener(_scrollListener);

    _findProfessionalsData =
        Provider.of<FindProfessionalsData>(context, listen: false);

    /// If there is no call to get the professional then we call here
    if (_findProfessionalsData.isRegisteredAsProfessional == null)
      _findProfessionalsData.getProfessional();

    /// Using global data notifier for getting currentUser information
    _globalDataNotifier =
        Provider.of<GlobalDataNotifier>(context, listen: false);
    _currentUser = _globalDataNotifier.localUser;

    /// check if current logged in user is a professional
    // _professional = getProfessionalDetails();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _animationController.dispose();
    _listScrollController.dispose();
  }

  void _onClickServiceAvatar(service) {
    // Firebase analytics
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "sp_service_avatar", parameters: {
      "user_id": _currentUser.id ?? "",
      "service_name": service["name"],
      "service_id": service["id"] ?? "",
    });

    if (service["subServices"] == null) {
      context.vxNav.push(Uri.parse(MyRoutes.professionalList), params: service);
      return;
    }

    context.vxNav.push(Uri.parse(MyRoutes.seeAllServices),
        params: service["subServices"]);
  }

  void _registerAsProfessional() {
    performWriteOperationAfterConditionsCheck(
      registrationInstructionText:
          REGISTRATION_MESSAGE_BEFORE_REGISTERING_AS_PROFESSIONAL,
      writeOperation: () {
        /// If we have professional registred then we send him to his
        /// profile page
        if (_findProfessionalsData.currentProfessional != null) {
          context.vxNav.push(Uri.parse(MyRoutes.seeProfessionalProfile),
              params: [_findProfessionalsData.currentProfessional, Location()]);
        } else {
          // Send to register screen

          // Firebase analytics
          AnalyticsService.firebaseAnalytics
              .logEvent(name: "sp_register_professional", parameters: {
            "user_id": _currentUser.id ?? "",
          });
          context.vxNav.push(Uri.parse(MyRoutes.registerProfessionalForm));
        }
      },
      context: context,
    );
  }

  void _serviceButtonOnClick() {
    // Firebase analytics
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "sp_services_button", parameters: {
      "user_id": _currentUser.id ?? "",
    });

    // Send to all services screen
    context.vxNav.push(Uri.parse(MyRoutes.seeAllServices), params: serviceList);
  }

  /// Scroll listener used to track if user has reached at the end of page
  void _scrollListener() {
    if (_listScrollController.position.maxScrollExtent -
                _listScrollController.position.pixels <=
            40.0 &&
        !_scrollToBottomEventLogged) {
      _scrollToBottomEventLogged = true;
      // Firebase analytics of how much pepole scroll to bottom
      AnalyticsService.firebaseAnalytics
          .logEvent(name: "sp_scroll_to_bottom", parameters: {
        "user_id": _currentUser.id ?? "",
      });
    }
  }

  /// Methods used for showing animation on clicking the Invite friends image
  void _tapDown(PointerDownEvent _) {
    _animationController.reverse();
  }

  void _tapUp(PointerUpEvent _) {
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return Scaffold(
      drawer: MyCustomDrawer(),
      appBar: AppBar(
        toolbarHeight: 40,
        centerTitle: true,
        elevation: 0.0,
        automaticallyImplyLeading: false,
        leading: Builder(builder: (context) {
          return InkWell(
            child: SizedBox(
              height: context.safePercentHeight * 2.8,
              child: Icon(
                Icons.menu,
                color: maroonColor,
              ),
            ),
            onTap: () {
              Scaffold.of(context).openDrawer();
            },
            onLongPress: () async {
              context.vxNav.push(Uri.parse(MyRoutes.developerScreen));
            },
          );
        }),
        actions: [
          AdditionalTehsilButton(),
        ],
        title: MainScreenAppBarTitle(),
      ),
      body: ListView(
        controller: _listScrollController,
        children: [
          /// Top Section
          /// Search bar, All Services button and profile or register button
          Card(
            color: Theme.of(context).cardColor,
            elevation: 1.0,
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: context.safePercentWidth * 3,
                  vertical: context.safePercentHeight * 1.3),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Expanded(
                        child: TextFormField(
                          decoration: InputDecoration(
                              prefixIcon: Icon(
                                FontAwesomeIcons.search,
                                size: 18.0,
                                color: maroonColor,
                              ),
                              suffixIcon: Icon(
                                FontAwesomeIcons.microphone,
                                size: 18.0,
                                color: maroonColor,
                              ),
                              hintText: SEARCH_FOR_SERVICE_HINT,
                              hintStyle: Theme.of(context)
                                  .textTheme
                                  .headline1
                                  .copyWith(fontSize: 16.0),
                              isDense: true,
                              contentPadding: EdgeInsets.all(0),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: maroonColor)),
                              border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10.0),
                                  borderSide: BorderSide(color: Colors.grey)),
                              prefixIconConstraints:
                                  BoxConstraints(minWidth: 35, maxWidth: 50)),
                        ),
                      ),
                      SizedBox(width: context.safePercentWidth * 1),
                      TextButton(
                          onPressed: _serviceButtonOnClick,
                          child: Text(SERVICES).tr()),
                      SizedBox(width: context.safePercentWidth * 1),
                      Consumer<FindProfessionalsData>(
                          builder: (context, value, child) {
                        if (value.isRegisteredAsProfessional == null) {
                          ///
                          return Center(
                            child: SpinKitPulse(
                              size: context.safePercentWidth * 12,
                              color: maroonColor,
                            ),
                          );
                        } else if (!value.isRegisteredAsProfessional)
                          return TextButton(
                            onPressed: _registerAsProfessional,
                            child: Text(
                              Register_Heading,
                              style: Theme.of(context).textTheme.bodyText1,
                            ).tr(),
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        maroonColor)),
                          );
                        else
                          return InkWell(
                            onTap: () {
                              context.vxNav.push(
                                  Uri.parse(MyRoutes.seeProfessionalProfile),
                                  params: [
                                    _findProfessionalsData.currentProfessional,
                                    Location()
                                  ]);
                            },
                            child: Center(
                              child: CircleAvatar(
                                maxRadius: context.safePercentWidth * 6,
                                backgroundColor: lightGreySubheading,
                                backgroundImage: Image.network(
                                        _currentUser.image ?? APP_ICON_URL,
                                        fit: BoxFit.fill)
                                    .image,
                              ),
                            ),
                          );
                      }),
                    ],
                  ),
                ],
              ),
            ),
          ),
          SizedBox(height: context.safePercentHeight * 0.5),

          /// Image Crousel
          ImageCrousel(
            registerAsProfessional: _registerAsProfessional,
            userId: _currentUser.id ?? "",
          ),

          SizedBox(height: context.safePercentHeight * 0.9),

          ///Personal Services
          ServiceAvatarList(
            sectionLabel: PERSONAL_SERVICES.tr(),
            serviceList: serviceList[4]["subServices"],
            onClickServiceAvatar: _onClickServiceAvatar,
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Home services
          ServiceAvatarList(
            serviceList: serviceList,
            onClickServiceAvatar: _onClickServiceAvatar,
            sectionLabel: HOME_SERVICES.tr(),
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          //Appliance Repair
          RepairSection(
            serviceList: serviceList[0]["subServices"],
            title: APPLIANCE_REPAIR.tr(),
            noOfElements: 4,
            buttonText: SEE_MORE_SERVICES_BUTTON.tr(),
            currentUserId: _currentUser.id,
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Home repair services
          RepairSection(
            serviceList: serviceList[1]["subServices"],
            title: HOME_REPAIR.tr(),
            noOfElements: 4,
            buttonText: SEE_MORE_SERVICES_BUTTON.tr(),
            currentUserId: _currentUser.id,
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Food Services
          RepairSection(
            serviceList: serviceList[2]["subServices"],
            title: FOOD_SERVICES.tr(),
            buttonText: SEE_MORE_SERVICES_BUTTON.tr(),
            currentUserId: _currentUser.id,
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Property services
          RepairSection(
            serviceList: serviceList[3]["subServices"],
            title: PROPERTY_SERVICES.tr(),
            buttonText: SEE_MORE_SERVICES_BUTTON.tr(),
            currentUserId: _currentUser.id,
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Sell property image section
          ImageSection(
            /// Hard coding value
            service: serviceList[3]["subServices"][0],

            currentUserId: _currentUser.id,
            image: sellPropertyImageLink,
            content: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: PROPERTY_SELL_LINE_1.tr(),
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m)),
                  children: [
                    TextSpan(
                      text: PROPERTY_SELL_LINE_2.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline2
                          .copyWith(color: maroonColor, fontSize: 20.0),
                    ),
                    TextSpan(
                      text: PROPERTY_SELL_LINE_3.tr(),
                      style: Theme.of(context).textTheme.headline2.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.m)),
                    ),
                  ]),
            ),
            buttonText: Text(
              PROPERTY_SELL_BUTTON_TEXT,
              style: Theme.of(context).textTheme.bodyText1,
            ).tr(),
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Dabbawala image section
          ImageSection(
            service: serviceList[2]["subServices"][0],
            currentUserId: _currentUser.id,
            image: dabbawalImageLink,
            content: RichText(
              textAlign: TextAlign.justify,
              text: TextSpan(
                  text: DABBAWALA_LINE_1.tr(),
                  style: Theme.of(context).textTheme.headline2.copyWith(
                      fontSize: responsiveFontSize(context,
                          size: ResponsiveFontSizes.m)),
                  children: [
                    TextSpan(
                      text: DABBAWALA_LINE_2.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .bodyText1
                          .copyWith(color: maroonColor, fontSize: 20.0),
                    ),
                    TextSpan(
                        text: DABBAWALA_LINE_3.tr(),
                        style: Theme.of(context).textTheme.headline2.copyWith(
                            fontSize: responsiveFontSize(context,
                                size: ResponsiveFontSizes.m))),
                  ]),
            ),
            buttonText: Text(
              SEARCH_FOR_DABBAWALA,
              style: Theme.of(context).textTheme.bodyText1,
            ).tr(),
          ),
          SizedBox(height: context.safePercentHeight * 0.9),

          /// Invite friends section
          InkWell(
            onTap: () {
              // Firebase analytics
              AnalyticsService.firebaseAnalytics
                  .logEvent(name: "sp_invite_friends", parameters: {
                "user_id": _currentUser.id ?? "",
              });
              FlutterShareMe().shareToWhatsApp(
                msg: referralSentence + "\n" + whatsappShareDynamicLink,
              );

              // context.vxNav.push(Uri.parse(MyRoutes.inviteFriends));
            },
            child: Card(
              color: Theme.of(context).cardColor,
              elevation: 0,
              child: Padding(
                padding: EdgeInsets.symmetric(
                    vertical: context.safePercentHeight * 1.3,
                    horizontal: context.safePercentWidth * 3),
                child: Listener(
                  onPointerDown: _tapDown,
                  onPointerUp: _tapUp,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: ScaleTransition(
                        scale: _animation,
                        alignment: Alignment.center,
                        child: CachedNetworkImage(
                          imageUrl: referImageLink,
                          progressIndicatorBuilder:
                              (context, url, downloadProgress) =>
                                  RectangularImageLoading(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      )),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
