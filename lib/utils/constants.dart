import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

BoxDecoration kDefaultBoxShadow = BoxDecoration(
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

const String kGoogleMapKey = 'AIzaSyC8kRImPuX2uzBQCU9Q1pD68fSjZuBUJMQ';

// Colors
const kPrimaryColor = Color.fromRGBO(0, 70, 54, 1);
const kSecondaryColor = Color(0xff5FBEAA);

// Default Padding
const kDefaultPadding = EdgeInsets.only(
  left: 10,
  right: 10,
);

// Default Text Styles
const kTitleStyle = TextStyle(
  fontSize: 18,
  fontWeight: FontWeight.bold,
);
const kHeadlineStyle = TextStyle(
  fontSize: 17,
  fontWeight: FontWeight.bold,
);
const kBodyStyle = TextStyle(
  fontWeight: FontWeight.w700,
  fontSize: 14,
);
const kCalloutStyle = TextStyle(
  fontSize: 15,
);
const kSubheadingStyle = TextStyle(
  fontSize: 14,
  fontWeight: FontWeight.w600,
);

const double kDefaultSpacing = 10;
const double kSmallSpacing = 5;

var duaIcons = [
  "assets/hand.png",
  "assets/bed.png",
  "assets/clock.png",
  "assets/toilet.png",
  "assets/food.png",
  "assets/joy.png",
  "assets/distress.png",
  "assets/travel.png",
  "assets/mosque.png",
  "assets/mosque.png",
  "assets/qibla.png",
  "assets/sikness.png",
  "assets/shopping.png",
  "assets/quran.png",
  "assets/fiqhi.png",
];

Future<Position> determinePosition() async {
  bool serviceEnabled;
  LocationPermission permission;
  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    Fluttertoast.showToast(
        msg: "Location services are disabled, Please Enable to see Prayer Timings",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return Future.error('Location services are disabled.');
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      Fluttertoast.showToast(
          msg: "Location permissions are denied",
          toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0
      );
      return Future.error('Location permissions are denied');
    }
  }
  if (permission == LocationPermission.deniedForever) {
    Fluttertoast.showToast(
        msg: "Location permissions are permanently denied, we cannot request permissions",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0
    );
    return Future.error('Location permissions are permanently denied, we cannot request permissions.');
  }
  return await Geolocator.getCurrentPosition();
}
