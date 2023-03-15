// ignore_for_file: use_key_in_widget_constructors, prefer_const_constructors_in_immutables, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/models/ModelProvider.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:online_panchayat_flutter/screens/loading.dart';
import 'package:online_panchayat_flutter/screens/widgets/userTile.dart';
import 'package:online_panchayat_flutter/services/gqlQueryService.dart';
import 'package:provider/provider.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';

class ViewReactions extends StatefulWidget {
  final String postId;
  ViewReactions({this.postId});
  @override
  _ViewReactionsState createState() => _ViewReactionsState();
}

class _ViewReactionsState extends State<ViewReactions> {
  //Login click with contact number validation
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.background,
      appBar: getPageAppBar(
        context: context,
        text: LIKES.plural(0),
      ),
      body: Responsive(
        mobile: ResponsiveViewReactions(
          postId: widget.postId,
        ),
        tablet: ResponsiveViewReactions(
          postId: widget.postId,
        ),
        desktop: ResponsiveViewReactions(
          postId: widget.postId,
        ),
      ),
    );
  }
}

class ResponsiveViewReactions extends StatefulWidget {
  final String postId;
  ResponsiveViewReactions({this.postId});

  @override
  _ResponsiveViewReactionsState createState() =>
      _ResponsiveViewReactionsState();
}

class _ResponsiveViewReactionsState extends State<ResponsiveViewReactions> {
  GQLQueryService _gqlQueryService;

  @override
  void initState() {
    _gqlQueryService = Provider.of<GQLQueryService>(context, listen: false);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reactions>>(
      future: _gqlQueryService.getReactionsbyPostId
          .getReactionsbyPostId(postId: widget.postId),
      builder: (context, snapshot) {
        if (snapshot.data == null ||
            snapshot.connectionState == ConnectionState.waiting)
          return Loading();
        else if (snapshot.data.length != 0)
          return ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              return UserTile(
                user: snapshot.data[index].user,
              );
            },
          );
        else
          return Center(
            child: Text(
              "No likes on this post yet",
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
