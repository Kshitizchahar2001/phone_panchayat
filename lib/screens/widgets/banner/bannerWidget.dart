// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/banner/bannerViewModel.dart';

import 'Data/banner_post_data.dart';

class BannerWidget extends StatefulWidget {
  final BannerPostData bannerPostData;
  const BannerWidget({Key key, @required this.bannerPostData})
      : super(key: key);

  @override
  State<BannerWidget> createState() => _BannerWidgetState();
}

class _BannerWidgetState extends State<BannerWidget> {
  BannerViewModel _bannerViewModel;
  @override
  void initState() {
    _bannerViewModel = BannerViewModel(widget.bannerPostData);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (_bannerViewModel.showBanner) {
      return Column(
        children: [
          InkWell(
            onTap: () {
              _bannerViewModel.onClick(context);
            },
            child: Image.network(_bannerViewModel.postData.getFirstImage()),
          ),
          Divider(
            thickness: 1.0,
          ),
        ],
      );
    } else
      return Container();
  }
}
