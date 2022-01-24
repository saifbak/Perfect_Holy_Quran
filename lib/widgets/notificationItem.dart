import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';

import 'package:perfectholyquran/utils/sizeConfig.dart';

class NotificationItem extends StatefulWidget {
  const NotificationItem({
    Key key,
    this.title,
    this.subtitle,
    @required this.switchStatus,
  }) : super(key: key);

  final bool switchStatus;
  final String title, subtitle;

  @override
  _NotificationItemState createState() => _NotificationItemState();
}

class _NotificationItemState extends State<NotificationItem> {
  @override
  Widget build(BuildContext context) {
    bool localswitchStatus = widget.switchStatus;
    return Container(
      height: getScreenHeight(60),
      decoration: kDefaultBoxShadow,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '${widget.title}',
                  style: TextStyle(
                    color: AppColors.greenColors,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                SizedBox(
                  height: getScreenHeight(5),
                ),
                Text(
                  '${widget.subtitle}',
                  style: TextStyle(
                    color: AppColors.greenColors,
                    fontSize: getScreenHeight(10),
                  ),
                ),
              ],
            ),
            FlutterSwitch(
              activeToggleColor: Colors.white,
              activeColor: Color(0xff5FBEAA),
              activeSwitchBorder: Border.all(
                color: Color(0xff5FBEAA),
              ),
              inactiveSwitchBorder: Border.all(color: Colors.grey),
              width: 50.0,
              height: 30.0,
              toggleSize: 30.0,
              value: localswitchStatus,
              borderRadius: 30.0,
              showOnOff: false,
              padding: 0,
              onToggle: (value) {
                setState(() {
                  localswitchStatus = value;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
