import 'dart:async';

import 'package:adhan/adhan.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:geocoder/geocoder.dart' as GC;
import 'package:geolocator/geolocator.dart';
import 'package:hijri/hijri_calendar.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/views/prayerSettings.dart';
import 'package:perfectholyquran/views/qibla_compass_screen.dart';
import 'package:perfectholyquran/widgets/prayerTimeItem.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

import '../main.dart';

class PrayerTime extends StatefulWidget {
  @override
  _PrayerTimeState createState() => _PrayerTimeState();
}

class _PrayerTimeState extends State<PrayerTime> {
  final _locationStreamController =
      StreamController<LocationStatus>.broadcast();
  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: getScreenWidth(0),
          ),
          child: StreamBuilder(
            stream: stream,
            builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CupertinoActivityIndicator();
              if (snapshot.data.enabled == true) {
                switch (snapshot.data.status) {
                  case LocationPermission.always:
                  case LocationPermission.whileInUse:
                    return PrayerTimeWidget();

                  case LocationPermission.denied:
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.location_off,
                              size: 150,
                              color: Color(0xffb00020),
                            ),
                            SizedBox(height: 32),
                            Text(
                              "Error: Location service permission denied",
                              style: TextStyle(
                                  color: Color(0xffb00020),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 32),
                            ElevatedButton(
                              child: Text("Retry"),
                              onPressed: () {
                                if (_checkLocationStatus != null)
                                  _checkLocationStatus();
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  case LocationPermission.deniedForever:
                    return Container(
                      child: Center(
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            Icon(
                              Icons.location_off,
                              size: 150,
                              color: Color(0xffb00020),
                            ),
                            SizedBox(height: 32),
                            Text(
                              "Error: Location service Denied Forever !",
                              style: TextStyle(
                                  color: Color(0xffb00020),
                                  fontWeight: FontWeight.bold),
                            ),
                            SizedBox(height: 32),
                            ElevatedButton(
                              child: Text("Retry"),
                              onPressed: () {
                                if (_checkLocationStatus != null)
                                  _checkLocationStatus();
                              },
                            )
                          ],
                        ),
                      ),
                    );
                  default:
                    return Container();
                }
              } else {
                return Container(
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: <Widget>[
                        Icon(
                          Icons.location_off,
                          size: 150,
                          color: Color(0xffb00020),
                        ),
                        SizedBox(height: 32),
                        Text(
                          "Error: Please enable Location service",
                          style: TextStyle(
                              color: Color(0xffb00020),
                              fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 32),
                        ElevatedButton(
                          child: Text("Retry"),
                          onPressed: () {
                            if (_checkLocationStatus != null)
                              _checkLocationStatus();
                          },
                        )
                      ],
                    ),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Future<void> _checkLocationStatus() async {
    final locationStatus = await FlutterQiblah.checkLocationStatus();
    if (locationStatus.enabled &&
        locationStatus.status == LocationPermission.denied) {
      await FlutterQiblah.requestPermissions();
      final s = await FlutterQiblah.checkLocationStatus();
      _locationStreamController.sink.add(s);
    } else
      _locationStreamController.sink.add(locationStatus);
  }
}

class PrayerTimeWidget extends StatefulWidget {
  @override
  _PrayerTimeWidgetState createState() => _PrayerTimeWidgetState();
}

class _PrayerTimeWidgetState extends State<PrayerTimeWidget> {
  var fajr = '-',
      sunrise = '-',
      zohr = '-',
      asar = '-',
      maghrib = '-',
      isha = '-';

  bool fajrN = false,
      sunriseN = false,
      zohrN = false,
      asarN = false,
      maghribN = false,
      ishaN = false;

  String timeZoneName;
  var prayerTimes;
  var currentAddress;
  LocationData currentLocation;

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

    setState(() {});
    print(prayerTimes.isha);
    print(DateTime.now());
    //print(maghrib);
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
        error = 'permission denied- please enable it from app settings';
        print(error);
      }
      myLocation = null;
    }
    currentLocation = myLocation;
    final coordinates =
        new GC.Coordinates(myLocation.latitude, myLocation.longitude);
    var addresses =
        await GC.Geocoder.local.findAddressesFromCoordinates(coordinates);
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
    /*dynamic currentTime = DateFormat.jm().format(DateTime.now());
    _showNotification(currentTime, "message");*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    getUserLocation();
    var currentTime = DateFormat.jm().format(DateTime.now());
    print(currentTime);
    // _showNotification(currentTime, "message");
    return SafeArea(
      child: Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/background.png",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
              child: Container(
                padding: EdgeInsets.all(getScreenWidth(20)),
                width: MediaQuery.of(context).size.width,
                child: ListView(
                  children: [
                    Container(
                      height: 70,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 0,
                              top: 30,
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
                              top: 30,
                              child: Text(
                                "Prayer Times",
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
                      height: getScreenHeight(25),
                    ),
                    Container(
                      padding:
                          EdgeInsets.symmetric(horizontal: getScreenHeight(20)),
                      decoration: kDefaultBoxShadow,
                      height: getScreenHeight(60),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          QiblaCompassScreen()));
                            },
                            child: Icon(
                              Icons.my_location_outlined,
                            ),
                          ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '${currentAddress != null ? currentAddress : 'Pakistan'}, ${timeZoneName != null ? timeZoneName : 'PKT'}',
                                style: TextStyle(
                                  fontSize: getScreenHeight(14),
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.greenColors,
                                ),
                              ),
                              SizedBox(
                                height: 5,
                              ),
                              Text(
                                'Muslim World League',
                                style: TextStyle(
                                    color: AppColors.greenColors,
                                    fontSize: getScreenHeight(12)),
                              ),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => PrayerSettings()));
                            },
                            child: Icon(
                              CupertinoIcons.gear,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getScreenHeight(20),
                    ),
                    Container(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Icon(
                            Icons.arrow_back_ios_rounded,
                            size: 15,
                            color:
                                _isDarkMode ? Color(0xff025241) : Colors.white,
                          ),
                          Row(
                            children: [
                              Text(
                                '${DateFormat.yMMMd().format(DateTime.now())}',
                                style: TextStyle(
                                  fontSize: getScreenHeight(12),
                                  color: _isDarkMode
                                      ? Color(0xff025241)
                                      : Colors.white,
                                ),
                              ),
                              Text(
                                ' / ',
                                style: TextStyle(
                                  fontSize: getScreenHeight(12),
                                  color: _isDarkMode
                                      ? Color(0xff025241)
                                      : Colors.white,
                                ),
                              ),
                              Text(
                                '${HijriCalendar.now().toFormat("MMMM dd yyyy")}',
                                style: TextStyle(
                                  fontSize: getScreenHeight(12),
                                  color: _isDarkMode
                                      ? Color(0xff025241)
                                      : Colors.white,
                                ),
                              ),
                            ],
                          ),
                          Icon(
                            Icons.arrow_forward_ios_rounded,
                            size: 15,
                            color:
                                _isDarkMode ? Color(0xff025241) : Colors.white,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getScreenHeight(20),
                    ),
                    Container(
                      decoration: kDefaultBoxShadow,
                      child: Column(
                        children: [
                          PrayerTimeItem(
                            title: 'Fajr',
                            time: '$fajr',
                            icon: fajrN
                                ? CupertinoIcons.bell
                                : CupertinoIcons.bell_slash,
                            onTap: () {
                              if (fajrN == false)
                                _showNotification(prayerTimes.fajr, 'Fajr');
                              fajrN = !fajrN;
                              setState(() {});
                            },
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Color(0xffCFEDE7),
                          ),
                          PrayerTimeItem(
                            title: 'Sunrise',
                            time: '$sunrise',
                            icon: sunriseN
                                ? CupertinoIcons.bell
                                : CupertinoIcons.bell_slash,
                            onTap: () {
                              if (sunriseN == false)
                                _showNotification(prayerTimes.fajr, 'Fajr');
                              sunriseN = !sunriseN;
                              setState(() {});
                            },
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Color(0xffCFEDE7),
                          ),
                          PrayerTimeItem(
                            title: 'Zohr',
                            time: '$zohr',
                            icon: zohrN
                                ? CupertinoIcons.bell
                                : CupertinoIcons.bell_slash,
                            onTap: () {
                              if (zohrN == false)
                                _showNotification(prayerTimes.fajr, 'Zohr');
                              zohrN = !zohrN;
                              setState(() {});
                            },
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Color(0xffCFEDE7),
                          ),
                          PrayerTimeItem(
                            title: 'Asr',
                            time: '$asar',
                            icon: asarN
                                ? CupertinoIcons.bell
                                : CupertinoIcons.bell_slash,
                            onTap: () {
                              if (asarN == true) {
                                var newTime = "5:56 PM";

                                DateTime tempDate =
                                    new DateFormat("hh:mm:ss").parse(newTime);
                                print("tempDate ========== " +
                                    tempDate.toString());
                                _showNotification(tempDate, 'Asar');
                                // _showNotification(DateTime.now(), 'ha');
                              }
                              asarN = !asarN;
                              setState(() {});
                            },
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Color(0xffCFEDE7),
                          ),
                          PrayerTimeItem(
                            title: 'Maghrib',
                            time: '$maghrib',
                            icon: maghribN
                                ? CupertinoIcons.bell
                                : CupertinoIcons.bell_slash,
                            onTap: () {
                              if (maghribN == false) {
                                DateTime tempTime =
                                    new DateFormat("hh:mm").parse(maghrib);
                                print("tempDate ========== " +
                                    tempTime.toString());
                                _showNotification(tempTime, 'Maghrib');
                              }
                              maghribN = !maghribN;
                              setState(() {});
                            },
                          ),
                          Container(
                            height: 1,
                            width: double.infinity,
                            color: Color(0xffCFEDE7),
                          ),
                          PrayerTimeItem(
                            title: 'Isha',
                            time: '$isha',
                            icon: ishaN
                                ? CupertinoIcons.bell
                                : CupertinoIcons.bell_slash,
                            onTap: () {
                              if (ishaN == false)
                                print("fvdvdfv = ======= " +
                                    DateFormat.jm(isha).toString());

                              _showNotification(prayerTimes.fajr, 'Isha');
                              ishaN = !ishaN;
                              setState(() {});
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: getScreenHeight(20),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "ADD WIDGET",
                            style: TextStyle(fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.36, 40),
                            primary: AppColors.boxColors,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                        ElevatedButton(
                          onPressed: () {},
                          child: Text(
                            "FIX NOTIFICATION DELAY",
                            style: TextStyle(fontSize: 10),
                          ),
                          style: ElevatedButton.styleFrom(
                            fixedSize: Size(
                                MediaQuery.of(context).size.width * 0.45, 40),
                            primary: AppColors.boxColors,
                            textStyle: TextStyle(color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    // SizedBox(
                    //   height: getScreenHeight(20),
                    // ),
                    Center(
                      child: Text(
                        '*Prayer time widget can also be added to home screen',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color:
                                _isDarkMode ? Color(0xff025241) : Colors.white,
                            fontSize: 12),
                      ),
                    ),
                  ],
                ),
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

  Future<void> _showNotification(DateTime time, String message) async {
    var scheduledNotification = time;
    const AndroidNotificationDetails androidPlatformChannelSpecifics =
        AndroidNotificationDetails('your channel id', 'your channel name',
            importance: Importance.max,
            priority: Priority.high,
            ticker: 'ticker');
    const NotificationDetails platformChannelSpecifics =
        NotificationDetails(android: androidPlatformChannelSpecifics);

    // ignore: deprecated_member_use
    await flutterLocalNotificationsPlugin.zonedSchedule(
      0,
      'Pefect - Holy Quran',
      'It\s a test notification',
      scheduledNotification,
      platformChannelSpecifics,
      androidAllowWhileIdle: true,
      // payload: '',
      uiLocalNotificationDateInterpretation: null,
    );
  }
}
