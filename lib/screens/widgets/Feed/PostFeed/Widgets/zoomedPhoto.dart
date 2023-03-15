// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/utils/getPageAppBar.dart';
import 'package:photo_view/photo_view.dart';

class PhotoZoomView extends StatefulWidget {
  final ImageProvider imageView;

  const PhotoZoomView({Key key, this.imageView}) : super(key: key);
  @override
  _PhotoZoomViewState createState() => _PhotoZoomViewState();
}

class _PhotoZoomViewState extends State<PhotoZoomView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getPageAppBar(
        context: context,
      ),
      body: SafeArea(
        child: PhotoView(
          backgroundDecoration: BoxDecoration(
            color: Theme.of(context).scaffoldBackgroundColor,
          ),
          imageProvider: widget.imageView,
        ),
      ),
    );
  }
}
