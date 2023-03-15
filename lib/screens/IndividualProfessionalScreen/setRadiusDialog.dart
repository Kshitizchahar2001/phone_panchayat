// ignore_for_file: file_names, prefer_const_constructors_in_immutables, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/constants.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/services/radiusData.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:easy_localization/easy_localization.dart';


class SetRadiusDialog extends StatefulWidget {
  final RadiusData radiusData;

  SetRadiusDialog({
    Key key,
    @required this.radiusData,
  }) : super(key: key);

  @override
  _SetRadiusDialogState createState() => _SetRadiusDialogState();
}

class _SetRadiusDialogState extends State<SetRadiusDialog> {
  FixedExtentScrollController _fixedExtentScrollController;
  int oldSelectedItemIndex;

  @override
  void initState() {
    _fixedExtentScrollController = FixedExtentScrollController(
        initialItem: widget.radiusData.kilometerRange.indexOf(
      widget.radiusData.radius,
    ));
    super.initState();
  }

  @override
  void dispose() {
    _fixedExtentScrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: getPostWidgetSymmetricPadding(context, horizontal: 8),
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Padding(
            padding: getPostWidgetSymmetricPadding(context,
                horizontal: 6, vertical: 3),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(SET_RADIUS.tr(),
                    style: Theme.of(context).textTheme.headline1.copyWith(
                            fontSize: responsiveFontSize(
                          context,
                          size: ResponsiveFontSizes.l,
                        ))),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: context.safePercentHeight * 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Flexible(
                        flex: 1,
                        child: ListWheelScrollView.useDelegate(
                          physics: FixedExtentScrollPhysics(),
                          controller: _fixedExtentScrollController,
                          perspective: 0.0000000001,
                          itemExtent: 30,
                          useMagnifier: true,
                          magnification: 1.5,
                          diameterRatio: 1,
                          childDelegate: ListWheelChildBuilderDelegate(
                              builder: (BuildContext context, int index) {
                            if (index < 0 ||
                                index >
                                    widget.radiusData.kilometerRange.length -
                                        1) {
                              return null;
                            }
                            return Align(
                              alignment: Alignment.center,
                              child: Text(
                                  '${widget.radiusData.kilometerRange[index]}',
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline1
                                      .copyWith(
                                          fontSize: responsiveFontSize(
                                        context,
                                        size: ResponsiveFontSizes.s,
                                      ))
                                  // TextStyle(
                                  //   color: Colors.black,
                                  // ),
                                  ),
                            );
                          }),
                        ),
                      ),
                      Flexible(
                          flex: 1,
                          child: Text(
                            KMS.tr(),
                            maxLines: 1,
                            style:
                                Theme.of(context).textTheme.headline1.copyWith(
                                        fontSize: responsiveFontSize(
                                      context,
                                      size: ResponsiveFontSizes.s10,
                                    )),
                          )),
                    ],
                  ),
                ),
                ResponsiveHeight(
                  heightRatio: 2,
                ),
                CustomButton(
                  autoSize: true,
                  text: SET.tr(),
                  buttonColor: maroonColor,
                  onPressed: () {
                    widget.radiusData.radius = widget
                        .radiusData
                        .kilometerRange[
                            _fixedExtentScrollController.selectedItem]
                        .toDouble();
                    widget.radiusData.performQuery();
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
