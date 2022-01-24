import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:perfectholyquran/canvachanges/RecitersSurahList.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/helper.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/views/drawer_screen.dart';
import 'package:perfectholyquran/views/dua_categories_screen.dart';
import 'package:perfectholyquran/views/madinaLive.dart';
import 'package:perfectholyquran/views/makkahLive.dart';
import 'package:perfectholyquran/views/messages_screen.dart';
import 'package:perfectholyquran/views/prayer_time_main.dart';
import 'package:perfectholyquran/views/qibla_compass_screen.dart';
import 'package:perfectholyquran/views/quran_home_screen.dart';
import 'package:perfectholyquran/views/reciter.dart';
import 'package:perfectholyquran/views/sadqa_screen.dart';
import 'package:perfectholyquran/views/visualQuran.dart';
import 'package:perfectholyquran/widgets/ayatList.dart';
import 'package:perfectholyquran/widgets/topCard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:syncfusion_flutter_gauges/gauges.dart';
import 'package:perfectholyquran/models/ayat_wallpapers.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

List fonts = [
  GoogleFonts.scheherazade,
  GoogleFonts.almarai,
  GoogleFonts.amiri,
  GoogleFonts.katibeh,
  GoogleFonts.tajawal,
];

var fontName = <String>[
  'scheherazade',
  'almarai',
  'amiri',
  'katibeh',
  'tajawal',
];
int myindex = 0;

String _selectedFont = "aBeeZee";

class _HomeScreenState extends State<HomeScreen> {
  ThemeMode _themeMode = ThemeMode.system;
  int _selectedItemIndex = 0;
  int _selectedFontIndex = 0;
  double fontSizeValue = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();
  bool switchStatus = false;
  bool lineStatus = false;
  bool sideStatus = false;
  bool screenStatus = false;
  int time;
  int minutes;
  String now = DateFormat("dd-MM-yyyy hh:mm").format(DateTime.now());
  var zohr = '-', asar = '-', maghrib = '-';

  bool asarN = false, maghribN = false;
  String timeZoneName;
  var prayerTimes;
  var currentPrayerName;
  var nextPrayerName;
  var nextNamazTime;
  var currentNamazTime;
  var displayTime;

  int _selectedIndexfortrans = 0;
  int _selectedIndexfortafsir = 0;
  int _selectedIndexforfonts = 0;
  List<String> _screenList = [
    'Dashboard',
    'Prayers Screen',
    "Dua's Screen",
    'Quran Screen'
  ];

  List<String> recitersImg = [
    'assets/01.jpg',
    'assets/02.png',
    'assets/03.png',
    'assets/04.jpg',
    'assets/05.png',
    'assets/06.jpg',
    'assets/07.jpg',
    'assets/08.jpg',
    'assets/09.jpg',
    'assets/10.jpg',
    'assets/11.jpg',
    'assets/12.jpg',
    'assets/13.jpg',
    'assets/14.jpg',
    'assets/15.jpg',
  ];

  List<String> recitersNickName = [
    'bsfr',
    'a_ahmed',
    'jamal',
    'earawi',
    'jbreen',
    'khan',
    'minsh_mjwd',
    'mohsin_harthi',
    'khan',
    'rami',
    'bsfr',
    'minsh_mjwd',
    'mohsin_harthi',
    'khan',
    'rami',
  ];

  List<String> reciters = [
    'Abdullah Awad al-Juhani',
    'Abdullah Basfar',
    'Abdur-Rahman as-Sudais',
    'Abdur-Rashid Sufi',
    'Abdullah Khayat',
    'Bandar Baleela',
    'Mishari Rashid al-`Afasy',
    'Muhammad Sulaiman Patel',
    'Mustafa al-`Azawi',
    'Mahmood Ali Al-Bana',
    'Sahl Yasin',
    'Sa`ud ash-Shuraym',
    "Tawfeeq ibn Sa`id as-Sawa'igh",
    'Wadee Hammadi Al Yamani',
    'Yasser ad-Dussary',
  ];

  String _selectedScreen;

  _onSelectedfortrans(int index) {
    setState(() => _selectedIndexfortrans = index);
  }

  _onSelectedfortafsir(int index) {
    setState(() => _selectedIndexfortafsir = index);
  }

  _onSelectedforfonts(int index) {
    setState(() => _selectedIndexforfonts = index);
  }

  final location = new Location();
  String locationError;
  // PrayerTimes prayerTimes;

  @override
  void initState() {
    getLocationData().then((locationData) {
      if (!mounted) {
        return;
      }
      if (locationData != null) {
        setState(() {
          prayerTimes = PrayerTimes(
              Coordinates(locationData.latitude, locationData.longitude),
              DateComponents.from(DateTime.now()),
              CalculationMethod.karachi.getParameters());
        });
      } else {
        setState(() {
          locationError = "Couldn't Get Your Location!";
        });
      }
    });

    makeSharedPreferenceInstance();
    prayerTimeCalculation();
    getMyFont();
    super.initState();
  }

  Future<LocationData> getLocationData() async {
    var _serviceEnabled = await location.serviceEnabled();
    if (!_serviceEnabled) {
      _serviceEnabled = await location.requestService();
      if (!_serviceEnabled) {
        return null;
      }
    }

    var _permissionGranted = await location.hasPermission();
    if (_permissionGranted == PermissionStatus.denied) {
      _permissionGranted = await location.requestPermission();
      if (_permissionGranted != PermissionStatus.granted) {
        return null;
      }
    }

    return await location.getLocation();
  }

  makeSharedPreferenceInstance() async {
    Helper.prefs = await SharedPreferences.getInstance();
    setState(() {
      print(minutes);
      print(Helper.updateCounter);
    });
    Helper.updateCounter = Helper.prefs.getInt('counter');
    print("sdcsdc = " + Helper.updateCounter.toString());

    int time = Helper.updateCounter;

    minutes = (time / 60).truncate();
  }

  getTime() {
    Helper.second = 0;
    Helper.countTime = Timer.periodic(Duration(seconds: 1), (time) {
      Helper.second++;
      setState(() {});
    });
  }

  // Future prayerTimeCalculation() async {
  //   var _coordinates = await determinePosition();
  //   final myCoordinates =
  //       Coordinates(_coordinates.latitude, _coordinates.longitude);
  //   final params = CalculationMethod.karachi.getParameters();
  //   params.madhab = Madhab.hanafi;
  //   prayerTimes = PrayerTimes.today(myCoordinates, params);
  //   timeZoneName = prayerTimes.fajr.timeZoneName;
  //   zohr = DateFormat.jm().format(prayerTimes.dhuhr);
  //   asar = DateFormat.jm().format(prayerTimes.asr);
  //   maghrib = DateFormat.jm().format(prayerTimes.maghrib);

  //   var cName = prayerTimes.currentPrayer();
  //   var nName = prayerTimes.nextPrayer();
  //   var nextPrayerTime = prayerTimes.timeForPrayer(nName);

  //   var str = cName.toString();
  //   var str1 = nName.toString();
  //   var parts = str.split('.');
  //   var parts1 = str1.split('.');
  //   currentPrayerName = parts[1].toUpperCase().trim();
  //   nextPrayerName = parts1[1].toUpperCase().trim();
  //   nextNamazTime = DateFormat.jm().format(nextPrayerTime);

  //   // print("Current Prayer Name = " + currentPrayerName.toString());
  //   // print("Next Prayer Name = " + nextPrayerName.toString());
  //   // print("Next Prayer Time = " + nextNamazTime.toString());

  //   setState(() {});
  // }

