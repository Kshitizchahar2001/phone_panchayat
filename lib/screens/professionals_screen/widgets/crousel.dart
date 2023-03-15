// ignore_for_file: prefer_const_constructors, duplicate_ignore, annotate_overrides

// ignore_for_file: prefer_const_constructors

import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/shimmerEffects/rectangular_image.dart';
import 'package:online_panchayat_flutter/services/analyticsService.dart';
import 'package:velocity_x/velocity_x.dart';
import '../services_constant.dart';

class ImageCrousel extends StatefulWidget {
  const ImageCrousel({
    Key key,
    @required this.registerAsProfessional,
    @required this.userId,
  }) : super(key: key);
  final Function registerAsProfessional;
  final String userId;

  @override
  State<ImageCrousel> createState() => _ImageCrouselState();
}

class _ImageCrouselState extends State<ImageCrousel>
    with TickerProviderStateMixin {
  /// Class members
  int _currentCrouselIndex = 0;
  final CarouselController _controller = CarouselController();
  AnimationController _animationController;
  Animation<double> _animation;

  @override
  void initState() {
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(milliseconds: 300),
      lowerBound: 0.80,
      upperBound: 1.0,
      value: 1.0,
    );
    _animation = CurvedAnimation(
        parent: _animationController, curve: Curves.easeInOutBack);

    super.initState();
  }

  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _tapDown(PointerDownEvent _) {
    // Firebase analytics
    AnalyticsService.firebaseAnalytics
        .logEvent(name: "sp_register_professional_image", parameters: {
      "user_id": widget.userId,
    });
    // Animation
    _animationController.reverse();
  }

  void _tapUp(PointerUpEvent _) {
    _animationController.forward();
  }

  List<Widget> get imageSliders {
    return crouselImages
        .map((item) => InkWell(
              onTap: widget.registerAsProfessional,
              child: Listener(
                onPointerDown: _tapDown,
                onPointerUp: _tapUp,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(5.0)),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        horizontal: context.safePercentWidth * 0),
                    child: ScaleTransition(
                      scale: _animation,
                      alignment: Alignment.center,
                      child: CachedNetworkImage(
                        imageUrl: item,
                        progressIndicatorBuilder:
                            (context, url, downloadProgress) =>
                                RectangularImageLoading(),
                        errorWidget: (context, url, error) =>
                            Icon(Icons.error),
                      ),
                    ),
                  ),
                ),
              ),
            ))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 0),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10.0)),
      child: Card(
        color: Theme.of(context).cardColor,
        elevation: 0,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            CarouselSlider(
              items: imageSliders,
              carouselController: _controller,
              options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: false,
                  aspectRatio: 16 / 9,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentCrouselIndex = index;
                    });
                  }),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: crouselImages.asMap().entries.map((entry) {
                return GestureDetector(
                  onTap: () => _controller.animateToPage(entry.key),
                  child: Container(
                    width: 8.0,
                    height: 8.0,
                    margin:
                        EdgeInsets.symmetric(vertical: 8.0, horizontal: 4.0),
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: (Theme.of(context).brightness == Brightness.dark
                                ? Colors.white
                                : Colors.black)
                            .withOpacity(
                                _currentCrouselIndex == entry.key ? 0.9 : 0.4)),
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}
