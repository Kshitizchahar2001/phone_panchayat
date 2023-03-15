// ignore_for_file: prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';

import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/screens/main_screen/additional_tehsil_button.dart';
import 'package:online_panchayat_flutter/screens/main_screen/drawer.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/call_list.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/incoming_request_list.dart';

import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/matches_list.dart';
import 'package:online_panchayat_flutter/screens/matrimonial_section/tabs/sent_request_list.dart';
import 'package:velocity_x/velocity_x.dart';

class MatrimonialList extends StatefulWidget {
  final PageController mainScreenPageController;
  const MatrimonialList({Key key, this.mainScreenPageController})
      : super(key: key);

  @override
  _MatrimonialListState createState() => _MatrimonialListState();
}

class _MatrimonialListState extends State<MatrimonialList>
    with SingleTickerProviderStateMixin, AutomaticKeepAliveClientMixin {
  TabController tabController;
  List<Widget> tabs = <Widget>[];
  List<Widget> additionalTabs = <Widget>[];
  List<Widget> tabBarViewChildren = <Widget>[];
  TextStyle labelTextStyle;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    initialiseTabController();

    super.initState();
  }

  void initialiseTabController() {
    tabController = TabController(
      length: 4,
      vsync: this,
      initialIndex: 0,
    );
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    initialiseTabs();

    return WillPopScope(
      onWillPop: () async {
        return true;
      },
      child: Scaffold(
        drawer: MyCustomDrawer(),
        backgroundColor: Theme.of(context).cardColor,
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
          bottom: TabBar(
            isScrollable: true,
            controller: tabController,
            labelColor: Colors.black,
            labelStyle: labelTextStyle,
            unselectedLabelStyle: TextStyle(
              color: Theme.of(context).textTheme.headline1.color,
            ),
            tabs: tabs,
          ),
          actions: [
            AdditionalTehsilButton(),
          ],
          title: Text(
            MATCH_LIST,
            style: TextStyle(
              fontSize: 15,
              color: maroonColor,
            ),
          ).tr(),
        ),
        body: TabBarView(
          controller: tabController,
          children: tabBarViewChildren,
        ),
      ),
    );
  }

  void initialiseTabs() {
    labelTextStyle = Theme.of(context).textTheme.headline4.copyWith(
          fontSize: 13,
          fontWeight: FontWeight.bold,
        );

    tabs = <Widget>[
      Tab(
        icon: Text(
          MATCH_LIST.tr(),
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      Tab(
        icon: Text(
          REQUEST_LIST.tr(),
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      Tab(
        icon: Text(
          SENT_REQUEST.tr(),
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
      Tab(
        icon: Text(
          CALL_LIST.tr(),
          style: labelTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    ];

    tabBarViewChildren = <Widget>[];

    tabBarViewChildren.add(MatchesList());

    tabBarViewChildren.add(IncomingRequestList());

    tabBarViewChildren.add(SentRequestList());

    tabBarViewChildren.add(CallList());
  }
}
