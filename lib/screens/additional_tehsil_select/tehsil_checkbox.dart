// ignore_for_file: annotate_overrides, prefer_const_constructors, unnecessary_string_interpolations, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/models/Places.dart';
import 'package:online_panchayat_flutter/screens/SignUpScreen/Data/place.dart';
import 'package:online_panchayat_flutter/screens/find_professionals_screen.dart';
import 'package:online_panchayat_flutter/utils/customResponsiveValues.dart';
import 'package:online_panchayat_flutter/utils/getPlaceName.dart';
import 'package:velocity_x/velocity_x.dart';

class TehsilCheckBoxList extends StatefulWidget {
  final Places places;
  const TehsilCheckBoxList({Key key, @required this.places}) : super(key: key);

  @override
  State<TehsilCheckBoxList> createState() => _TehsilCheckBoxListState();
}

class _TehsilCheckBoxListState extends State<TehsilCheckBoxList> {
  bool _value;

  void initState() {
    _value = Place.selectedPlaceIds.contains(widget.places.id);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    String placeName = GetPlaceName.getPlaceName(widget.places, context);
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: context.safePercentWidth * 6),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: CheckboxListTile(
              contentPadding: EdgeInsets.zero,
              visualDensity: VisualDensity(horizontal: 0, vertical: -4.0),
              title: Text(
                '${capitalise(placeName).toString()}',
                style: Theme.of(context).textTheme.headline1.copyWith(
                      fontSize: responsiveFontSize(
                        context,
                        size: ResponsiveFontSizes.s10,
                      ),
                    ),
              ),
              value: _value,
              onChanged: (newValue) {
                setState(() {
                  _value = newValue;
                });
                if (_value) {
                  Place.selectedPlaceIds.add(widget.places.id);
                } else {
                  Place.selectedPlaceIds.remove(widget.places.id);
                }
              },
              controlAffinity: ListTileControlAffinity.trailing,
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