  var fajr = '-',
      sunrise = '-',
      // zohr = '-',
      // asar = '-',
      // maghrib = '-',
      isha = '-';

  bool fajrN = false,
      sunriseN = false,
      zohrN = false,
      // asarN = false,
      // maghribN = false,
      ishaN = false;

  bool fajrSelected = false,
      sunriseSelected = false,
      zohrSelected = false,
      asarSelected = false,
      maghribSelected = false,
      ishaSelected = false;

  // String timeZoneName;
  // var prayerTimes;
  // var currentAddress;
  // LocationData currentLocation;

  Future prayerTimeCalculation() async {
    var _coordinates = await determinePosition();
    final myCoordinates =
        Coordinates(_coordinates.latitude, _coordinates.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    prayerTimes = PrayerTimes.today(myCoordinates, params);
    timeZoneName = prayerTimes.fajr.timeZoneName;
    fajr = DateFormat.jm().format(prayerTimes.fajr);
    sunrise = DateFormat.jm().format(prayerTimes.sunrise);
    zohr = DateFormat.jm().format(prayerTimes.dhuhr);
    asar = DateFormat.jm().format(prayerTimes.asr);
    maghrib = DateFormat.jm().format(prayerTimes.maghrib);
    isha = DateFormat.jm().format(prayerTimes.isha);

    var cName = prayerTimes.currentPrayer();
    var nName = prayerTimes.nextPrayer();
    var nextPrayerTime = prayerTimes.timeForPrayer(nName);
    var currentPrayerTime = prayerTimes.timeForPrayer(cName);

    var str = cName.toString();
    var str1 = nName.toString();
    var parts = str.split('.');
    var parts1 = str1.split('.');
    currentPrayerName = parts[1].toUpperCase().trim();
    nextPrayerName = parts1[1].toUpperCase().trim();
    // currentPrayerName = currentPrayer();
    // nextPrayerName = nextPrayer();
    nextNamazTime = DateFormat.jm().format(nextPrayerTime);
    // currentNamazTime = DateFormat.jm().format(currentPrayerTime);

    displayTime = nextNamazTime;
    // .difference(DateTime.parse(currentNamazTime))
    // .inDays;
    setState(() {});
    // print("display time -> $displayTime");
    print("current -> $cName next --> $nextNamazTime");
    // print("Current Prayer -> ${currentPrayer()}");
    // print("Next Prayer -> ${nextPrayer()}");
  }

  Prayer currentPrayer() {
    return currentPrayerByDateTime(DateTime.now());
  }

  Prayer currentPrayerByDateTime(DateTime time) {
    final when = time.millisecondsSinceEpoch;
    if (prayerTimes.isha.millisecondsSinceEpoch - when <= 0) {
      return Prayer.isha;
    } else if (prayerTimes.maghrib.millisecondsSinceEpoch - when <= 0) {
      return Prayer.maghrib;
    } else if (prayerTimes.asr.millisecondsSinceEpoch - when <= 0) {
      return Prayer.asr;
    } else if (prayerTimes.dhuhr.millisecondsSinceEpoch - when <= 0) {
      return Prayer.dhuhr;
    } else if (prayerTimes.sunrise.millisecondsSinceEpoch - when <= 0) {
      return Prayer.sunrise;
    } else if (prayerTimes.fajr.millisecondsSinceEpoch - when <= 0) {
      return Prayer.fajr;
    } else {
      return Prayer.none;
    }
  }

  Prayer nextPrayer() {
    return nextPrayerByDateTime(DateTime.now());
  }

  Prayer nextPrayerByDateTime(DateTime time) {
    final when = time.millisecondsSinceEpoch;
    if (prayerTimes.isha.millisecondsSinceEpoch - when <= 0) {
      return Prayer.none;
    } else if (prayerTimes.maghrib.millisecondsSinceEpoch - when <= 0) {
      return Prayer.isha;
    } else if (prayerTimes.asr.millisecondsSinceEpoch - when <= 0) {
      return Prayer.maghrib;
    } else if (prayerTimes.dhuhr.millisecondsSinceEpoch - when <= 0) {
      return Prayer.asr;
    } else if (prayerTimes.sunrise.millisecondsSinceEpoch - when <= 0) {
      return Prayer.dhuhr;
    } else if (prayerTimes.fajr.millisecondsSinceEpoch - when <= 0) {
      return Prayer.sunrise;
    } else {
      return Prayer.fajr;
    }
  }

  // Future prayerTimeCalculation() async {
  //   var _coordinates = await determinePosition();
  //   final myCoordinates =
  //       Coordinates(_coordinates.latitude, _coordinates.longitude);
  //   final params = CalculationMethod.karachi.getParameters();
  //   params.madhab = Madhab.hanafi;
  //   prayerTimes = PrayerTimes.today(myCoordinates, params);
  //   timeZoneName = prayerTimes.fajr.timeZoneName;
  //   zohr = DateFormat.jm().format(prayerTimes.dhuhr);
  //   asar = DateFormat.jm().format(prayerTimes.asr);
  //   maghrib = DateFormat.jm().format(prayerTimes.maghrib);

  //   var cName = prayerTimes.currentPrayer();
  //   var nName = prayerTimes.nextPrayer();
  //   var nextPrayerTime = prayerTimes.timeForPrayer(nName);

  //   var str = cName.toString();
  //   var str1 = nName.toString();
  //   var parts = str.split('.');
  //   var parts1 = str1.split('.');
  //   currentPrayerName = parts[1].toUpperCase().trim();
  //   nextPrayerName = parts1[1].toUpperCase().trim();
  //   nextNamazTime = DateFormat.jm().format(nextPrayerTime);

  //   // print("Current Prayer Name = " + currentPrayerName.toString());
  //   // print("Next Prayer Name = " + nextPrayerName.toString());
  //   // print("Next Prayer Time = " + nextNamazTime.toString());

  //   setState(() {});
  // }

  // Future getUserLocation() async {
  //   LocationData myLocation;
  //   String error;
  //   Location location = new Location();
  //   try {
  //     myLocation = await location.getLocation();
  //   } on PlatformException catch (e) {
  //     if (e.code == 'PERMISSION_DENIED') {
  //       error = 'please grant permission';
  //       print(error);
  //     }
  //     if (e.code == 'PERMISSION_DENIED_NEVER_ASK') {
  //       error = 'permission denied- please enable it from app settings';
  //       print(error);
  //     }
  //     myLocation = null;
  //   }
  //   currentLocation = myLocation;
  //   final coordinates =
  //       new GC.Coordinates(myLocation.latitude, myLocation.longitude);
  //   var addresses =
  //       await GC.Geocoder.local.findAddressesFromCoordinates(coordinates);
  //   var first = addresses.first;
  //   print('${first.locality}, ${first.adminArea}');
  //   currentAddress = '${first.locality} ${first.adminArea}';
  //   //print("currentAddress = "+ currentAddress.toString());
  //   //return first;
  // }

/*

  Future currentPrayerTimeCalculation() async {
    var _coordinates = await determinePosition();
    final myCoordinates =
    Coordinates(_coordinates.latitude, _coordinates.longitude);
    final params = CalculationMethod.karachi.getParameters();
    params.madhab = Madhab.hanafi;
    DateTime date = new DateTime(2015, 11, 1);
    prayerTimes = PrayerTimes.today(myCoordinates, params);
    timeZoneName = prayerTimes.fajr.timeZoneName;

    //prayerTimes = new PrayerTimes(myCoordinates,CalendarUtil., params);



  }

*/

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    prayerTimeCalculation();
    SizeConfig sizeConfig = SizeConfig();
    sizeConfig.init(context);
    BoxDecoration boxDecoration = BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
      boxShadow: [
        BoxShadow(
          color: Colors.grey.withOpacity(0.5),
          spreadRadius: 1,
          blurRadius: 10,
          offset: Offset(0, 2), // changes position of shadow
        ),
      ],
    );
    print("Build");
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Container(
          decoration: _isDarkMode
              ? BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/background.png'),
                    fit: BoxFit.cover,
                  ),
                )
              : BoxDecoration(color: Colors.black),

          // decoration: BoxDecoration(
          //
          //
          //     // image: Get.theme.brightness.toString() == 'Brightness.light'
          //     //     ? DecorationImage(
          //     //         image: AssetImage(
          //     //           "assets/background.png",
          //     //         ),
          //     //         // colorFilter:     ColorFilter.mode( Color(0xff30F2C9),BlendMode.)
          //     //
          //     //         // colorFilter: ColorFilter.mode(Color(0xff30F2C9), null),
          //     //
          //     //         // fit:BoxFit.fill,
          //     //       )
          //     //     : DecorationImage(
          //     //         image: AssetImage(
          //     //           "assets/lavender.png",
          //     //         ),
          //     //       )
          // ),
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height * 0.30,
                    child: Stack(
                      clipBehavior: Clip.none,
                      children: [
                        Container(
                            height: double.infinity,
                            width: double.infinity,
                            child: Image.asset(
                              "assets/dashboardImage.png",
                              fit: BoxFit.cover,
                            )),
                        Container(
                          padding: kDefaultPadding,
                          color: AppColors.greenColors.withOpacity(.3),
                          height: double.infinity,
                          width: double.infinity,
                          child: Container(
                            padding: kDefaultPadding,
                            // height: double.infinity,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                SizedBox(height: 15),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        _key.currentState.openDrawer();
                                      },
                                      child: Image.asset(
                                        "assets/menuIcon.png",
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                                // SizedBox(height: 10),
                                Text(
                                  "Iftar start in 16min 60s",
                                  style: kBodyStyle.copyWith(
                                    color: Colors.white.withOpacity(0.8),
                                  ),
                                ),
                                SizedBox(
                                  height: kDefaultSpacing,
                                ),
                                Text(
                                    "${nextPrayerName != null ? nextPrayerName : 'Fajar'}",
                                    style: kTitleStyle.copyWith(
                                      fontSize: 20,
                                      color: Colors.white,
                                    )),
                                SizedBox(
                                  height: 2,
                                ),
                                Text(
                                    "${nextNamazTime != null ? nextNamazTime : '00:00 PM'}" /*"${asar != null ? asar : 'Enable Location'}"*/,
                                    style: kBodyStyle.copyWith(
                                      color: Colors.white,
                                    )),
                                // SizedBox(height: kSmallSpacing),
                                // SizedBox(height: kSmallSpacing),
                                // SizedBox(height: kSmallSpacing),
                                SizedBox(height: kSmallSpacing),
                                SizedBox(height: kSmallSpacing),
                                SizedBox(height: kSmallSpacing),
                                Text(
                                    "${currentPrayerName != null ? "$currentPrayerName ends in" : ''}",
                                    style: kTitleStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                    )),
                                // Text("Now",
                                //     style: kTitleStyle.copyWith(
                                //       fontSize: 12,
                                //       fontStyle: FontStyle.normal,
                                //       color: Colors.white,
                                //     )),
                                Text(
                                    "${displayTime != null ? displayTime : ''}",
                                    style: kTitleStyle.copyWith(
                                      fontSize: 16,
                                      color: Colors.white,
                                    )),
                                // Text("Upcoming",
                                //     style: kTitleStyle.copyWith(
                                //         fontSize: 12,
                                //         fontStyle: FontStyle.normal,
                                //         color: Colors.white,
                                //         fontFamily:
                                //             'KFGQPC Uthmanic Script HAFS Regular')),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          // left: 20,
                          // right: 20,
                          bottom: getScreenHeight(-30),
                          child: Container(
                            margin: EdgeInsets.symmetric(
                                horizontal:
                                    MediaQuery.of(context).size.width * 0.03),
                            height: getScreenHeight(60),
                            decoration: kDefaultBoxShadow,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.47,
                                  // padding:
                                  //     EdgeInsets.symmetric(vertical: 20),
                                  //"1 Ramadan 1442 AH"
                                  child: Center(
                                    child: Text(
                                      '${HijriCalendar.now().toFormat("MMMM dd yyyy")}',
                                      style: kBodyStyle.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                                Container(
                                  width: 1,
                                  height: getScreenHeight(70),
                                  color: AppColors.greenColors.withOpacity(0.7),
                                  child: Container(),
                                ),
                                Container(
                                  width:
                                      MediaQuery.of(context).size.width * 0.45,
                                  child: Center(
                                    child: Text(
                                      now.substring(0, 10),
                                      style: kBodyStyle.copyWith(
                                        color: kPrimaryColor,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  // Positioned(
                  //   right: 15,
                  //   top: 35,
                  //   child: Builder(builder: (context) {
                  //     return InkWell(
                  //       onTap: () {
                  //         Scaffold.of(context).openDrawer();
                  //       },
                  //       child: Icon(
                  //         Icons.menu,
                  //         size: 25,
                  //         color: Colors.white,
                  //       ),
                  //     );
                  //   }),
                  // ),
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.04,
              ),
              Expanded(
                child: Container(
                  child: ListView(
                    children: [
                      // SizedBox(
                      //   height: 40,
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getScreenWidth(12),
                            vertical: getScreenHeight(20)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
//                            TopCard(
//                             title: 'Audio Player',
//                             image: 'assets/quranicon.png',
//                             scale: 6,
//                             onTap: () {
//                               getTime();
//                               Navigator.push(
//                                   context,
//                                   MaterialPageRoute(
//                                     builder: (context) => MyAudioPlayer(),
//                                   ));
// //                              goToSecondScreen(context);
//                             },
//                           ),
//                           SizedBox(
//                             width: 15,
//                           ),
                              TopCard(
                                title: 'Quran Majeed',
                                image: 'assets/quranicon.png',
                                scale: 5.4,
                                onTap: () {
                                  getTime();
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => QuranHomeScreen(),
                                      ));
//                              goToSecondScreen(context);
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TopCard(
                                title: 'Makkah Live',
                                image: 'assets/qiblaImage.png',
                                scale: 2.8,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MakkahLiveScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TopCard(
                                title: 'Madina Live',
                                image: 'assets/madinaImage.png',
                                scale: 2.5,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return MadinahLiveScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TopCard(
                                title: 'Duas',
                                image: 'assets/duaImage.png',
                                scale: 2.6,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DuaCategoriesScreen()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      // SizedBox(
                      //   height: 8,
                      // ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal: getScreenWidth(12),
                            vertical: getScreenHeight(20)),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              TopCard(
                                title: 'Prayer Time',
                                image: 'assets/prayerTimeImage.png',
                                scale: 2.6,
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) {
                                    return PrayerTimeMainScreen();
                                  }));
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TopCard(
                                title: 'Qibla Compass',
                                image: 'assets/qiblaDirection.png',
                                scale: 2.8,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return QiblaCompassScreen();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              TopCard(
                                title: 'Visual Quran',
                                image: 'assets/visualQuran1.png',
                                scale: 3,
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) {
                                        return VisualQuran();
                                      },
                                    ),
                                  );
                                },
                              ),
                              SizedBox(
                                width: 15,
                              ),
                              TopCard(
                                title: 'Messages',
                                image: 'assets/message.png',
                                scale: 2.6,
                                onTap: () {
                                  // var url = "https://perfectholyquran.blogspot.com";
                                  // Navigator.push(context, MaterialPageRoute(builder: (context) => WebpagesScreen(url: url, title: "Daily Messages",)));
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              MessagesScreen()));
                                },
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 20.0),
                        child: Text(
                          "Quran Engagement Time",
                          style: TextStyle(
                              color: _isDarkMode
                                  ? AppColors.greenColors
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.04),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            // SizedBox(
                            //   width: 15,
                            // ),
                            Container(
                              width: MediaQuery.of(context).size.width * 0.44,
                              height: getScreenHeight(200),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                                boxShadow: [
                                  BoxShadow(
                                    color: Colors.grey.withOpacity(0.5),
                                    spreadRadius: 1,
                                    blurRadius: 10,
                                    offset: Offset(
                                        0, 3), // changes position of shadow
                                  ),
                                ],
                              ),
                              padding: EdgeInsets.symmetric(vertical: 20),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  // SizedBox(
                                  //   height: 10,
                                  // ),
                                  Text(
                                    "Your this week",
                                    style: TextStyle(
                                      color: AppColors.greenColors,
                                      fontSize: getScreenHeight(14),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Expanded(
                                    child: SizedBox(
                                      height: 120,
                                      width: 120,
                                      child: Container(
                                          height: 200,
                                          child: SfRadialGauge(
                                            axes: <RadialAxis>[
                                              RadialAxis(
                                                  showLabels: false,
                                                  showTicks: false,
                                                  startAngle: 270,
                                                  endAngle: 270,
                                                  minimum: 0,
                                                  maximum: 100,
                                                  radiusFactor:
                                                      getScreenWidth(0.8),
                                                  axisLineStyle: AxisLineStyle(
                                                      color: AppColors
                                                          .greenColors
                                                          .withOpacity(.6),
                                                      thicknessUnit:
                                                          GaugeSizeUnit.factor,
                                                      thickness: 0.2),
                                                  centerX: .5,
                                                  centerY: .5,
                                                  annotations: <
                                                      GaugeAnnotation>[
                                                    GaugeAnnotation(
                                                        angle: 0,
                                                        widget: Column(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .center,
                                                          children: [
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                "${minutes != null ? minutes : 0}m",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .greenColors,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      getScreenHeight(
                                                                          13),
                                                                ),
                                                              ),
                                                            ),
                                                            Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                          .only(
                                                                      left:
                                                                          8.0),
                                                              child: Text(
                                                                "on Quran",
                                                                style:
                                                                    TextStyle(
                                                                  color: AppColors
                                                                      .greenColors,
                                                                  fontWeight:
                                                                      FontWeight
                                                                          .bold,
                                                                  fontSize:
                                                                      getScreenHeight(
                                                                          10),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        )),
                                                  ],
                                                  pointers: <GaugePointer>[
                                                    RangePointer(
                                                        value: 70.0,
                                                        cornerStyle: CornerStyle
                                                            .bothCurve,
                                                        enableAnimation: true,
                                                        animationDuration: 1200,
                                                        animationType:
                                                            AnimationType.ease,
                                                        sizeUnit: GaugeSizeUnit
                                                            .factor,
                                                        color: Colors.green,
                                                        width: 0.2),
                                                  ]),
                                            ],
                                          )),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 15,
                                  // ),
                                  Text(
                                    "Lifetime: 1d 16hr 37m",
                                    style: TextStyle(
                                      color: AppColors.greenColors,
                                      fontSize: getScreenHeight(12),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  // SizedBox(
                                  //   height: 5,
                                  // ),
                                  Text(
                                    "Since $now",
                                    style: TextStyle(
                                        color: AppColors.greenColors,
                                        fontSize: getScreenHeight(10)),
                                  ),
                                ],
                              ),
                            ),
                            // SizedBox(
                            //   width: 20,
                            // ),
                            InkWell(
                              onTap: () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => SadqaScreen()));
                              },
                              child: Container(
                                width: MediaQuery.of(context).size.width * 0.44,
                                height: getScreenHeight(200),
                                padding: EdgeInsets.symmetric(vertical: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 1,
                                      blurRadius: 10,
                                      offset: Offset(
                                          0, 3), // changes position of shadow
                                    ),
                                  ],
                                ),
                                child: Column(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    // SizedBox(
                                    //   height: 9,
                                    // ),
                                    Text(
                                      "Sadqa Jaria Gift Pool",
                                      style: TextStyle(
                                        color: AppColors.greenColors,
                                        fontSize: getScreenHeight(14),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    Expanded(
                                      flex: 2,
                                      child: SizedBox(
                                        height: 90,
                                        width: 90,
                                        child: Image.asset(
                                          "assets/sadqicon.PNG",
                                          fit: BoxFit.contain,
                                        ),
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                    Text(
                                      "0 Quran Copies gifted",
                                      style: TextStyle(
                                        color: AppColors.greenColors,
                                        fontSize: 12,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    // SizedBox(
                                    //   height: 15,
                                    // ),
                                  ],
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: 15,
                            // ),
                          ],
                        ),
                      ),

                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20.0, vertical: 15),
                        child: Text(
                          "Quran Wallpapers",
                          style: TextStyle(
                              color: _isDarkMode
                                  ? AppColors.greenColors
                                  : Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                      // SizedBox(
                      //   height: 10,
                      // ),
                      Container(
                        height: 220,
                        child: ListView.builder(
                            itemCount: ayatwallpapers.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return AyatList(
                                ayatwallpapers: ayatwallpapers[index],
                              );
                            }),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 18.0),
                        child: Text(
                          "Reciters",
                          style: TextStyle(
                            color: _isDarkMode
                                ? AppColors.greenColors
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        height: getScreenHeight(100),
                        child: ListView.builder(
                            // shrinkWrap: true,
                            padding: EdgeInsets.only(left: 15),
                            itemCount: recitersImg.length,
                            scrollDirection: Axis.horizontal,
                            itemBuilder: (context, index) {
                              return InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              ReciterSurahList(
                                                  recitersNickName[index],
                                                  reciters[index])));
                                },
                                child: Column(
                                  children: [
                                    Expanded(
                                      child: ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(20.0),
                                        child: Container(
                                          // height: 80,
                                          // width: 80,
                                          child: Image(
                                            image:
                                                AssetImage(recitersImg[index]),
                                            fit: BoxFit.cover,
                                            height: 80,
                                            width: 80,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 5,
                                      ),
                                      width: 90,
                                      child: Text(
                                        reciters[index],
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        textAlign: TextAlign.center,
                                        style: TextStyle(
                                          fontSize: getScreenHeight(10),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            }),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      // RadioListTile(
                      //   title: Text('system'),
                      //   value: ThemeMode.system,
                      //   groupValue: _themeMode,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _themeMode = value;
                      //       Get.changeThemeMode(
                      //           _themeMode); //STEP 3 - change themes
                      //     });
                      //   },
                      // ),
                      // RadioListTile(
                      //   title: Text('dark'),
                      //   value: ThemeMode.dark,
                      //   groupValue: _themeMode,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _themeMode = value;
                      //       Get.changeThemeMode(_themeMode);
                      //     });
                      //   },
                      // ),
                      // RadioListTile(
                      //   title: Text('light'),
                      //   value: ThemeMode.light,
                      //   groupValue: _themeMode,
                      //   onChanged: (value) {
                      //     setState(() {
                      //       _themeMode = value;
                      //       Get.changeThemeMode(_themeMode);
                      //     });
                      //   },
                      // ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: InkWell(
                          onTap: () {
                            setState(() {
                              switchStatus = !switchStatus;
                            });
                          },
                          child: Container(
                            height: getScreenHeight(50),
                            alignment: Alignment.center,
                            child: Text(
                              'More Options',
                              style: TextStyle(
                                color: AppColors.greenColors,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ),
                      switchStatus != false
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Translation",
                                    style: TextStyle(
                                        color: AppColors.greenColors,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: getScreenHeight(80),
                                  child: ListView.builder(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 15),
                                      itemCount: 7,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () =>
                                              _onSelectedfortrans(index),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                              horizontal: getScreenWidth(8),
                                              vertical: getScreenHeight(12),
                                            ),
                                            child: Container(
                                              height: getScreenHeight(50),
                                              width: 80,
                                              decoration: BoxDecoration(
                                                color: _selectedIndexfortrans !=
                                                            null &&
                                                        _selectedIndexfortrans ==
                                                            index
                                                    ? AppColors.boxColors
                                                    : Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.5),
                                                    spreadRadius: 1,
                                                    blurRadius: 10,
                                                    offset: Offset(0,
                                                        3), // changes position of shadow
                                                  ),
                                                ],
                                              ),
                                              child: Center(
                                                child: Text(
                                                  'English',
                                                  maxLines: 1,
                                                  overflow:
                                                      TextOverflow.ellipsis,
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize:
                                                        getScreenHeight(15),
                                                    color: _selectedIndexfortrans !=
                                                                null &&
                                                            _selectedIndexfortrans ==
                                                                index
                                                        ? Colors.white
                                                        : AppColors.greenColors,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Tafsirs",
                                    style: TextStyle(
                                        color: AppColors.greenColors,
                                        fontSize: 18,
                                        fontWeight: FontWeight.w700),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Container(
                                  height: getScreenHeight(100),
                                  child: ListView.builder(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 15.0),
                                      itemCount: 7,
                                      scrollDirection: Axis.horizontal,
                                      itemBuilder: (context, index) {
                                        return InkWell(
                                          onTap: () =>
                                              _onSelectedfortafsir(index),
                                          child: Padding(
                                            padding: EdgeInsets.symmetric(
                                                horizontal: getScreenWidth(8),
                                                vertical: getScreenHeight(12)),
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(60),
                                              child: Container(
                                                height: getScreenHeight(70),
                                                width: getScreenWidth(70),
                                                decoration: BoxDecoration(
                                                  color: _selectedIndexfortafsir !=
                                                              null &&
                                                          _selectedIndexfortafsir ==
                                                              index
                                                      ? AppColors.boxColors
                                                      : Colors.white,
                                                  // borderRadius:
                                                  //     BorderRadius.circular(60),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color: Colors.grey
                                                          .withOpacity(0.2),
                                                      spreadRadius: 2,
                                                      blurRadius: 2,
                                                      offset: Offset(10,
                                                          15), // changes position of shadow
                                                    ),
                                                  ],
                                                ),
                                                child: Center(
                                                  child: Text(
                                                    'Urdhu\nUsmani',
                                                    maxLines: 2,
                                                    //                                              overflow: TextOverflow.ellipsis,
                                                    textAlign: TextAlign.center,
                                                    style: TextStyle(
                                                      fontSize:
                                                          getScreenHeight(13),
                                                      color: _selectedIndexfortafsir !=
                                                                  null &&
                                                              _selectedIndexfortafsir ==
                                                                  index
                                                          ? Colors.white
                                                          : AppColors
                                                              .greenColors,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      }),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text("Quran Fonts",
                                      style: TextStyle(
                                          color: AppColors.greenColors,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w700)),
                                ),

                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Container(
                                //   height: getScreenHeight(70),
                                //   child: ListView.builder(
                                //       itemCount: 7,
                                //       padding:
                                //           EdgeInsets.symmetric(horizontal: 15.0),
                                //       scrollDirection: Axis.horizontal,
                                //       itemBuilder: (context, index) {
                                //         return InkWell(
                                //           onTap: () => _onSelectedforfonts(index),
                                //           child: Padding(
                                //             padding: const EdgeInsets.symmetric(
                                //                 horizontal: 8),
                                //             child: ClipRRect(
                                //               borderRadius:
                                //                   BorderRadius.circular(90),
                                //               child: Container(
                                //                 height: getScreenHeight(70),
                                //                 width: 70,
                                //                 decoration: BoxDecoration(
                                //                   color: _selectedIndexforfonts !=
                                //                               null &&
                                //                           _selectedIndexforfonts ==
                                //                               index
                                //                       ? AppColors.boxColors
                                //                       : Colors.white,
                                //                   boxShadow: [
                                //                     BoxShadow(
                                //                       color: Colors.grey
                                //                           .withOpacity(0.2),
                                //                       spreadRadius: 2,
                                //                       blurRadius: 2,
                                //                       offset: Offset(10,
                                //                           15), // changes position of shadow
                                //                     ),
                                //                   ],
                                //                 ),
                                //                 child: Center(
                                //                   child: Text('بِسْمِ',
                                //                       maxLines: 1,
                                //                       //                                              overflow: TextOverflow.ellipsis,
                                //                       textAlign: TextAlign.center,
                                //                       style: fonts[index](
                                //                         color:
                                //                             _selectedFontIndex ==
                                //                                     index
                                //                                 ? Colors.white
                                //                                 : AppColors
                                //                                     .boxColors,
                                //                         fontSize: 20.0,
                                //                       )),
                                //                 ),
                                //               ),
                                //             ),
                                //           ),
                                //         );
                                //       }),
                                // ),

                                // SizedBox(
                                //   height: 30,
                                // ),
//                               Padding(
//                                 padding:
//                                     const EdgeInsets.symmetric(horizontal: 10),
//                                 child: Row(
// //                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                                   children: [
//                                     Row(
//                                       children: [
//                                         Padding(
//                                           padding:
//                                               const EdgeInsets.only(left: 20.0),
//                                           child: Text(
//                                             "15 Lines",
//                                             style: TextStyle(
//                                                 color: AppColors.greenColors,
//                                                 fontSize: 10),
//                                           ),
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         FlutterSwitch(
//                                           activeToggleColor: Colors.white,
//                                           activeColor: Color(0xff5FBEAA),
//                                           activeSwitchBorder: Border.all(
//                                             color: Color(0xff5FBEAA),
//                                           ),
//                                           inactiveSwitchBorder:
//                                               Border.all(color: Colors.grey),
//                                           width: 28.0,
//                                           height: 15.0,
//                                           toggleSize: 20.0,
//                                           borderRadius: 20.0,
//                                           value: lineStatus,
//                                           showOnOff: false,
//                                           padding: 0,
//                                           onToggle: (value) {
//                                             setState(() {
//                                               lineStatus = value;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Side Mark",
//                                           style: TextStyle(
//                                               color: AppColors.greenColors,
//                                               fontSize: 10),
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         FlutterSwitch(
//                                           activeToggleColor: Colors.white,
//                                           activeColor: Color(0xff5FBEAA),
//                                           activeSwitchBorder: Border.all(
//                                             color: Color(0xff5FBEAA),
//                                           ),
//                                           inactiveSwitchBorder:
//                                               Border.all(color: Colors.grey),
//                                           width: 28.0,
//                                           height: 15.0,
//                                           toggleSize: 20.0,
//                                           borderRadius: 25.0,
//                                           value: sideStatus,
//                                           showOnOff: false,
//                                           padding: 0,
//                                           onToggle: (value) {
//                                             setState(() {
//                                               sideStatus = value;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                     SizedBox(
//                                       width: 10,
//                                     ),
//                                     Row(
//                                       children: [
//                                         Text(
//                                           "Screen Timeout",
//                                           style: TextStyle(
//                                               color: AppColors.greenColors,
//                                               fontSize: 10),
//                                         ),
//                                         SizedBox(
//                                           width: 10,
//                                         ),
//                                         FlutterSwitch(
//                                           activeToggleColor: Colors.white,
//                                           activeColor: Color(0xff5FBEAA),
//                                           activeSwitchBorder: Border.all(
//                                             color: Color(0xff5FBEAA),
//                                           ),
//                                           inactiveSwitchBorder:
//                                               Border.all(color: Colors.grey),
//                                           width: 28.0,
//                                           height: 15.0,
//                                           toggleSize: 20.0,
//                                           borderRadius: 25.0,
//                                           value: screenStatus,
//                                           showOnOff: false,
//                                           padding: 0,
//                                           onToggle: (value) {
//                                             setState(() {
//                                               screenStatus = value;
//                                             });
//                                           },
//                                         ),
//                                       ],
//                                     ),
//                                   ],
//                                 ),
//                               ),

                                // SizedBox(
                                //   height: 30,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 20.0),
                                //   child: Text(
                                //     "Theme",
                                //     style: TextStyle(
                                //         color: AppColors.greenColors,
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 10,
                                // ),
                                // Container(
                                //   height: getScreenHeight(60),
                                //   color: Colors.yellow,
                                //   child: SingleChildScrollView(child: Row(
                                //     children: [
                                //       InkWell(
                                //         onTap: () {},
                                //         //_onSelected(index),
                                //         child: Padding(
                                //           padding: const EdgeInsets.symmetric(
                                //               horizontal: 8),
                                //           child: Container(
                                //             height: getScreenHeight(40),
                                //             width: 70,
                                //             decoration: BoxDecoration(
                                //               // color: _selectedIndex != null &&
                                //               //         _selectedIndex == index
                                //               //     ? AppColors.greenColors
                                //               //     : Colors.white,
                                //               borderRadius:
                                //               BorderRadius.circular(60),
                                //               boxShadow: [
                                //                 BoxShadow(
                                //                   color: Colors.grey
                                //                       .withOpacity(0.2),
                                //                   spreadRadius: 2,
                                //                   blurRadius: 2,
                                //                   offset: Offset(0,
                                //                       3), // changes position of shadow
                                //                 ),
                                //               ],
                                //             ),
                                //             child: Center(
                                //                 child: Icon(
                                //                   Icons.brightness_2,
                                //                   size: 30,
                                //                   // color: _selectedIndex != null &&
                                //                   //         _selectedIndex == index
                                //                   //     ? Colors.white
                                //                   //     : AppColors.greenColors,
                                //                 )),
                                //           ),
                                //         ),
                                //       )
                                //     ],
                                //   ))
                                //   // ListView.builder(
                                //   //     itemCount: 3,
                                //   //     scrollDirection: Axis.horizontal,
                                //   //     itemBuilder: (context, index) {
                                //   //       return InkWell(
                                //   //         onTap: () {},
                                //   //             //_onSelected(index),
                                //   //         child: Padding(
                                //   //           padding: const EdgeInsets.symmetric(
                                //   //               horizontal: 8),
                                //   //           child: Container(
                                //   //             height: getScreenHeight(40),
                                //   //             width: 70,
                                //   //             decoration: BoxDecoration(
                                //   //               // color: _selectedIndex != null &&
                                //   //               //         _selectedIndex == index
                                //   //               //     ? AppColors.greenColors
                                //   //               //     : Colors.white,
                                //   //               borderRadius:
                                //   //                   BorderRadius.circular(60),
                                //   //               boxShadow: [
                                //   //                 BoxShadow(
                                //   //                   color: Colors.grey
                                //   //                       .withOpacity(0.2),
                                //   //                   spreadRadius: 2,
                                //   //                   blurRadius: 2,
                                //   //                   offset: Offset(0,
                                //   //                       3), // changes position of shadow
                                //   //                 ),
                                //   //               ],
                                //   //             ),
                                //   //             child: Center(
                                //   //                 child: Icon(
                                //   //               Icons.brightness_2,
                                //   //               size: 30,
                                //   //               // color: _selectedIndex != null &&
                                //   //               //         _selectedIndex == index
                                //   //               //     ? Colors.white
                                //   //               //     : AppColors.greenColors,
                                //   //             )),
                                //   //           ),
                                //   //         ),
                                //   //       );
                                //   //     }),
                                // ),
                                // SizedBox(
                                //   height: 30,
                                // ),
                                // Padding(
                                //   padding: const EdgeInsets.only(left: 20.0),
                                //   child: Text(
                                //     "Landing Page",
                                //     style: TextStyle(
                                //         color: AppColors.greenColors,
                                //         fontSize: 18,
                                //         fontWeight: FontWeight.bold),
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 20,
                                // ),
                                // Padding(
                                //   padding:
                                //       const EdgeInsets.symmetric(horizontal: 20),
                                //   child: Row(
                                //     mainAxisAlignment:
                                //         MainAxisAlignment.spaceBetween,
                                //     children: [
                                //       Text(
                                //         "Select Page",
                                //         style: TextStyle(
                                //             color: AppColors.greenColors,
                                //             fontSize: 14,
                                //             fontWeight: FontWeight.bold),
                                //       ),
                                //       Container(
                                //         width: MediaQuery.of(context).size.width *
                                //             0.5,
                                //         height: 50,
                                //         padding:
                                //             EdgeInsets.symmetric(horizontal: 10),
                                //         decoration: BoxDecoration(
                                //           color: Colors.white,
                                //           borderRadius: BorderRadius.circular(10),
                                //           boxShadow: [
                                //             BoxShadow(
                                //               color: Colors.grey.withOpacity(0.5),
                                //               spreadRadius: 1,
                                //               blurRadius: 10,
                                //               offset: Offset(0,
                                //                   2), // changes position of shadow
                                //             ),
                                //           ],
                                //         ),
                                //         child: DropdownButton(
                                //           hint: Text('Select Page'),
                                //           // Not necessary for Option 1
                                //           value: _selectedScreen,
                                //           isExpanded: true,
                                //           onChanged: (newValue) {
                                //             setState(() {
                                //               _selectedScreen =
                                //                   newValue.toString();
                                //             });
                                //           },
                                //           items: _screenList.map((location) {
                                //             return DropdownMenuItem(
                                //               child: new Text(location),
                                //               value: location,
                                //             );
                                //           }).toList(),
                                //         ),
                                //       ),
                                //     ],
                                //   ),
                                // ),
                                // SizedBox(
                                //   height: 30,
                                // ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 20.0),
//                                child: Text(
//                                  "More Apps",
//                                  style: TextStyle(
//                                      color: AppColors.greenColors,
//                                      fontSize: 18,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              Container(
//                                height: getScreenHeight(70),
//                                child: ListView.builder(
//                                    itemCount: 7,
//                                    scrollDirection: Axis.horizontal,
//                                    itemBuilder: (context, index) {
//                                      return InkWell(
//                                        onTap: () => _onSelected(index),
//                                        child: Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              horizontal: 8),
//                                          child: Container(
//                                            height: getScreenHeight(50),
//                                            width: 100,
//                                            decoration: BoxDecoration(
//                                              color: _selectedIndex != null &&
//                                                      _selectedIndex == index
//                                                  ? AppColors.greenColors
//                                                  : Colors.white,
//                                              borderRadius:
//                                                  BorderRadius.circular(10),
//                                              boxShadow: [
//                                                BoxShadow(
//                                                  color: Colors.grey
//                                                      .withOpacity(0.2),
//                                                  spreadRadius: 2,
//                                                  blurRadius: 2,
//                                                  offset: Offset(0,
//                                                      3), // changes position of shadow
//                                                ),
//                                              ],
//                                            ),
////                                          child: Center(
////                                            child: Text(
////                                              'English',
////                                              maxLines: 1,
////                                              overflow: TextOverflow.ellipsis,
////                                              textAlign: TextAlign.center,
////                                              style: TextStyle(
////                                                fontSize: getScreenHeight(15),
////                                                color: _selectedIndex != null && _selectedIndex == index
////                                                    ? Colors.white
////                                                    : AppColors.greenColors,
////                                              ),
////                                            ),
////                                          ),
//                                          ),
//                                        ),
//                                      );
//                                    }),
//                              ),
//                              SizedBox(
//                                height: 30,
//                              ),
//                              Padding(
//                                padding: const EdgeInsets.only(left: 20.0),
//                                child: Text(
//                                  "General",
//                                  style: TextStyle(
//                                      color: AppColors.greenColors,
//                                      fontSize: 18,
//                                      fontWeight: FontWeight.bold),
//                                ),
//                              ),
//                              SizedBox(
//                                height: 10,
//                              ),
//                              Container(
//                                height: getScreenHeight(70),
//                                child: ListView.builder(
//                                    itemCount: 7,
//                                    scrollDirection: Axis.horizontal,
//                                    itemBuilder: (context, index) {
//                                      return InkWell(
//                                        onTap: () => _onSelected(index),
//                                        child: Padding(
//                                          padding: const EdgeInsets.symmetric(
//                                              horizontal: 8),
//                                          child: Container(
//                                            height: getScreenHeight(50),
//                                            width: 100,
//                                            decoration: BoxDecoration(
//                                              color: _selectedIndex != null &&
//                                                      _selectedIndex == index
//                                                  ? AppColors.greenColors
//                                                  : Colors.white,
//                                              borderRadius:
//                                                  BorderRadius.circular(10),
//                                              boxShadow: [
//                                                BoxShadow(
//                                                  color: Colors.grey
//                                                      .withOpacity(0.2),
//                                                  spreadRadius: 2,
//                                                  blurRadius: 2,
//                                                  offset: Offset(0,
//                                                      3), // changes position of shadow
//                                                ),
//                                              ],
//                                            ),
////                                          child: Center(
////                                            child: Text(
////                                              'English',
////                                              maxLines: 1,
////                                              overflow: TextOverflow.ellipsis,
////                                              textAlign: TextAlign.center,
////                                              style: TextStyle(
////                                                fontSize: getScreenHeight(15),
////                                                color: _selectedIndex != null && _selectedIndex == index
////                                                    ? Colors.white
////                                                    : AppColors.greenColors,
////                                              ),
////                                            ),
////                                          ),
//                                          ),
//                                        ),
//                                      );
//                                    }),
//                              ),

                                // new DropdownButton<String>(
                                //   value: _selectedFont,
                                //   underline: Container(
                                //     height: 2,
                                //     color: Colors.deepPurpleAccent,
                                //   ),
                                //   style: TextStyle(color: Colors.deepPurple),
                                //   icon: Icon(Icons.arrow_downward),
                                //   iconSize: 24,
                                //   elevation: 16,
                                //   items: fontName.map((String value) {
                                //     return new DropdownMenuItem<String>(
                                //       value: value,
                                //       child: new Text(value),
                                //     );
                                //   }).toList(),
                                //   onChanged: (newValue) {
                                //     setState(() {
                                //       myindex = fontName.indexOf(newValue);
                                //       _selectedFont = newValue;
                                //       print(_selectedFont);
                                //       print(myindex);
                                //       saveMyFont(myindex);
                                //     });
                                //   },
                                // ),
                                SizedBox(
                                  height: 20,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Row(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                    children: [
                                      SizedBox(
                                        width: 20,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedFontIndex = 0;
                                            myindex = 0;
                                            saveMyFont(myindex);
                                          });
                                        },
                                        child: Container(
                                            height: getScreenHeight(70),
                                            width: getScreenWidth(70),
                                            decoration: BoxDecoration(
                                              color: _selectedFontIndex == 0
                                                  ? AppColors.boxColors
                                                  : Colors.white,
                                              borderRadius:
                                                  BorderRadius.circular(50),
                                              border: Border.all(
                                                width: 1,
                                                color: _selectedFontIndex == 0
                                                    ? Colors.white
                                                    : AppColors.boxColors,
                                              ),
                                            ),
                                            child: Center(
                                                child: Text(
                                              'بِسْمِ',
                                              style: fonts[0](
                                                color: _selectedFontIndex == 0
                                                    ? Colors.white
                                                    : AppColors.boxColors,
                                                fontSize: 20.0,
                                              ),
                                              textAlign: TextAlign.center,
                                            ))),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedFontIndex = 1;
                                            myindex = 1;
                                            saveMyFont(myindex);
                                          });
                                        },
                                        child: Container(
                                          height: getScreenHeight(70),
                                          width: getScreenWidth(70),
                                          decoration: BoxDecoration(
                                            color: _selectedFontIndex == 1
                                                ? AppColors.boxColors
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              width: 1,
                                              color: _selectedFontIndex == 1
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'بِسْمِ',
                                            style: fonts[1](
                                              color: _selectedFontIndex == 1
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedFontIndex = 2;
                                            myindex = 2;
                                            saveMyFont(myindex);
                                          });
                                        },
                                        child: Container(
                                          height: getScreenHeight(70),
                                          width: getScreenWidth(70),
                                          decoration: BoxDecoration(
                                            color: _selectedFontIndex == 2
                                                ? AppColors.boxColors
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              width: 1,
                                              color: _selectedFontIndex == 2
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'بِسْمِ',
                                            style: fonts[2](
                                              color: _selectedFontIndex == 2
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedFontIndex = 3;
                                            myindex = 3;
                                            saveMyFont(myindex);
                                          });
                                        },
                                        child: Container(
                                          height: getScreenHeight(70),
                                          width: getScreenWidth(70),
                                          decoration: BoxDecoration(
                                            color: _selectedFontIndex == 3
                                                ? AppColors.boxColors
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              width: 1,
                                              color: _selectedFontIndex == 3
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'بِسْمِ',
                                            style: fonts[3](
                                              color: _selectedFontIndex == 3
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      GestureDetector(
                                        onTap: () {
                                          setState(() {
                                            _selectedFontIndex = 4;
                                            myindex = 4;
                                            saveMyFont(myindex);
                                          });
                                        },
                                        child: Container(
                                          height: getScreenHeight(70),
                                          width: getScreenWidth(70),
                                          decoration: BoxDecoration(
                                            color: _selectedFontIndex == 4
                                                ? AppColors.boxColors
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              width: 1,
                                              color: _selectedFontIndex == 4
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                            ),
                                          ),
                                          child: Center(
                                              child: Text(
                                            'بِسْمِ',
                                            style: fonts[4](
                                              color: _selectedFontIndex == 4
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          )),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 20,
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  margin: EdgeInsets.symmetric(
                                      horizontal: 20, vertical: 8),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(15)),
                                  width: MediaQuery.of(context).size.width,
                                  child: Row(
                                    children: [
                                      Container(
                                        width: 70,
                                        height: 70,
                                        decoration: BoxDecoration(
                                            color: AppColors.boxColors,
                                            borderRadius:
                                                BorderRadius.circular(15)),
                                        child: Column(
                                          children: [
                                            Spacer(),
                                            Text(
                                              "Size Adjust",
                                              style: TextStyle(
                                                  fontSize: 10,
                                                  color: Colors.white),
                                            ),
                                            SizedBox(height: 2),
                                            Text(
                                              fontSizeValue
                                                  .truncate()
                                                  .toString(),
                                              style: TextStyle(
                                                  fontSize: 18,
                                                  color: Colors.white),
                                            ),
                                            Spacer(),
                                          ],
                                        ),
                                      ),
                                      // Spacer(),
                                      Expanded(
                                        child: Slider(
                                          value: fontSizeValue,
                                          onChanged: (value) {
                                            setState(() {
                                              fontSizeValue = value;
                                            });
                                          },
                                          divisions: 100,
                                          inactiveColor: Colors.grey,
                                          activeColor: AppColors.boxColors,
                                          thumbColor: AppColors.boxColors,
                                          min: 0,
                                          max: 100,
                                        ),
                                      ),
                                      // Spacer(),
                                      Container(
                                        height: getScreenHeight(70),
                                        width: getScreenWidth(70),
                                        decoration: BoxDecoration(
                                          color: _selectedFontIndex == 1
                                              ? AppColors.boxColors
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(15),
                                        ),
                                        child: Center(
                                          child: Text(
                                            'بِسْمِ',
                                            style: fonts[1](
                                              color: _selectedFontIndex == 1
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                              fontSize: 20.0,
                                            ),
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),

                                SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  height: 50,
                                  color: AppColors.boxColors.withOpacity(0.3),
                                  padding: EdgeInsets.only(right: 15, left: 5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Row(
                                        children: [
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 20.0),
                                            child: Text(
                                              "15 Lines",
                                              style: TextStyle(
                                                  color: AppColors.greenColors,
                                                  fontSize: 10),
                                            ),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FlutterSwitch(
                                            activeToggleColor: Colors.white,
                                            activeColor: Color(0xff5FBEAA),
                                            activeSwitchBorder: Border.all(
                                              color: Color(0xff5FBEAA),
                                            ),
                                            inactiveSwitchBorder:
                                                Border.all(color: Colors.grey),
                                            width: 32.0,
                                            height: 20.0,
                                            toggleSize: 20.0,
                                            borderRadius: 20.0,
                                            value: lineStatus,
                                            showOnOff: false,
                                            padding: 0,
                                            onToggle: (value) {
                                              setState(() {
                                                lineStatus = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Row(
                                        children: [
                                          Text(
                                            "Side Mark",
                                            style: TextStyle(
                                                color: AppColors.greenColors,
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FlutterSwitch(
                                            activeToggleColor: Colors.white,
                                            activeColor: Color(0xff5FBEAA),
                                            activeSwitchBorder: Border.all(
                                              color: Color(0xff5FBEAA),
                                            ),
                                            inactiveSwitchBorder:
                                                Border.all(color: Colors.grey),
                                            width: 32.0,
                                            height: 20.0,
                                            toggleSize: 20.0,
                                            borderRadius: 25.0,
                                            value: sideStatus,
                                            showOnOff: false,
                                            padding: 0,
                                            onToggle: (value) {
                                              setState(() {
                                                sideStatus = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                      // SizedBox(
                                      //   width: 10,
                                      // ),
                                      Row(
                                        children: [
                                          Text(
                                            "Screen Timeout",
                                            style: TextStyle(
                                                color: AppColors.greenColors,
                                                fontSize: 10),
                                          ),
                                          SizedBox(
                                            width: 10,
                                          ),
                                          FlutterSwitch(
                                            activeToggleColor: Colors.white,
                                            activeColor: Color(0xff5FBEAA),
                                            activeSwitchBorder: Border.all(
                                              color: Color(0xff5FBEAA),
                                            ),
                                            inactiveSwitchBorder:
                                                Border.all(color: Colors.grey),
                                            width: 32.0,
                                            height: 20.0,
                                            toggleSize: 20.0,
                                            borderRadius: 25.0,
                                            value: screenStatus,
                                            showOnOff: false,
                                            padding: 0,
                                            onToggle: (value) {
                                              setState(() {
                                                screenStatus = value;
                                              });
                                            },
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),

                                Padding(
                                  padding: const EdgeInsets.only(left: 20.0),
                                  child: Text(
                                    "Theme",
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? AppColors.greenColors
                                          : Colors.white,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          var value;
                                          value = ThemeMode.dark;
                                          _selectedItemIndex = 1;
                                          _themeMode = value;
                                          Get.changeThemeMode(_themeMode);
                                        });
                                      },
                                      child: Container(
                                        height: getScreenHeight(70),
                                        width: getScreenWidth(70),
                                        decoration: BoxDecoration(
                                          color: _selectedItemIndex == 1
                                              ? AppColors.boxColors
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 1,
                                            color: _selectedItemIndex == 1
                                                ? Colors.white
                                                : AppColors.boxColors,
                                          ),
                                        ),
                                        child: RotationTransition(
                                          turns: AlwaysStoppedAnimation(-1 / 7),
                                          child: Icon(
                                            Icons.nightlight_outlined,
                                            color: _selectedItemIndex == 1
                                                ? Colors.white
                                                : AppColors.boxColors,
                                            size: 30,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          var value;

                                          value = ThemeMode.light;
                                          _selectedItemIndex = 0;
                                          _themeMode = value;
                                          Get.changeThemeMode(_themeMode);
                                        });
                                      },
                                      child: Container(
                                          height: getScreenHeight(70),
                                          width: getScreenWidth(70),
                                          decoration: BoxDecoration(
                                            color: _selectedItemIndex == 0
                                                ? AppColors.boxColors
                                                : Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(50),
                                            border: Border.all(
                                              width: 1,
                                              color: _selectedItemIndex == 0
                                                  ? Colors.white
                                                  : AppColors.boxColors,
                                            ),
                                          ),
                                          child: Icon(
                                            Icons.wb_sunny_outlined,
                                            color: _selectedItemIndex == 0
                                                ? Colors.white
                                                : AppColors.boxColors,
                                            size: 30,
                                          )),
                                    ),
                                    SizedBox(
                                      width: 10,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          var value;
                                          value = ThemeMode.system;
                                          _selectedItemIndex = 2;
                                          _themeMode = value;
                                          Get.changeThemeMode(_themeMode);
                                        });
                                      },
                                      child: Container(
                                        height: getScreenHeight(70),
                                        width: getScreenWidth(70),
                                        decoration: BoxDecoration(
                                          color: _selectedItemIndex == 2
                                              ? AppColors.boxColors
                                              : Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(50),
                                          border: Border.all(
                                            width: 1,
                                            color: _selectedItemIndex == 2
                                                ? Colors.white
                                                : AppColors.boxColors,
                                          ),
                                        ),
                                        child: Icon(
                                          Icons.mobile_friendly,
                                          color: _selectedItemIndex == 2
                                              ? Colors.white
                                              : AppColors.boxColors,
                                          size: 30,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width *
                                          0.15,
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                              ],
                            )
                          : Container(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerScreen(),
      ),
    );
  }

  Future<void> saveMyFont(int fontIndex) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setInt('index', fontIndex);
  }

  Future<void> getMyFont() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      myindex = prefs.getInt('index') ?? "0";
      print(myindex);
    });
  }
}
