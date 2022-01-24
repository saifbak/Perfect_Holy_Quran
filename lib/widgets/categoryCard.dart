import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard({
    this.title,
    this.image,
    this.scale,
    this.onTap,
    Key key,
  }) : super(key: key);

  final String title, image;
  final Function onTap;
  final double scale;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: getScreenHeight(95),
            width: getScreenHeight(95),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 1,
                  blurRadius: 100,
                  offset: Offset(0, 0.001), // changes position of shadow
                ),
              ],
            ),
            child: Image.asset(
              "$image",
              scale: getScreenHeight(scale),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Text(
            "$title",
            style: TextStyle(
              fontSize: getScreenHeight(12),
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
