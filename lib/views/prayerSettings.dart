import 'package:adhan/adhan.dart' as adhan;
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:geocoder/geocoder.dart';
// import 'package:hijri/hijri_calendar.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';

import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/views/notifications.dart';
import 'package:perfectholyquran/widgets/prayerSettingItem.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';

class PrayerSettings extends StatefulWidget {
  const PrayerSettings({key}) : super(key: key);

  @override
  _PrayerSettingsState createState() => _PrayerSettingsState();
}

class _PrayerSettingsState extends State<PrayerSettings> {
  bool switchStatus = false;
  bool switchStatus1 = false;
  bool switchStatus2 = false;
  bool switchStatus3 = false;
  bool switchStatus4 = false;
  bool switchStatus5 = false;

  String timeZoneName;
  var prayerTimes;
  var currentAddress;
  LocationData currentLocation;

  Future prayerTimeCalculation() async {
    var _coordinates = await determinePosition();
    final myCoordinates =
        adhan.Coordinates(_coordinates.latitude, _coordinates.longitude);
    final params = adhan.CalculationMethod.karachi.getParameters();
    params.madhab = adhan.Madhab.hanafi;
    prayerTimes = adhan.PrayerTimes.today(myCoordinates, params);
    timeZoneName = prayerTimes.fajr.timeZoneName;

    setState(() {});
  }

