import 'dart:async';
import 'dart:math' show pi;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_qiblah/flutter_qiblah.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:geolocator/geolocator.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

class QiblaCompass extends StatefulWidget {
  @override
  _QiblaCompassState createState() => _QiblaCompassState();
}

class _QiblaCompassState extends State<QiblaCompass> {
  final _locationStreamController =
  StreamController<LocationStatus>.broadcast();

  get stream => _locationStreamController.stream;

  @override
  void initState() {
    _checkLocationStatus();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.all(8.0),
      child: StreamBuilder(
        stream: stream,
        builder: (context, AsyncSnapshot<LocationStatus> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting)
            return CupertinoActivityIndicator();
          if (snapshot.data.enabled == true) {
            switch (snapshot.data.status) {
              case LocationPermission.always:
              case LocationPermission.whileInUse:
                return QiblahCompassWidget();

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
                              color: Color(0xffb00020), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 32),
                        RaisedButton(
                          child: Text("Retry"),
                          onPressed: () {
                            if (_checkLocationStatus != null) _checkLocationStatus();
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
                              color: Color(0xffb00020), fontWeight: FontWeight.bold),
                        ),
                        SizedBox(height: 32),
                        RaisedButton(
                          child: Text("Retry"),
                          onPressed: () {
                            if (_checkLocationStatus != null) _checkLocationStatus();
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
                          color: Color(0xffb00020), fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 32),
                    RaisedButton(
                      child: Text("Retry"),
                      onPressed: () {
                        if (_checkLocationStatus != null) _checkLocationStatus();
                      },
                    )
                  ],
                ),
              ),
            );
          }
        },
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

  @override
  void dispose() {
    super.dispose();
    _locationStreamController.close();
    FlutterQiblah().dispose();
  }
}

class QiblahCompassWidget extends StatelessWidget {
  final _kaabaSvg = SvgPicture.asset('assets/4.svg');

  @override
  Widget build(BuildContext context) {
    var _platformBrightness = Theme.of(context).brightness;
    return StreamBuilder(
      stream: FlutterQiblah.qiblahStream,
      builder: (_, AsyncSnapshot<QiblahDirection> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting)
          return CupertinoActivityIndicator();

        final qiblahDirection = snapshot.data;
        var _angle = ((qiblahDirection.qiblah ?? 0) * (pi / 180) * -1);

        // if (_angle < 5 && _angle > -5) print('IN RANGE');

        return Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform.rotate(
              angle: _angle,
              child: SvgPicture.asset('assets/5.svg', // compass
                  color: _platformBrightness == Brightness.dark
                      ? AppColors.greenColors
                      : AppColors.greenColors),
            ),
            _kaabaSvg,
            SvgPicture.asset('assets/3.svg', //needle
                color: _platformBrightness == Brightness.dark
                    ? AppColors.greenColors
                    : AppColors.greenColors),
            Align(
              alignment: Alignment.bottomCenter,
              child: Text(
                "Align both arrow head\nDo not put device close to metal object.\nCalibrate the compass eveytime you use it.",
                textAlign: TextAlign.center,
              ),
            )
          ],
        );
      },
    );
  }
}