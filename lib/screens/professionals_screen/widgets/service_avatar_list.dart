// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';
import 'package:online_panchayat_flutter/screens/professionals_screen/widgets/service_avatar.dart';
import 'package:velocity_x/velocity_x.dart';

class ServiceAvatarList extends StatelessWidget {
  const ServiceAvatarList(
      {Key key,
      @required this.serviceList,
      @required this.onClickServiceAvatar,
      @required this.sectionLabel})
      : super(key: key);

  final List<Map> serviceList;
  final Function onClickServiceAvatar;
  final String sectionLabel;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Theme.of(context).cardColor,
      elevation: 0,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: context.safePercentWidth * 3,
            vertical: context.safePercentHeight * 1.5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              sectionLabel,
              style: Theme.of(context).textTheme.headline6,
            ),
            SizedBox(
              height: context.safePercentHeight * 1.7,
            ),
            SizedBox(
              height: 90,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children: serviceList.map<Widget>((service) {
                  return ServiceAvatar(
                    serviceName: service["name"],
                    image: service["image"],
                    onClickServiceAvatar: () => onClickServiceAvatar(service),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
