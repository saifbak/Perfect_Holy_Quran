import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/widgets/tajweedRuleItem.dart';

class TajweedRules extends StatefulWidget {
  const TajweedRules({key}) : super(key: key);

  @override
  _TajweedRulesState createState() => _TajweedRulesState();
}

class _TajweedRulesState extends State<TajweedRules> {
  bool switchStatus = false;
  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: SafeArea(
        child: Scaffold(
          // appBar: AppBar(
          //   brightness: Brightness.dark,

          //   backgroundColor: Colors.white.withOpacity(0),

          //   bottom: PreferredSize(
          //     preferredSize: Size(0, 30),
          //     child: Row(
          //       children: [
          //         SizedBox(width: 10),
          //         InkWell(
          //           onTap: () => Navigator.of(context).pop(),
          //           child: Icon(
          //             Icons.arrow_back_ios,
          //             color: _isDarkMode ? Color(0xff025241) : Colors.white,
          //           ),
          //         ),
          //         SizedBox(width: 75),
          //         Text(
          //           "Tajweed Rules",
          //           style: TextStyle(
          //             color: _isDarkMode ? Color(0xff025241) : Colors.white,
          //             fontWeight: FontWeight.bold,
          //             fontSize: 20,
          //           ),
          //         ),
          //       ],
          //     ),
          //   ),
          //   // centerTitle: true,
          //   elevation: 0.0,

          //   // automaticallyImplyLeading: false,
          // ),
          body: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/background.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            child: Stack(
              children: [
                Align(
                    alignment: Alignment.bottomLeft,
                    child: RotationTransition(
                      turns: AlwaysStoppedAnimation(-1 / 2),
                      child: Image.asset(
                        'assets/bottomleft.png',
                        color: AppColors.greenColors,
                        height: MediaQuery.of(context).size.height * 0.12,
                        width: MediaQuery.of(context).size.width * 0.29,
                      ),
                    )),
                Align(
                    alignment: Alignment.topRight,
                    child: Image.asset(
                      'assets/topright.png',
                      color: AppColors.greenColors,
                      height: MediaQuery.of(context).size.height * 0.12,
                      width: MediaQuery.of(context).size.width * 0.29,
                    )),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: ListView(
                    children: [
                      Container(
                        // decoration: BoxDecoration(
                        //   image: DecorationImage(
                        //     image: AssetImage(
                        //       "assets/background.png",
                        //     ),
                        //   ),
                        // ),
                        height: 70,
                        child: Stack(
                          children: [
                            Positioned(
                                left: 0,
                                top: 50,
                                child: GestureDetector(
                                  onTap: () => Navigator.pop(context),
                                  child: Icon(
                                    Icons.arrow_back_ios,
                                    color: _isDarkMode
                                        ? AppColors.greenColors
                                        : Colors.white,
                                  ),
                                )),
                            Positioned(
                                left: 120,
                                top: 50,
                                child: Text(
                                  "Tajweed Rules",
                                  style: TextStyle(
                                      color: _isDarkMode
                                          ? AppColors.greenColors
                                          : Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getScreenHeight(30),
                      ),
                      Container(
                        padding: EdgeInsets.symmetric(
                          horizontal: getScreenWidth(15),
                          vertical: getScreenHeight(15),
                        ),
                        decoration: kDefaultBoxShadow,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Show Color Tajweed Rules',
                              style: TextStyle(
                                color: AppColors.greenColors,
                                fontWeight: FontWeight.bold,
                                fontSize: getScreenHeight(14),
                              ),
                            ),
                            FlutterSwitch(
                              activeToggleColor: Colors.white,
                              activeColor: Color(0xff5FBEAA),
                              activeSwitchBorder: Border.all(
                                color: Color(0xff5FBEAA),
                              ),
                              inactiveSwitchBorder:
                                  Border.all(color: Colors.grey),
                              width: 50.0,
                              height: 25.0,
                              toggleSize: 30.0,
                              value: switchStatus,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 0,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus = value;
                                });
                              },
                            )
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getScreenHeight(20),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(2.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Mushaf Font only',
                              style: TextStyle(
                                color: _isDarkMode
                                    ? Color(0xff025241)
                                    : Colors.white,
                                fontSize: getScreenHeight(16),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              'Content Update',
                              style: TextStyle(
                                decoration: TextDecoration.underline,
                                color: _isDarkMode
                                    ? Color(0xff025241)
                                    : Colors.white,
                                fontSize: getScreenHeight(14),
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: getScreenHeight(10),
                      ),
                      Container(
                        decoration: kDefaultBoxShadow,
                        child: Column(
                          children: [
                            TajweedRuleItem(
                              title: 'ٌةَّداَضَتُﻢﻟا ُﺮﻳَغ ُتاَفِّﺺﻟا',
                              subtitle:
                                  'Madd(Prolongation) 6 beats(compulsory)',
                            ),
                            Container(
                              height: 1,
                              color: Color(0xffCFEDE7),
                            ),
                            TajweedRuleItem(
                              title: 'ُماَّﺖﻟا ُءاَدِتْبِﺈﻟا',
                              subtitle: 'Madd 4 or 5 beats(mandatory)',
                            ),
                            Container(
                              height: 1,
                              color: Color(0xffCFEDE7),
                            ),
                            TajweedRuleItem(
                              title: 'ِفوُرُﺢﻟا ُتاَفِص',
                              subtitle: 'Madd 2 or 4 or 5 beats(Permitted)',
                            ),
                            Container(
                              height: 1,
                              color: Color(0xffCFEDE7),
                            ),
                            TajweedRuleItem(
                              title: 'ِفوُرُﺢﻟا ُجِراَخَم',
                              subtitle: 'Madd 2  beats',
                            ),
                            Container(
                              height: 1,
                              color: Color(0xffCFEDE7),
                            ),
                            TajweedRuleItem(
                              title: 'ُجُرْعَي - َجَرَع',
                              subtitle:
                                  'Ghunna (nasal sound) with ikhfaa(hiding)',
                            ),
                            Container(
                              height: 1,
                              color: Color(0xffCFEDE7),
                            ),
                            TajweedRuleItem(
                              title: 'ز،ص،س',
                              subtitle: 'Idghaam(mixing) with silent letter',
                            ),
                            Container(
                              height: 1,
                              color: Color(0xffCFEDE7),
                            ),
                            TajweedRuleItem(
                              title: 'ث،ذ،ظ',
                              subtitle: 'Tafkheem Ar-raa(Heavy Raa)',
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
