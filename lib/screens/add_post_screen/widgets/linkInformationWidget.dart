// ignore_for_file: file_names, deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/constants/stringsConstant.dart';
import 'package:online_panchayat_flutter/utils/utils.dart';
import 'package:easy_localization/easy_localization.dart';

class LinkInformationWidget extends StatelessWidget {
  const LinkInformationWidget({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: FractionallySizedBox(
        widthFactor: 0.7,
        child: Text(ADD_LINK_INFO,
            style: Theme.of(context).textTheme.subtitle2.copyWith(
                  fontWeight: FontWeight.normal,
                  fontSize: responsiveFontSize(context,
                      size: ResponsiveFontSizes.xs10),
                )).tr(),
      ),
    );
  }
}
