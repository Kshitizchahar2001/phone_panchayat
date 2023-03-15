// ignore_for_file: file_names, prefer_const_constructors, prefer_const_constructors, duplicate_ignore

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/DesignatedUsersFeed/sarpanchFeed.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:velocity_x/velocity_x.dart';

class DesignatedMembersByPanchayatSamitiScreen extends StatelessWidget {
  final String panchayatSamitiId;
  const DesignatedMembersByPanchayatSamitiScreen({
    Key key,
    @required this.panchayatSamitiId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
        text: VIEW_ELECTED_MEMBERS,
      ),
      body: SarpanchFeed(
        panchayatSamitiId: panchayatSamitiId,
      ),
      floatingActionButton: InkWell(
        onTap: () {
          context.vxNav.push(Uri.parse(MyRoutes.recommendRepresentativeScreen));
        },
        child: Container(
          width: 200,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(35),
            color: maroonColor,
          ),
          child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Icon(
                    Icons.add,
                    color: Colors.white,
                  ),
                  Flexible(
                    child: AutoSizeText(
                      RECOMMEND_A_REPRESENTATIVE.tr(),
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.white,
                        // fontSize: 10,
                      ),
                    ),
                  )
                ],
              )),
        ),
      ),
    );
  }
}
