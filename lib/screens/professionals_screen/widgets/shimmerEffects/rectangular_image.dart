// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:velocity_x/velocity_x.dart';

class RectangularImageLoading extends StatelessWidget {
  const RectangularImageLoading({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      child: Container(color: Colors.grey),
      baseColor: Colors.grey[300],
      highlightColor: Colors.grey[100],
    );
  }
}

class ListLoadingShimmer extends StatelessWidget {
  const ListLoadingShimmer({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: 8,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.symmetric(
              vertical: context.safePercentHeight * 0.2,
              horizontal: context.safePercentWidth * 1),
          child: Card(
            elevation: 2.0,
            color: Theme.of(context).cardColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0)),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: context.safePercentHeight * 1.7,
                  horizontal: context.safePercentWidth * 3),
              child: Shimmer.fromColors(
                baseColor: Colors.grey[300],
                highlightColor: Colors.grey[100],
                child: Column(
                  children: [
                    Row(
                      children: [
                        CircleAvatar(backgroundColor: Colors.black),
                        SizedBox(width: context.safePercentWidth * 2),
                        Expanded(
                          child: Container(
                            decoration: BoxDecoration(
                              color: lightGreySubheading,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 30,
                          ),
                        ),
                        SizedBox(width: context.safePercentWidth * 3),
                      ],
                    ),
                    SizedBox(height: context.safePercentHeight * 1.5),
                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        color: lightGreySubheading,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      height: 30,
                    ),
                    SizedBox(height: context.safePercentHeight * 1.5),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
