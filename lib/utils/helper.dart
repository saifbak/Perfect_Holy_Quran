


import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class Helper {
  static int updateCounter = 0;
  static SharedPreferences prefs;
  static Timer countTime;
  static int second = 0;
  static int totalTime = 0;
}