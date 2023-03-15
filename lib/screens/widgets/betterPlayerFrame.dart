// ignore_for_file: file_names, use_key_in_widget_constructors, prefer_const_constructors_in_immutables, curly_braces_in_flow_control_structures, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';
import 'dart:io';

class BetterPlayerFrame extends StatefulWidget {
  final String url;
  final File file;
  final BetterPlayerControlsConfiguration controlsConfiguration;

  BetterPlayerFrame({this.url, this.file, this.controlsConfiguration});
  @override
  _BetterPlayerFrameState createState() => _BetterPlayerFrameState();
}

class _BetterPlayerFrameState extends State<BetterPlayerFrame> {
  int value;
  BetterPlayerController _betterPlayerController;
  String lastUrl;
  String lastFilePath;

  @override
  void initState() {
    value = 0;
    lastUrl = widget.url;
    lastFilePath = widget.file?.path;
    super.initState();
    _betterPlayerController = getBetterPlayerController(
      url: widget.url,
      file: widget.file,
      controlsConfiguration: widget.controlsConfiguration,
    );

    // changeVideoAfterSomeTime();
  }

  @override
  void dispose() {
    _betterPlayerController.dispose();
    super.dispose();
  }

  reinitialiseVideoPlayer() {
    _betterPlayerController = getBetterPlayerController(
      url: widget.url,
      file: widget.file,
      controlsConfiguration: widget.controlsConfiguration,
    );
    setState(() {
      value++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 16 / 9,
      child: BetterPlayer(
        key: ValueKey(value),
        controller: _betterPlayerController,
      ),
    );
  }
}

BetterPlayerController getBetterPlayerController(
    {String url,
    File file,
    BetterPlayerControlsConfiguration controlsConfiguration}) {
  BetterPlayerDataSource betterPlayerDataSource;
  if (url != null)
    betterPlayerDataSource =
        BetterPlayerDataSource(BetterPlayerDataSourceType.network, url);
  else if (file != null)
    betterPlayerDataSource = BetterPlayerDataSource(
      BetterPlayerDataSourceType.file,
      file.path,
    );

  return BetterPlayerController(
      BetterPlayerConfiguration(
          fit: BoxFit.fitHeight,
          autoPlay: true,
          looping: true,
          controlsConfiguration:
              controlsConfiguration ?? BetterPlayerControlsConfiguration()),
      betterPlayerDataSource: betterPlayerDataSource);
}
