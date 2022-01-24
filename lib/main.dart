import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:perfectholyquran/mychanges/sura_screen_tab.dart';
import 'package:perfectholyquran/providers/juzz_list_provider.dart';
import 'package:perfectholyquran/providers/surah_details_model.dart';
import 'package:perfectholyquran/providers/surahlist_provider.dart';
import 'package:perfectholyquran/views/onboarding_screen.dart';
import 'package:perfectholyquran/views/splash_screen.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'views/home_screen.dart';
import 'views/quran_home_screen.dart';
import 'add_notification.dart';

int initScreen;
final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
String selectedNotificationPayload;

class ReceivedNotification {
  ReceivedNotification({
    this.id,
    this.title,
    this.body,
    this.payload,
  });

  final int id;
  final String title;
  final String body;
  final String payload;
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final NotificationAppLaunchDetails notificationAppLaunchDetails =
      await flutterLocalNotificationsPlugin.getNotificationAppLaunchDetails();
  if (notificationAppLaunchDetails?.didNotificationLaunchApp ?? false) {
    selectedNotificationPayload = notificationAppLaunchDetails.payload;
  }

  const AndroidInitializationSettings initializationSettingsAndroid =
      AndroidInitializationSettings('ic_launcher');
  final IOSInitializationSettings initializationSettingsIOS =
      IOSInitializationSettings(
          requestAlertPermission: true,
          requestBadgePermission: true,
          requestSoundPermission: true,
          onDidReceiveLocalNotification:
              (int id, String title, String body, String payload) async {});
  final InitializationSettings initializationSettings = InitializationSettings(
      android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
  await flutterLocalNotificationsPlugin.initialize(initializationSettings,
      onSelectNotification: (String payload) async {
    if (payload != null) {
      debugPrint('notification payload: $payload');
    }
  });

  SharedPreferences prefs = await SharedPreferences.getInstance();
  initScreen = prefs.getInt("initScreen");
  await prefs.setInt("initScreen", 1);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => SurahListProvider()),
        ChangeNotifierProvider(create: (_) => SurahDetailsProvider(1)),
        ChangeNotifierProvider(create: (_) => JuzzDetailsProvider(1)),
      ],
      child: GetMaterialApp(
        theme: ThemeData.light().copyWith(
          primaryColor: Colors.purple,
        ),
        darkTheme: ThemeData.dark().copyWith(
          primaryColor: Colors.grey,
        ),
        // NOTE: Optional - use themeMode to specify the startup theme
        themeMode: ThemeMode.system,
        // theme: ThemeData(
        //
        //   // textButtonTheme: TextButtonThemeData(),
        //   hoverColor: Color(0xff5FBEAA),
        //   buttonTheme: ButtonThemeData(
        //     hoverColor: Color(0xff5FBEAA),
        //   ),
        // ),

        debugShowCheckedModeBanner: false,
        initialRoute: initScreen == 0 || initScreen == null ? "/" : "first",
        routes: {
          '/': (context) => OnboardingScreen(),
          "first": (context) => SplashScreen(),
        },
      ),
    );
  }
}
