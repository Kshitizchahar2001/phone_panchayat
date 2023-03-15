
// ignore_for_file: file_names, duplicate_ignore, prefer_const_constructors, deprecated_member_use, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/claimTab.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referAndEarnData.dart';
import 'package:online_panchayat_flutter/screens/referAndEarnScreen/referTab.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';
import 'package:easy_localization/easy_localization.dart';

class ReferAndEarnScreen extends StatefulWidget {
  const ReferAndEarnScreen({Key key}) : super(key: key);

  @override
  _ReferAndEarnScreenState createState() => _ReferAndEarnScreenState();
}

class _ReferAndEarnScreenState extends State<ReferAndEarnScreen> {
  ReferAndEarnData referAndEarnData;

  @override
  void initState() {
    referAndEarnData = ReferAndEarnData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: REFER_AND_EARN,
        elevation: 0,
      ),
      body: DefaultTabController(
        length: 2,
        child: Scaffold(
          backgroundColor: Theme.of(context).cardColor,
          appBar: AppBar(
            // backgroundColor: maroonColor,
            bottom: TabBar(
              labelColor: Colors.black,
              labelStyle: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              unselectedLabelStyle: TextStyle(
                color: Theme.of(context).textTheme.headline1.color,
              ),
              tabs: [
                Tab(
                  icon: Text(
                    REFER.tr(),
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1.color),
                  ),
                ),
                // Tab(
                //   icon: Text(
                //     MY_REFERRALS.tr(),
                //   ),
                // ),
                Tab(
                  icon: Text(
                    CLAIM.tr(),
                    style: TextStyle(
                        color: Theme.of(context).textTheme.headline1.color),
                  ),
                ),
              ],
            ),
            title: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                RichText(
                  text: TextSpan(children: [
                    TextSpan(
                      text: TOTAL_REWARDS.tr(),
                      style: Theme.of(context)
                          .textTheme
                          .headline1
                          .copyWith(fontSize: 14),
                    ),
                    TextSpan(
                      text: "\n₹ ${referAndEarnData.total}",
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ]),
                ),
                MyTooltip(
                  message: ON_HOLD_POINTS_MESSAGE.tr(),

                  // waitDuration: Duration(seconds: 0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "₹ ${referAndEarnData.onHold}",
                        style: Theme.of(context)
                            .textTheme
                            .headline1
                            .copyWith(fontSize: 14),
                      ),
                      Row(
                        children: [
                          Text(
                            ON_HOLD.tr(),
                            style: Theme.of(context)
                                .textTheme
                                .headline1
                                .copyWith(fontSize: 8),
                          ),
                          SizedBox(
                            width: 2,
                          ),
                          Icon(
                            Icons.info,
                            color: Colors.green,
                            size: 14,
                          ),
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
            actions: [],
            automaticallyImplyLeading: false,
            // leading: ,
          ),
          body: TabBarView(
            children: [
              ReferTab(
                referAndEarnData: referAndEarnData,
              ),
              // MyReferralsTab(
              //   referAndEarnData: referAndEarnData,
              // ),
              ClaimTab(
                referAndEarnData: referAndEarnData,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class MyTooltip extends StatelessWidget {
  final Widget child;
  final String message;

  MyTooltip({@required this.message, @required this.child});

  @override
  Widget build(BuildContext context) {
    final key = GlobalKey<State<Tooltip>>();
    return Tooltip(
      key: key,
      message: message,
      child: GestureDetector(
        // behavior: HitTestBehavior.opaque,
        onTap: () => _onTap(key),
        child: child,
      ),
    );
  }

  void _onTap(GlobalKey key) async {
    final dynamic tooltip = key.currentState;
    tooltip?.deactivate();
    tooltip?.ensureTooltipVisible();
    await Future.delayed(Duration(milliseconds: 2500));
    tooltip?.deactivate();
  }
}
