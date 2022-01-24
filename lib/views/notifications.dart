import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';

import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/views/prayerSettings.dart';
import 'package:perfectholyquran/widgets/notificationItem.dart';
import 'package:perfectholyquran/widgets/prayerSettingItem.dart';

class Notifications extends StatefulWidget {
  const Notifications({key}) : super(key: key);

  @override
  _NotificationsState createState() => _NotificationsState();
}

class _NotificationsState extends State<Notifications> {
  bool switchStatus = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColors.greenColors,
        title: Text(
          'Notifications',
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(10),
            vertical: getScreenHeight(10),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              NotificationItem(
                title: 'Sura-al-kahf',
                subtitle: '10:30 AM Every Friday',
                switchStatus: true,
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              NotificationItem(
                title: 'Sura-al-kahf',
                subtitle: '10:30 AM Every Friday',
                switchStatus: true,
              ),
              SizedBox(
                height: getScreenHeight(20),
              ),
              Text(
                'Daily Notifications',
                style: TextStyle(
                  color: AppColors.greenColors,
                  fontSize: getScreenHeight(14),
                ),
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              Container(
                decoration: kDefaultBoxShadow,
                child: PrayerSettingItem(
                  title: 'Prayer Times',
                  subtitle: 'Fajr, Sunrise, Zohr, Asr, Maghrib, Isha',
                  onTap: () {},
                ),
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              NotificationItem(
                title: 'Sura Ya-Seen',
                subtitle: 'Never',
                switchStatus: false,
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              NotificationItem(
                title: 'Sura Al-Waqia',
                subtitle: 'Never',
                switchStatus: false,
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              NotificationItem(
                title: 'Sura Al-Mulk',
                subtitle: 'Never',
                switchStatus: false,
              ),
              SizedBox(
                height: getScreenHeight(10),
              ),
              NotificationItem(
                title: 'Recitation Reminder',
                subtitle: 'Never',
                switchStatus: false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
