import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';

import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/widgets/audioSettingItem.dart';

class AudioSettings extends StatefulWidget {
  const AudioSettings({key}) : super(key: key);

  @override
  _AudioSettingsState createState() => _AudioSettingsState();
}

class _AudioSettingsState extends State<AudioSettings> {
  double _currentVolumeValue = 25, _currentAyaDelay = 25;
  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: AppColors.greenColors,
        title: Text('Audio Settings'),
      ),
      body: SafeArea(
        child: Container(
          decoration: _isDarkMode?  BoxDecoration(
              image: DecorationImage(
                  image: AssetImage(
                    "assets/background.png",

                  ))): BoxDecoration(
              color: Colors.black
          ),
          child: SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: 10,
                horizontal: 10,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Reciter',
                    style: TextStyle(
                    color:  _isDarkMode ? Color(0xff025241): Colors.white,
                      fontSize: getScreenHeight(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  Container(
                    decoration: kDefaultBoxShadow.copyWith(
                      color: Color(0xff5FBEAA),
                    ),
                    padding: EdgeInsets.symmetric(
                      vertical: getScreenHeight(20),
                    ),
                    width: double.infinity,
                    child: Center(
                      child: Text(
                        'As-Suday-Shraym',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: getScreenHeight(14),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  Text(
                    'Volume',
                    style: TextStyle(
                      color:  _isDarkMode ? Color(0xff025241): Colors.white,
                      fontSize: getScreenHeight(16),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(
                      horizontal: getScreenHeight(15),
                      vertical: getScreenWidth(10),
                    ),
                    decoration: kDefaultBoxShadow,
                    child: Slider.adaptive(
                      activeColor: AppColors.greenColors,
                      inactiveColor: Color(0xffECFAF7),
                      value: _currentVolumeValue,
                      min: 0,
                      max: 100,
                      onChanged: (double value) {
                        setState(() {
                          _currentVolumeValue = value;
                        });
                      },
                    ),
                  ),
                  SizedBox(
                    height: getScreenHeight(20),
                  ),
                  AudioSettingItem(
                    title: 'Aya Delay',
                    subtitle: 'Set a delay or pause of few secs in between Ayaat',
                    state: 'None',
                    currentAyaDelay: 35,
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  AudioSettingItem(
                    title: 'Range',
                    subtitle:
                        'Set a Range between Sura, Ruku. Page or Aya for reading',
                    state: '1 aya',
                    currentAyaDelay: 20,
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  AudioSettingItem(
                    title: 'Range Repeat',
                    subtitle: 'Set the repeat parameter for the set range',
                    state: 'Once',
                    currentAyaDelay: 15,
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  AudioSettingItem(
                    title: 'PlayBack Speed',
                    subtitle: 'Set the Playback Speed of the Quran audio',
                    state: '1.0x',
                    currentAyaDelay: 0,
                  ),
                  SizedBox(
                    height: getScreenHeight(10),
                  ),
                  Center(
                    child: TextButton(
                      onPressed: () {},
                      child: Container(
                        padding: EdgeInsets.symmetric(
                            horizontal: getScreenWidth(50),
                            vertical: getScreenHeight(18)),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color(0xff5FBEAA),
                        ),
                        child: Text('ADD WIDGET',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            )),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
