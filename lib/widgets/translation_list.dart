import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class TranslationList extends StatelessWidget {
  final int selectedIndex, index;
  TranslationList({
    this.selectedIndex,
    this.index,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: getScreenHeight(80),
      width: 100,
      decoration: BoxDecoration(
        color: selectedIndex != null && selectedIndex == index
            ? AppColors.greenColors
            : Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 3,
            offset: Offset(0, 3), // changes position of shadow
          ),
        ],
      ),
    );
  }
}
