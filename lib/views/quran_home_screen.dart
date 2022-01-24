import 'dart:async';

import 'package:flutter/material.dart';
import 'package:perfectholyquran/canvachanges/AllSurah.dart';
import 'package:perfectholyquran/mychanges/sura_screen_tab.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/helper.dart';
import 'package:perfectholyquran/views/drawer_screen.dart';
import 'package:perfectholyquran/views/home_screen.dart';
import 'package:perfectholyquran/widgets/juzz_list_screen.dart';
import 'package:perfectholyquran/widgets/surah_screen.dart';

class QuranHomeScreen extends StatefulWidget {
  @override
  _QuranHomeScreenState createState() => _QuranHomeScreenState();
}

class _QuranHomeScreenState extends State<QuranHomeScreen>
    with TickerProviderStateMixin {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  TabController _controller;
  var activeTab = 1;
  var activeItem = 1;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    Helper.countTime.cancel();
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: _isDarkMode
                  ? BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage(
                            "assets/background.png",
                          ),
                          fit: BoxFit.cover),
                    )
                  : BoxDecoration(color: Colors.black),
              child: SafeArea(
                child: ListView(
                  children: [
                    Container(
                      decoration: BoxDecoration(),
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 15,
                              top: 50,
                              child: InkWell(
                                onTap: () {
                                  Helper.totalTime =
                                      Helper.totalTime + Helper.second;
                                  Helper.countTime.cancel();
                                  if (Helper.prefs.getInt('counter') != null) {
                                    Helper.updateCounter =
                                        Helper.prefs.getInt('counter');
                                    print(
                                        "stored counter = ${Helper.updateCounter}");
                                    Helper.updateCounter =
                                        Helper.updateCounter + Helper.second;
                                    Helper.prefs.setInt(
                                        'counter', Helper.updateCounter);
                                    setState(() {});
                                  } else {
                                    Helper.prefs.setInt('counter', 0);
                                  }
                                  Navigator.pop(context);
                                  // Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen()));
                                },
                                child: Icon(
                                  Icons.arrow_back,
                                  size: 25,
                                  color: _isDarkMode
                                      ? AppColors.greenColors
                                      : Colors.white,
                                ),
                              )),
                          Positioned(
                              left: 60,
                              top: 50,
                              child: Text(
                                "Perfect Holy Quran",
                                style: TextStyle(
                                    color: _isDarkMode
                                        ? AppColors.greenColors
                                        : Colors.white,
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold),
                              )),
                          Positioned(
                            right: 18,
                            top: 57,
                            child: Builder(builder: (context) {
                              return InkWell(
                                onTap: () {
                                  Scaffold.of(context).openDrawer();
                                },
                                child: Image.asset(
                                  "assets/menuIcon.png",
                                  scale: 1.2,
                                ),
                              );
                            }),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      height: 65,
                      width: MediaQuery.of(context).size.width * 0.7,
                      decoration: BoxDecoration(
                          color: kSecondaryColor,
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(15),
                              topLeft: Radius.circular(15))),
                      // padding: EdgeInsets.symmetric(vertical: 20),
                      margin: EdgeInsets.symmetric(horizontal: 15),
                      child: Center(
                        child: Container(
                          decoration: BoxDecoration(
                            // color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          // width: 150,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  activeTab = 1;
                                  setState(() {});
                                },
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(5),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    width: activeTab == 1 ? 80 : 75,
                                    height: activeTab == 1 ? 35 : 30,

                                    // padding: EdgeInsets.symmetric(vertical: 5),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: activeTab == 1
                                          ? kSecondaryColor
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: activeTab == 1
                                              ? Colors.black38
                                              : Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(
                                          color: activeTab == 1
                                              ? Colors.white
                                              : kSecondaryColor),
                                    ),
                                    child: Center(
                                        child: Text(
                                      "Juz",
                                      style: TextStyle(
                                        color: activeTab == 1
                                            ? Colors.white
                                            : AppColors.greenColors,
                                      ),
                                    )),
                                  ),
                                ),
                              ),
                              // SizedBox(width: 0.5),
                              InkWell(
                                onTap: () {
                                  activeTab = 2;
                                  setState(() {});
                                },
                                child: Material(
                                  elevation: 4,
                                  borderRadius: BorderRadius.circular(5),
                                  child: AnimatedContainer(
                                    duration: Duration(milliseconds: 300),
                                    // padding: EdgeInsets.symmetric(vertical: 5),
                                    width: activeTab == 2 ? 80 : 75,

                                    height: activeTab == 2 ? 35 : 30,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(5),
                                      color: activeTab == 2
                                          ? kSecondaryColor
                                          : Colors.white,
                                      boxShadow: [
                                        BoxShadow(
                                          color: activeTab == 2
                                              ? Colors.black38
                                              : Colors.black12,
                                          spreadRadius: 1,
                                          blurRadius: 8,
                                          offset: Offset(0,
                                              2), // changes position of shadow
                                        ),
                                      ],
                                      border: Border.all(
                                          color: activeTab == 2
                                              ? Colors.white
                                              : kSecondaryColor),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "Sura",
                                        style: TextStyle(
                                            color: activeTab == 2
                                                ? Colors.white
                                                : AppColors.greenColors),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    activeTab == 1
                        ? Container(
                            height: MediaQuery.of(context).size.height * 0.64,
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: JuzzListScreen(),
                            ),
                          )
                        : Container(
                            height: MediaQuery.of(context).size.height * 0.64,
                            width: MediaQuery.of(context).size.width * 0.07,
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              child: AllSurah(),
                            ),
                          ),
                    SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: Image.asset(
            //       'assets/bottomright.png',
            //       color: AppColors.greenColors,
            //       height: MediaQuery.of(context).size.height * 0.12,
            //       width: MediaQuery.of(context).size.width * 0.22,
            //     )),
            // Align(
            //     alignment: Alignment.bottomLeft,
            //     child: Image.asset(
            //       'assets/bottomleft.png',
            //       color: AppColors.greenColors,
            //       height: MediaQuery.of(context).size.height * 0.12,
            //       width: MediaQuery.of(context).size.width * 0.29,
            //     )),
            // Align(
            //     alignment: Alignment.topRight,
            //     child: Image.asset(
            //       'assets/topright.png',
            //       color: AppColors.greenColors,
            //       height: MediaQuery.of(context).size.height * 0.12,
            //       width: MediaQuery.of(context).size.width * 0.29,
            //     )),
          ],
        ),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerScreen(),
      ),
    );
  }
}
