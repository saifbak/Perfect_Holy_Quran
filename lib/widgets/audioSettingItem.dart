import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class AudioSettingItem extends StatefulWidget {
  AudioSettingItem({
    this.title,
    this.subtitle,
    this.state,
    this.currentAyaDelay: 25,
  });
  final double currentAyaDelay;
  final String title, state, subtitle;
  @override
  _AudioSettingItemState createState() => _AudioSettingItemState();
}

class _AudioSettingItemState extends State<AudioSettingItem> {
  @override
  Widget build(BuildContext context) {
    double localAyaDelay = widget.currentAyaDelay;
    return Container(
      decoration: kDefaultBoxShadow,
      padding: EdgeInsets.symmetric(
        vertical: getScreenHeight(10),
        horizontal: getScreenWidth(15),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '${widget.title}',
                style: TextStyle(
                  color: AppColors.greenColors,
                  fontSize: getScreenHeight(14),
                  fontWeight: FontWeight.w500,
                ),
              ),
              Text(
                '${widget.state}',
                style: TextStyle(
                  color: AppColors.greenColors,
                  fontSize: getScreenHeight(14),
                ),
              ),
            ],
          ),
          SizedBox(
            height: getScreenHeight(10),
          ),
          Text(
            '${widget.subtitle}',
            style: TextStyle(
              color: AppColors.greenColors,
              fontSize: getScreenHeight(11),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                flex: 6,
                child: Slider.adaptive(
                  activeColor: AppColors.greenColors,
                  inactiveColor: Color(0xffECFAF7),
                  value: localAyaDelay,
                  min: 0,
                  max: 100,
                  onChanged: (double value) {
                    setState(() {
                      localAyaDelay = value;
                    });
                  },
                ),
              ),
              Expanded(
                flex: 3,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        CupertinoIcons.minus_circle_fill,
                        color: Color(0xff5FBEAA),
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                    IconButton(
                      padding: EdgeInsets.all(0),
                      icon: Icon(
                        CupertinoIcons.plus_circle_fill,
                        color: AppColors.greenColors,
                        size: 30.0,
                      ),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
