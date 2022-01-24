import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

import 'package:perfectholyquran/utils/sizeConfig.dart';

class TajweedRuleItem extends StatelessWidget {
  const TajweedRuleItem({
    this.title,
    this.subtitle,
    Key key,
  }) : super(key: key);

  final String title, subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: getScreenWidth(15),
        vertical: getScreenHeight(15),
      ),
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: AppColors.greenColors,
                fontWeight: FontWeight.bold,
                fontSize: getScreenHeight(18),
              ),
            ),
            // SizedBox(
            //   height: 5,
            // ),
            Text(
              '$subtitle',
              style: TextStyle(
                fontSize: getScreenHeight(10),
                fontWeight: FontWeight.bold,
                color: AppColors.greenColors,
              ),
            ),
          ],
        ),
        Icon(
          CupertinoIcons.speaker_2,
          color: Color(0xff5FBEAA),
        ),
      ]),
    );
  }
}
