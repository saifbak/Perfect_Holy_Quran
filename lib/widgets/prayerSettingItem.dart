import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class PrayerSettingItem extends StatelessWidget {
  const PrayerSettingItem({
    this.title,
    this.subtitle,
    this.onTap,
  });

  final String title, subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        height: 60,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$title',
                    style: TextStyle(
                      color: AppColors.greenColors,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text('$subtitle',
                      style: TextStyle(
                          color: AppColors.greenColors, fontSize: 12)),
                ],
              ),
              Icon(
                Icons.arrow_forward_ios_rounded,
                color: AppColors.greenColors,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
