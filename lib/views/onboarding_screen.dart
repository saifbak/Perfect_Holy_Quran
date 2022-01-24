import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/views/home_screen.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:location/location.dart';
import 'package:flutter/services.dart';
import 'package:geocoder/geocoder.dart';

class OnboardingScreen extends StatefulWidget {
  @override
  _OnboardingScreenState createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {

  final introKey = GlobalKey<IntroductionScreenState>();

  void _onIntroEnd(context) {
    Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (_) => HomeScreen()),);
  }

  Widget _buildImage(String assetName) {
    return Align(
      child: Image.asset('assets/$assetName.png', width: MediaQuery.of(context).size.width, height: 300,),
      alignment: Alignment.bottomCenter,
    );
  }

  var currentAddress;
  LocationData currentLocation;

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
    final coordinates = new Coordinates(
        myLocation.latitude, myLocation.longitude);
    var addresses = await Geocoder.local.findAddressesFromCoordinates(
        coordinates);
    var first = addresses.first;
    print('${first.locality}, ${first.adminArea}');
    currentAddress = '${first.locality} ${first.adminArea}';
    //print("currentAddress = "+ currentAddress.toString());
    //return first;
  }

  @override
  void initState() {
 getUserLocation();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    const bodyStyle = TextStyle(fontSize: 16.0, color: Colors.white);
    const pageDecoration = const PageDecoration(
      titleTextStyle: TextStyle(fontSize: 26.0, fontWeight: FontWeight.w700, color: Colors.white),
      bodyTextStyle: bodyStyle,
      descriptionPadding: EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 6.0),
      pageColor: Color.fromRGBO(0, 70, 54, 1),
      imagePadding: EdgeInsets.zero,
    );

    return IntroductionScreen(
      key: introKey,
      pages: [
        PageViewModel(
          title: "Perfect Holy Quran",
          body: "\"Indeed, It is We who sent down the Quran and indeed, We will be its Guardian\"\n",
          image: _buildImage('logo'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Live Watch Madina & Makkah",
          body: "You can watch Madina & Makkah updates, Addhan, everything live in our app",
          image: _buildImage('madinaImage'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Get Prayers Timing",
          body: "You can get Prayers timings, so you can't miss the Prayer.",
          image: _buildImage('prayerTimeImage'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Easy to Find Qibla Direction",
          body: "Now you don't worry about Qibla direction we can find it for you.",
          image: _buildImage('qiblaDirection'),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: "Dua's Collections",
          body: "We have collected most of the Dua's of the daily routine.",
          image: _buildImage('hand'),
          decoration: pageDecoration,
        ),
      ],
      onDone: () => _onIntroEnd(context),
      //onSkip: () => _onIntroEnd(context), // You can override onSkip callback
      showSkipButton: true,
      skipFlex: 0,
      nextFlex: 0,
      skip: const Text('Skip', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0dd1a7))),
      next: const Icon(Icons.arrow_forward, color: Color(0xFF0dd1a7)),
      done: const Text('Done', style: TextStyle(fontWeight: FontWeight.w600, color: Color(0xFF0dd1a7))),
      dotsDecorator: const DotsDecorator(
        size: Size(10.0, 10.0),
        activeColor: Color(0xFF0dd1a7),
        color: Color(0xFFBDBDBD),
        activeSize: Size(22.0, 10.0),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(15.0)),
        ),
      ),
    );
  }
}
