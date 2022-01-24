import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/widgets/qibla_compass.dart';

class QiblaCompassScreen extends StatefulWidget {
  @override
  _QiblaCompassScreenState createState() => _QiblaCompassScreenState();
}

class _QiblaCompassScreenState extends State<QiblaCompassScreen> {

  final _deviceSupport = FlutterQiblah.androidDeviceSensorSupport();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColors,
        centerTitle: true,
        elevation: 0.0,
        title: Text("Qibla Compass"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: SafeArea(
        child:Container(
          color: AppColors.greenColors.withOpacity(.1),
          child: FutureBuilder(
            future: _deviceSupport,
            builder: (_, AsyncSnapshot<bool> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting)
                return CupertinoActivityIndicator();
              if (snapshot.hasError)
                return Center(
                  child: Text("Device not support this feature!",style: TextStyle(color: Colors.red.withOpacity(7)),),
                );

              if (snapshot.data)
                return QiblaCompass();
              else
                return Center(
                  child: Text("Device not support this feature!",style: TextStyle(color: Colors.red.withOpacity(7)),),
                );
              // LocationErrorWidget();
            },
          ),
        ),
      ),
    );
  }
}
