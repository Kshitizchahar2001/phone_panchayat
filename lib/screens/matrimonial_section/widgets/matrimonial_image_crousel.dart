// ignore_for_file: annotate_overrides, prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';

class MatrimonialImageCrousel extends StatefulWidget {
  const MatrimonialImageCrousel(
      {Key key, @required this.imageList, this.crouselHeight})
      : super(key: key);

  final List<String> imageList;
  final double crouselHeight;

  @override
  State<MatrimonialImageCrousel> createState() =>
      _MatrimonialImageCrouselState();
}

class _MatrimonialImageCrouselState extends State<MatrimonialImageCrousel> {
  int _currentCrouselIndex = 0;
  bool autoPlay = true;

  CarouselController _controller;

  void initState() {
    _controller = CarouselController();
    getAutoPlay();
    super.initState();
  }

  void dispose() {
    super.dispose();
  }

  List<Widget> get imageSliders {
    List<Widget> images = [];
    images.addAll(widget.imageList
        .map((item) => SizedBox(
              width: double.infinity,
              child: ClipRRect(
                borderRadius: BorderRadius.all(Radius.circular(15.0)),
                child: CachedNetworkImage(
                  fit: BoxFit.cover,
                  imageUrl: item,
                  progressIndicatorBuilder: (context, url, downloadProgress) =>
                      RectangularImageLoading(),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                ),
              ),
            ))
        .toList());

    return images;
  }

  void getAutoPlay() {
    if (widget.imageList.isNotEmpty && widget.imageList.length == 1) {
      setState(() {
        autoPlay = false;
      });
      return;
    }

    setState(() {
      autoPlay = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        CarouselSlider(
          items: imageSliders,
          carouselController: _controller,
          options: CarouselOptions(
              height: widget.crouselHeight,
              autoPlayInterval: Duration(seconds: 1),
              autoPlay: autoPlay,
              enlargeCenterPage: false,
              aspectRatio: 16 / 9,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  _currentCrouselIndex = index;
                  if (_currentCrouselIndex == widget.imageList.length - 1) {
                    autoPlay = false;
                  }
                });
              }),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: imageSliders.asMap().entries.map((entry) {
            return GestureDetector(
              onTap: () => _controller.animateToPage(entry.key),
              child: Container(
                width: 10.0,
                height: 10.0,
                margin: EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: (Theme.of(context).brightness == Brightness.dark
                            ? lightGreySubheading
                            : Colors.black)
                        .withOpacity(
                            _currentCrouselIndex == entry.key ? 0.9 : 0.4)),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }
}
