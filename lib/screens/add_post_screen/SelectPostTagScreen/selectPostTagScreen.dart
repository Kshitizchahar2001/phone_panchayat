// ignore_for_file: file_names, duplicate_ignore, deprecated_member_use, prefer_const_constructors, curly_braces_in_flow_control_structures, prefer_is_empty

// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/Main/routes.dart';
import 'package:online_panchayat_flutter/constants/images.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/firestoreModels/postTag.dart';
import 'package:online_panchayat_flutter/screens/add_post_screen/SelectPostTagScreen/selectPostTagData.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';

class SelectPostTag extends StatefulWidget {
  const SelectPostTag({Key key}) : super(key: key);

  @override
  _SelectPostTagState createState() => _SelectPostTagState();
}

class _SelectPostTagState extends State<SelectPostTag> {
  SelectPostTagData selectPostTagData;
  bool isUserLocaleHindi = false;
  @override
  void initState() {
    selectPostTagData = SelectPostTagData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    isUserLocaleHindi = UtilityService.getCurrentLocale(context) == "hi";
    return Scaffold(
      backgroundColor: Theme.of(context).cardColor,
      appBar: getPageAppBar(
        context: context,
        text: START_PANCHAYAT,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ResponsiveHeight(
            heightRatio: 2,
          ),
          Padding(
            padding: getPostWidgetSymmetricPadding(context),
            child: Text(
              CHOOSE_TAG,
              style: Theme.of(context).textTheme.headline3.copyWith(
                  fontSize:
                      responsiveFontSize(context, size: ResponsiveFontSizes.s)),
            ).tr(),
          ),
          ResponsiveHeight(
            heightRatio: 2,
          ),
          Expanded(
            child: FutureBuilder<List<PostTag>>(
              future: selectPostTagData.getPostTags(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting)
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                else if (!snapshot.hasData) {
                  return Center(
                    child: Text(
                      "Error getting tags. Please check your internet connection and try again!",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.headline1.copyWith(
                          fontSize: responsiveFontSize(context,
                              size: ResponsiveFontSizes.s)),
                    ),
                  );
                } else if (snapshot.data.length == 0) {
                  return Center(
                      child: Text(
                    "Error getting tags, please retry",
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ));
                } else
                  return GridView.builder(
                    padding:
                        getPostWidgetSymmetricPadding(context, vertical: 1),
                    physics: BouncingScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3,
                      crossAxisSpacing: 6.0,
                      mainAxisSpacing: 6.0,
                    ),
                    itemBuilder: itemBuilder,
                    itemCount: selectPostTagData.getAvailablePostTags.length,
                  );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget itemBuilder(BuildContext context, int index) {
    PostTag postTag = SelectPostTagData.availablePostTags[index];
    return InkWell(
      onTap: () => onTap(postTag),
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(
            color: Theme.of(context).shadowColor,
            width: 0.6,
          ),
          borderRadius: BorderRadius.circular(5),
        ),
        child: Padding(
          padding: getPostWidgetSymmetricPadding(context),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Flexible(
                    flex: 1,
                    child: Container(
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            image: postTag.imageUrl != null
                                ? NetworkImage(postTag.imageUrl)
                                : AssetImage(newspaper),
                          )),
                    )),
                SizedBox(
                  height: 10,
                ),
                Flexible(
                  flex: 1,
                  child: Text(
                    getPostTagTitle(postTag),
                    style: Theme.of(context).textTheme.headline1.copyWith(
                        fontSize: responsiveFontSize(context,
                            size: ResponsiveFontSizes.s)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String getPostTagTitle(PostTag postTag) {
    if (postTag.hi != null && postTag.hi != "" && isUserLocaleHindi)
      return postTag.hi.toString();
    else
      return postTag.en.toString();
  }

  onTap(PostTag postTag) {
    context.vxNav.push(Uri.parse(MyRoutes.createPostRoute), params: {
      'postTag': postTag,
    });
  }
}
