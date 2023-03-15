// ignore_for_file: file_names

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/widgets/ScrollToTop/scrollToTop.dart';

class ScrollTestPage extends StatefulWidget {
  const ScrollTestPage({Key key}) : super(key: key);

  @override
  State<ScrollTestPage> createState() => _ScrollTestPageState();
}

class _ScrollTestPageState extends State<ScrollTestPage> {
  ScrollController scrollController;
  @override
  void initState() {
    scrollController = ScrollController();
    super.initState();
  }

  @override
  void dispose() {
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ScrollToTop(
        scrollController: scrollController,
        child: ListView.builder(
          itemCount: 20,
          controller: scrollController,
          cacheExtent: 20000,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                color: Colors.blue,
                height: 300,
                width: 10,
              ),
            );
          },
        ),
      ),
    );
  }
}
