import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/views/prayerTime.dart';
import 'package:perfectholyquran/widgets/qibla_compass.dart';

class PrayerTimeMainScreen extends StatefulWidget {
  @override
  _PrayerTimeMainScreenState createState() => _PrayerTimeMainScreenState();
}

class _PrayerTimeMainScreenState extends State<PrayerTimeMainScreen> {
  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          // width: MediaQuery.of(context).size.width,
          color: AppColors.greenColors.withOpacity(.1),
          child: FutureBuilder(
            future: _deviceSupport,
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CupertinoActivityIndicator();
              if (snapshot.hasError)
                return Center(
                  child: Text(
                    "Device not support this feature!",
                    style: TextStyle(color: Colors.red.withOpacity(7)),
                  ),
                );

              if (snapshot.data)
                return PrayerTime();
              else
                return Center(
                  child: Text(
                    "Device not support this feature!",
                    style: TextStyle(color: Colors.red.withOpacity(7)),
                  ),
                );
              // LocationErrorWidget();
            },
          ),
        ),
      ),
    );
  }
}
