// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:online_panchayat_flutter/screens/loading.dart';
import 'package:online_panchayat_flutter/screens/widgets/userTile.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:provider/provider.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class ViewCommunityMembers extends StatefulWidget {
  final String communityId;
  ViewCommunityMembers({this.communityId});
  @override
  _ViewCommunityMembersState createState() => _ViewCommunityMembersState();
}

class _ViewCommunityMembersState extends State<ViewCommunityMembers> {
  //Login click with contact number validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: getPageAppBar(
        context: context,
        text: COMMUNITY_MEMBERS,
      ),
      body: Responsive(
        mobile: ResponsiveViewCommunityMembers(
          communityId: widget.communityId,
        ),
        tablet: ResponsiveViewCommunityMembers(
          communityId: widget.communityId,
        ),
        desktop: ResponsiveViewCommunityMembers(
          communityId: widget.communityId,
        ),
      ),
    );
  }
}

class ResponsiveViewCommunityMembers extends StatefulWidget {
  final String communityId;
  ResponsiveViewCommunityMembers({this.communityId});

  @override
  _ResponsiveViewCommunityMembersState createState() =>
      _ResponsiveViewCommunityMembersState();
}

class _ResponsiveViewCommunityMembersState
    extends State<ResponsiveViewCommunityMembers> {
  GQLQueryService _gqlQueryService;

  @override
  void initState() {
    _gqlQueryService = Provider.of<GQLQueryService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<User>>(
      future: _gqlQueryService.getCasteCommunity
          .getListOfUsersInACommunity(communityId: widget.communityId),
      builder: (context, snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        else if (snapshot.data.length != 0)
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return UserTile(
                user: snapshot.data[index],
              );
            },
          );
        else
          return Center(
            child: Text(
              "No members in this community",
              style: Theme.of(context).textTheme.headline1.copyWith(
                    fontWeight: FontWeight.normal,
                    fontSize: responsiveFontSize(context,
                        size: ResponsiveFontSizes.s),
                  ),
            ),
          );
      },
    );
  }
}
