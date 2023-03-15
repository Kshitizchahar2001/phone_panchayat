// ignore_for_file: file_names, unnecessary_string_interpolations, deprecated_member_use, prefer_is_empty, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';

import '../find_professionals_screen.dart';

class PlaceIdentifierTile extends StatelessWidget {
  final Places places;
  const PlaceIdentifierTile({
    Key key,
    @required this.places,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String placeName = GetPlaceName.getPlaceName(places, context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      '${capitalise(placeName).toString()}',
                      style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(
                              context,
                              size: ResponsiveFontSizes.s10,
                            ),
                          ),
                    ),
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[50],
                    shape: BoxShape.circle,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      placeName.length > 0 ? placeName[0].toString() : "",
                      style: TextStyle(color: Colors.blue),
                    ),
                  ),
                )
              ],
            ),
          ),
          Divider(
            color: Colors.grey[300],
            thickness: 0.5,
          ),
        ],
      ),
    );
  }
}
