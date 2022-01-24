import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class TopCard extends StatelessWidget {
  const TopCard({
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
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey,
                  spreadRadius: 0.9,
                  blurRadius: 16,
                  offset: Offset(2, 6), // changes position of shadow
                ),
              ],
            ),
            child: Container(
              //color: Colors.grey[100],
              child: Image.asset(
                "$image",
                scale: getScreenHeight(scale),
              ),
            ),
          ),
          SizedBox(
            height: getScreenHeight(8),
          ),
          Text(
            "$title",
            style: TextStyle(
                fontSize: 12,
                color: _isDarkMode ? const Color(0xff00251D) : Colors.white,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
