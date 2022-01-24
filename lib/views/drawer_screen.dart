import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/views/dua_categories_screen.dart';
import 'package:perfectholyquran/views/audioSettings.dart';
import 'package:perfectholyquran/views/nearbyMosques.dart';
import 'package:perfectholyquran/views/prayerSettings.dart';
import 'package:perfectholyquran/views/prayerTime.dart';
import 'package:perfectholyquran/views/privacy_screen.dart';
import 'package:perfectholyquran/views/quran_home_screen.dart';
import 'package:perfectholyquran/views/reciter.dart';
import 'package:perfectholyquran/views/tajweedRules.dart';
import 'package:perfectholyquran/widgets/drawerItem.dart';
import 'package:perfectholyquran/add_notification.dart';
import 'package:perfectholyquran/notification_manager.dart';
import 'package:perfectholyquran/views/videos_screen.dart';
import 'get_all_bookmarks.dart';
import 'package:perfectholyquran/views/channels_overview_screen.dart';

class DrawerScreen extends StatelessWidget {
  NotificationManager manager;
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: Theme(
        data: Theme.of(context).copyWith(
          canvasColor: AppColors.greenColors,
        ),
        child: Drawer(
          child: SafeArea(
            child: ListView(
              children: [
                Image.asset(
                  'assets/logo.png',
                  // width: 160,
                  height: 140,
                ),
                SizedBox(
                  height: getScreenHeight(30),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Home',
                  icon: Icons.home,
                  onTap: () {
                    Navigator.of(context).pop();
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Dua List',
                  image: 'assets/duaImage.png',
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return DuaCategoriesScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Reciters',
                  image: 'assets/03.png',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return Reciter();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Prayer Time',
                  image: 'assets/madinaImage.png',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PrayerTime();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Quran',
                  image: 'assets/quranRail.png',
                  onTap: () {
                    // Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return QuranHomeScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Nearby Masjid',
                  icon: Icons.location_on_outlined,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return NearbyMosques();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Tajweed Rules',
                  image: 'assets/quran.png',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return TajweedRules();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35),
                  child: Container(
                    height: 2.0,
                    width: MediaQuery.of(context).size.width,
                    color: Colors.white.withOpacity(0.2),
                  ),
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Settings',
                  icon: Icons.settings,
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return AudioSettings();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Prayer Settings',
                  image: 'assets/prayerTimeImage.png',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) {
                          return PrayerSettings();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Privacy Policy',
                  image: 'assets/privacy.PNG',
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return PrivacyScreen();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Book Marks',
                  icon: Icons.bookmark,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return GetAllBookmarks();
                        },
                      ),
                    );
                  },
                ),
                SizedBox(
                  height: getScreenHeight(10),
                ),
                DrawerItem(
                  title: 'Video Lectures',
                  icon: Icons.video_collection,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) {
                          return ChannelsOverviewScreen();
                        },
                      ),
                    );
                  },
                ),

                // SizedBox(
                //   height: getScreenHeight(10),
                // ),
                // DrawerItem(
                //   title: 'Add Notification',
                //   image: 'assets/privacy.PNG',
                //   onTap: () {
                //     Navigator.of(context).pop();
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //         builder: (context) {
                //
                //           return AddNotification(manager);
                //         },
                //       ),
                //     );
                //   },
                // ),
                // SizedBox(
                //   height: getScreenHeight(20),
                // ),
                // ListTile(
                //   title: Text('Dark Theme'),
                //   trailing: Switch(
                //     value: snapshot.data,
                //     onChanged: bloc.changeTheme,
                //   ),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
