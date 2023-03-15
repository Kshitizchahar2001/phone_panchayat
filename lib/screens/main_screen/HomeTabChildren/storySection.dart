// ignore_for_file: file_names, prefer_is_empty, curly_braces_in_flow_control_structures, prefer_const_constructors, deprecated_member_use

import 'package:firebase_crashlytics/firebase_crashlytics.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/models/LiveNews.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:velocity_x/velocity_x.dart';

class StorySection extends StatelessWidget {
  final List<LiveNews> list;
  const StorySection({
    Key key,
    @required this.list,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (list.length == 0)
      return Container();
    else
      return Padding(
        padding: const EdgeInsets.only(bottom: 4.0),
        child: Container(
          color: Theme.of(context).cardColor,
          height: 90,
          child: ListView.builder(
            itemCount: list.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, index) {
              LiveNews liveNews = list[index];
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: InkWell(
                  onTap: () {
                    if (liveNews.postId == null || liveNews.postId == "") {
                      FirebaseCrashlytics.instance
                          .recordError("Post id in a liveNews was null", null);
                    } else
                      context.vxNav.push(
                        Uri.parse(
                          MyRoutes.singlePostViewMainScreenRoute,
                        ),
                        params: liveNews.postId,
                      );
                  },
                  child: SizedBox(
                    width: 70,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 2,
                          child: CircleAvatar(
                            backgroundColor: Theme.of(context).cardColor,
                            // radius: 15,
                            backgroundImage: liveNews.imageUrl != null
                                ? NetworkImage(liveNews.imageUrl)
                                : AssetImage(app_icon),
                          ),
                        ),
                        SizedBox(
                          height: 4,
                        ),
                        Flexible(
                          flex: 1,
                          child: Text(
                            liveNews.name.toString(),
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                            textAlign: TextAlign.center,
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                        fontSize: responsiveFontSize(
                                      context,
                                      size: ResponsiveFontSizes.xs,
                                    )),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
      );
  }
}
