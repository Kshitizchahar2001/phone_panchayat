// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';

class FacebookVideoPlayer extends StatelessWidget {
  final String src;
  const FacebookVideoPlayer({Key key, @required this.src}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: InAppWebView(
        initialData: InAppWebViewInitialData(
          data: '<iframe id="player" type="text/html"'
              ' style="position:absolute; top:0px; left:0px; bottom:0px; right:10px;'
              ' width:100%; height:100%; border:none; margin:0; padding:0; overflow:hidden; z-index:999999; display:auto"'
              ' src=$src frameborder="0" allowfullscreen></iframe>',
          encoding: 'utf-8',
          mimeType: 'text/html',
        ),
        onLoadStart: (InAppWebViewController controller, Uri url) {},
        onLoadStop: (InAppWebViewController controller, Uri url) {},
        initialOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(
            mediaPlaybackRequiresUserGesture: false,
            transparentBackground: true,
            disableContextMenu: true,
            supportZoom: false,
            disableHorizontalScroll: false,
            disableVerticalScroll: false,
            useShouldOverrideUrlLoading: true,
          ),
          ios: IOSInAppWebViewOptions(
            allowsInlineMediaPlayback: true,
            allowsAirPlayForMediaPlayback: true,
            allowsPictureInPictureMediaPlayback: true,
          ),
          android: AndroidInAppWebViewOptions(
            useWideViewPort: false,
          ),
        ),
      ),
    );
  }
}