  Future getUserLocation() async {
    LocationData myLocation;
    String error;
    Location location = new Location();
    try {
      myLocation = await location.getLocation();
    } on PlatformException catch (e) {
      if (e.code == 'PERMISSION_DENIED') {
        error = 'please grant permission';
        print(error);
      }
      if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
        // error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    final coordinates =
        new Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await Geocoder.local.findAddressesFromCoordinates(coordinates);
    var first = addresses.first;
    print('${first.locality}, ${first.adminArea}');
    currentAddress = '${first.locality} ${first.adminArea}';
    //print("currentAddress = "+ currentAddress.toString());
    //return first;
  }

  @override
  void initState() {
    prayerTimeCalculation();
    getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    prayerTimeCalculation();
    getUserLocation();
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   brightness: Brightness.dark,
        //   backgroundColor: AppColors.greenColors,
        //   title: Text(
        //     'Prayer Settings',
        //   ),
        // ),
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                  image: DecorationImage(
                image: AssetImage(
                  "assets/background.png",
                ),
                fit: BoxFit.cover,
              )),
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: ListView(
                // crossAxisAlignment: CrossAxisAlignment.start,
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
                            left: 10,
                            top: 50,
                            child: GestureDetector(
                              onTap: () => Navigator.pop(context),
                              child: Icon(
                                Icons.arrow_back_ios,
                                color: AppColors.greenColors,
                              ),
                            )),
                        Positioned(
                            left: 110,
                            top: 50,
                            child: Text(
                              "Prayer Settings",
                              style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    height: 60,
                    decoration: kDefaultBoxShadow,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sura-al-kahf',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '10:30 AM Every Friday',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FlutterSwitch(
                              activeToggleColor: Color(0xff5FBEAA),
                              inactiveToggleColor: Colors.black,
                              inactiveColor: Colors.white,
                              activeColor: Colors.white,
                              // activeSwitchBorder: Border.all(
                              //   color: Color(0xff5FBEAA),
                              // ),
                              // inactiveSwitchBorder:
                              //     Border.all(color: Colors.grey),
                              width: 40.0,
                              height: 26.0,
                              toggleSize: 22.0,
                              value: switchStatus,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 2,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    decoration: kDefaultBoxShadow,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Weekly Tips',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                '40:00 PM Every Wednesday',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FlutterSwitch(
                              activeToggleColor: Color(0xff5FBEAA),
                              activeColor: Colors.white,
                              inactiveToggleColor: Colors.black,
                              inactiveColor: Colors.white,
                              // activeSwitchBorder: Border.all(
                              //   color: Color(0xff5FBEAA),
                              // ),
                              // inactiveSwitchBorder:
                              //     Border.all(color: Colors.grey),
                              width: 40.0,
                              height: 26.0,
                              toggleSize: 22.0,
                              value: switchStatus1,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 2,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus1 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 4.0, vertical: 8),
                    child: Text(
                      'Daily Notification',
                      style: TextStyle(
                        fontSize: 20,
                        color: AppColors.greenColors,
                      ),
                    ),
                  ),
                  Container(
                    decoration: kDefaultBoxShadow,
                    child: Column(
                      children: [
                        PrayerSettingItem(
                          title: 'Prayer Times',
                          subtitle: 'Fajr, Sunrise, Zohr, Asr, Maghrib, Isha',
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),

                  Container(
                    height: 60,
                    decoration: kDefaultBoxShadow,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sura Ya-Seen',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Never',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FlutterSwitch(
                              activeToggleColor: Color(0xff5FBEAA),
                              activeColor: Colors.white,
                              inactiveToggleColor: Colors.black,
                              inactiveColor: Colors.white,
                              // activeSwitchBorder: Border.all(
                              //   color: Color(0xff5FBEAA),
                              // ),
                              // inactiveSwitchBorder:
                              //     Border.all(color: Colors.grey),
                              width: 40.0,
                              height: 26.0,
                              toggleSize: 22.0,
                              value: switchStatus2,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 2,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus2 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    decoration: kDefaultBoxShadow,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sura Al-Waqia',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Never',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FlutterSwitch(
                              activeToggleColor: Color(0xff5FBEAA),
                              activeColor: Colors.white,
                              inactiveToggleColor: Colors.black,
                              inactiveColor: Colors.white,
                              // activeSwitchBorder: Border.all(
                              //   color: Color(0xff5FBEAA),
                              // ),
                              // inactiveSwitchBorder:
                              //     Border.all(color: Colors.grey),
                              width: 40.0,
                              height: 26.0,
                              toggleSize: 22.0,
                              value: switchStatus3,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 2,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus3 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),

                  Container(
                    height: 60,
                    decoration: kDefaultBoxShadow,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Sura Al-Mulk',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Never',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FlutterSwitch(
                              activeToggleColor: Color(0xff5FBEAA),
                              activeColor: Colors.white,
                              inactiveToggleColor: Colors.black,
                              inactiveColor: Colors.white,
                              // activeSwitchBorder: Border.all(
                              //   color: Color(0xff5FBEAA),
                              // ),
                              // inactiveSwitchBorder:
                              //     Border.all(color: Colors.grey),
                              width: 40.0,
                              height: 26.0,
                              toggleSize: 22.0,
                              value: switchStatus4,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 2,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus4 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 60,
                    decoration: kDefaultBoxShadow,
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Recitation Reminder',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'Never',
                                style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                          Container(
                            height: 25,
                            decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 3,
                                  offset: Offset(2, 2),
                                )
                              ],
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: FlutterSwitch(
                              activeToggleColor: Color(0xff5FBEAA),
                              activeColor: Colors.white,
                              inactiveToggleColor: Colors.black,
                              inactiveColor: Colors.white,
                              // activeSwitchBorder: Border.all(
                              //   color: Color(0xff5FBEAA),
                              // ),
                              // inactiveSwitchBorder:
                              //     Border.all(color: Colors.grey),
                              width: 40.0,
                              height: 26.0,
                              toggleSize: 22.0,
                              value: switchStatus5,
                              borderRadius: 30.0,
                              showOnOff: false,
                              padding: 2,
                              onToggle: (value) {
                                setState(() {
                                  switchStatus5 = value;
                                });
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Container(
                  //   decoration: kDefaultBoxShadow,
                  //   child: Column(
                  //     children: [
                  //       // PrayerSettingItem(
                  //       //   title: 'Current Location',
                  //       //   subtitle:
                  //       //       '${currentAddress != null ? currentAddress : 'Pakistan'}, ${timeZoneName != null ? timeZoneName : 'PKT'}',
                  //       // ),
                  //       Container(
                  //         height: 1,
                  //         width: double.infinity,
                  //         color: Color(0xffCFEDE7),
                  //       ),
                  //       PrayerSettingItem(
                  //         title: 'Hijri Date',
                  //         subtitle:
                  //             '${HijriCalendar.now().toFormat("MMMM dd yyyy")}',
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: getScreenHeight(20),
                  // ),
                  // Container(
                  //   height: getScreenHeight(60),
                  //   decoration: kDefaultBoxShadow,
                  //   child: Padding(
                  //     padding: EdgeInsets.symmetric(
                  //       horizontal: 20,
                  //     ),
                  //     child: Row(
                  //       mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //       children: [
                  //         Text(
                  //           'Advance Settings',
                  //           style: TextStyle(
                  //             color: AppColors.greenColors,
                  //             fontWeight: FontWeight.bold,
                  //           ),
                  //         ),
                  //         FlutterSwitch(
                  //           activeToggleColor: Colors.white,
                  //           activeColor: Color(0xff5FBEAA),
                  //           activeSwitchBorder: Border.all(
                  //             color: Color(0xff5FBEAA),
                  //           ),
                  //           inactiveSwitchBorder: Border.all(color: Colors.grey),
                  //           width: 50.0,
                  //           height: 30.0,
                  //           toggleSize: 30.0,
                  //           value: switchStatus,
                  //           borderRadius: 30.0,
                  //           showOnOff: false,
                  //           padding: 0,
                  //           onToggle: (value) {
                  //             setState(() {
                  //               switchStatus = value;
                  //             });
                  //           },
                  //         ),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // SizedBox(
                  //   height: getScreenHeight(20),
                  // ),
                  // switchStatus != false
                  //     ? Column(
                  //         crossAxisAlignment: CrossAxisAlignment.start,
                  //         children: [
                  //           Text(
                  //             'Advance Settings',
                  //             style: TextStyle(
                  //               fontSize: getScreenHeight(14),
                  //               color: AppColors.greenColors,
                  //             ),
                  //           ),
                  //           SizedBox(
                  //             height: getScreenHeight(15),
                  //           ),
                  //           Container(
                  //             decoration: kDefaultBoxShadow,
                  //             child: Column(
                  //               children: [
                  //                 PrayerSettingItem(
                  //                   title:
                  //                       '${currentAddress != null ? currentAddress : 'Time Zone'}',
                  //                   subtitle:
                  //                       '${timeZoneName != null ? timeZoneName : 'PKT'}',
                  //                   onTap: () {
                  //                     Navigator.push(context,
                  //                         MaterialPageRoute(builder: (context) {
                  //                       return Notifications();
                  //                     }));
                  //                   },
                  //                 ),
                  //                 Container(
                  //                   height: 1,
                  //                   width: double.infinity,
                  //                   color: Color(0xffCFEDE7),
                  //                 ),
                  //                 PrayerSettingItem(
                  //                   title: 'Fajr/isha Method',
                  //                   subtitle: 'Auto',
                  //                 ),
                  //                 Container(
                  //                   height: 1,
                  //                   width: double.infinity,
                  //                   color: Color(0xffCFEDE7),
                  //                 ),
                  //                 PrayerSettingItem(
                  //                   title: 'Asr Method',
                  //                   subtitle: 'Auto',
                  //                 ),
                  //                 Container(
                  //                   height: 1,
                  //                   width: double.infinity,
                  //                   color: Color(0xffCFEDE7),
                  //                 ),
                  //                 PrayerSettingItem(
                  //                   title: 'High Latitude Method',
                  //                   subtitle: 'Auto',
                  //                 ),
                  //               ],
                  //             ),
                  //           )
                  //         ],
                  //       )
                  //     : Container(),
                ],
              ),
            ),
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
          ],
        ),
      ),
    );
  }
}
