// ignore_for_file: file_names, prefer_const_constructors, curly_braces_in_flow_control_structures

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/enum/videoUrlType.dart';
import 'package:online_panchayat_flutter/screens/widgets/Feed/PostFeed/PostData/PostData.dart';
import 'package:online_panchayat_flutter/screens/widgets/facebookVideoPlayer.dart';
import 'package:online_panchayat_flutter/utils/humanizeNumber.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class MediaWidget extends StatefulWidget {
  final PostData postData;
  const MediaWidget({Key key, @required this.postData}) : super(key: key);

  @override
  State<MediaWidget> createState() => _MediaWidgetState();
}

class _MediaWidgetState extends State<MediaWidget> {
  int _currentCrouselIndex = 0;
  CarouselController _controller;
  @override
  void initState() {
    _controller = CarouselController();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _getFirstImage(PostData postData, BuildContext context) {
    if (postData.videoUrlsTypeMap[postData.videoURL] == VideoUrlType.Facebook) {
      return FacebookVideoPlayer(src: postData.videoURL);
    } else {
      return Center(
        child: GestureDetector(
          onTap: () {
            postData.postMedia.mediaClicked(context);
          },
          child: PostImage(
            url: postData.imageList[0],
            numberOfViews: postData.noOfViews,
            showPlayIcon: postData.postMedia.showPlayIcon,
          ),
        ),
      );
    }
  }

  List<Widget> _getImages() {
    List<Widget> images = <Widget>[];
    images.add(_getFirstImage(widget.postData, context));
    for (int i = 1; i < widget.postData.imageList.length; i++) {
      images.add(PostImage(
        url: widget.postData.imageList[i],
        numberOfViews: widget.postData.noOfViews,
        showPlayIcon: false,
      ));
    }
    return images;
  }

  @override
  Widget build(BuildContext context) {
    if ((widget.postData.imageList?.length ?? -1) > 0) {
      List<Widget> images = _getImages();
      return Column(
        children: [
          CarouselSlider(
            items: images,
            carouselController: _controller,
            options: CarouselOptions(
                enlargeCenterPage: false,
                enableInfiniteScroll: false,
                aspectRatio: 16 / 12,
                viewportFraction: 1,
                onPageChanged: (index, reason) {
                  setState(() {
                    _currentCrouselIndex = index;
                  });
                }),
          ),
          images.length > 1
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: images.asMap().entries.map((entry) {
                    return GestureDetector(
                      onTap: () => _controller.animateToPage(entry.key),
                      child: Container(
                        width: 8.0,
                        height: 8.0,
                        margin: EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 4.0),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: (Theme.of(context).brightness ==
                                        Brightness.dark
                                    ? Colors.white
                                    : Colors.black)
                                .withOpacity(_currentCrouselIndex == entry.key
                                    ? 0.9
                                    : 0.4)),
                      ),
                    );
                  }).toList(),
                )
              : const SizedBox(),
        ],
      );
    } else
      return const SizedBox();
  }
}

class PostImage extends StatefulWidget {
  const PostImage({
    Key key,
    @required this.url,
    @required this.numberOfViews,
    @required this.showPlayIcon,
  }) : super(key: key);

  final String url;
  final int numberOfViews;
  final bool showPlayIcon;

  @override
  State<PostImage> createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  bool loading;
  bool loadingComplete;
  double radius = 8.0;
  double aspectRatio = 16 / 12;
  bool error;

  @override
  void initState() {
    loading = true;
    error = false;
    loadingComplete = false;
    super.initState();
  }

  Container _greyContainer() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[300],
        borderRadius: BorderRadius.circular(radius),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    if (error == true)
      return Container();
    else
      return ZoomOverlay(
        twoTouchOnly: true,
        child: AspectRatio(
          aspectRatio: aspectRatio,
          child: Stack(
            children: [
              loading ? _greyContainer() : Container(),
              AspectRatio(
                aspectRatio: aspectRatio,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(radius),
                  child: widget.url != null
                      ? Image.network(
                          widget.url,
                          fit: BoxFit.cover,
                          // opacity: AlwaysStoppedAnimation(0.5),
                          loadingBuilder: (BuildContext context, Widget child,
                              ImageChunkEvent loadingProgress) {
                            if (loadingProgress == null) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                if (mounted &&
                                    loading == false &&
                                    !loadingComplete)
                                  setState(() {
                                    loadingComplete = true;
                                  });
                                if (loading) {
                                  loading = false;
                                }
                              });

                              return child;
                            }
                            return Center(
                              child: SizedBox(
                                height: 150,
                                width: 150,
                                child: CircularProgressIndicator(
                                  value: loadingProgress.expectedTotalBytes !=
                                          null
                                      ? loadingProgress.cumulativeBytesLoaded /
                                          loadingProgress.expectedTotalBytes
                                      : null,
                                  color: Colors.grey,
                                  strokeWidth: 1.5,
                                ),
                              ),
                            );
                          },
                          errorBuilder: (context, e, stackTrace) {
                            WidgetsBinding.instance.addPostFrameCallback((_) {
                              if (mounted) {
                                error = true;
                                setState(() {});
                              }
                            });
                            return Container();
                          },
                        )
                      : Container(),
                ),
              ),
              widget.showPlayIcon
                  ? Center(
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[800].withOpacity(0.5),
                          shape: BoxShape.circle,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(12, 12, 12, 10),
                          child: Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 28,
                          ),
                        ),
                      ),
                    )
                  : Container(),
              Positioned(
                left: 4.0,
                bottom: 2.0,
                child: Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800].withOpacity(0.8),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    padding: EdgeInsets.symmetric(horizontal: 5, vertical: 2),
                    child: Text(
                      "${humanizeIntInd(widget.numberOfViews)} ${VIEWS.tr()}",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                      ),
                    )),
              ),
            ],
          ),
        ),
      );
  }
}
