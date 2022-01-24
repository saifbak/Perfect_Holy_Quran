import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class ReciterItem extends StatelessWidget {
  const ReciterItem({
    this.title,
  });
  final String title;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(50),
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: getScreenHeight(20),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              '$title',
              style: TextStyle(
                color: AppColors.greenColors,
              ),
            ),
            Icon(
              Icons.download_rounded,
              color: AppColors.greenColors,
            ),
          ],
        ),
      ),
    );
  }
}
