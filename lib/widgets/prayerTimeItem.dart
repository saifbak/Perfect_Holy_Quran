import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class PrayerTimeItem extends StatelessWidget {
  const PrayerTimeItem({
    this.title,
    this.time,
    this.itemSelected: false,
    this.onTap,
    this.icon,
    Key key,
  }) : super(key: key);

  final String title, time;
  final bool itemSelected;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(60),
      decoration: BoxDecoration(
        color: itemSelected != true ? Colors.white : Color(0xffECFAF7),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              flex: 2,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: AppColors.greenColors,
                      fontSize: getScreenHeight(14),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  itemSelected != true
                      ? Container()
                      : Text(
                          'Ends in 1h 44min',
                          style: TextStyle(
                            fontSize: getScreenHeight(11),
                            color: AppColors.greenColors,
                          ),
                        ),
                  SizedBox(
                    width: getScreenWidth(5),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    time,
                    style: TextStyle(
                      color: AppColors.greenColors,
                      fontSize: getScreenHeight(14),
                    ),
                  ),
                  GestureDetector(
                    onTap: onTap,
                    child: Icon(
                      icon,
                      size: getScreenHeight(20),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
