// ignore_for_file: file_names, curly_braces_in_flow_control_structures

import 'package:flutter/material.dart';

class ImageWithLoadingIndicator extends StatefulWidget {
  final String url;
  const ImageWithLoadingIndicator({Key key, @required this.url})
      : super(key: key);

  @override
  State<ImageWithLoadingIndicator> createState() =>
      _ImageWithLoadingIndicatorState();
}

class _ImageWithLoadingIndicatorState extends State<ImageWithLoadingIndicator> {
  bool loading;
  bool loadingComplete;
  bool error;

  @override
  void initState() {
    loading = true;
    error = false;
    loadingComplete = false;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Image.network(
      widget.url,
      fit: BoxFit.cover,
      // opacity: AlwaysStoppedAnimation(0.5),
      loadingBuilder: (BuildContext context, Widget child,
          ImageChunkEvent loadingProgress) {
        if (loadingProgress == null) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted && loading == false && !loadingComplete)
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
              value: loadingProgress.expectedTotalBytes != null
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
    );
  }
}
