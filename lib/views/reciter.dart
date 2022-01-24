import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/widgets/play_pause.dart';

class Reciter extends StatefulWidget {
  const Reciter({key}) : super(key: key);

  @override
  _ReciterState createState() => _ReciterState();
}

class _ReciterState extends State<Reciter> {
  TextEditingController searchController = TextEditingController();
  bool isPressed = false;
  int selectedIndex = 0;
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  List<String> recitationList = [
    'https://download.quranicaudio.com/quran/abdullaah_3awwaad_al-juhaynee/006.mp3',
    'https://download.quranicaudio.com/quran/abdullaah_basfar/010.mp3',
    'https://download.quranicaudio.com/quran/abdurrahmaan_as-sudays/018.mp3',
    'https://download.quranicaudio.com/quran/abdurrashid_sufi/032.mp3',
    'https://download.quranicaudio.com/quran/khayat/030.mp3',
    'https://download.quranicaudio.com/quran/bandar_baleela/068.mp3',
    'https://download.quranicaudio.com/quran/mishaari_raashid_al_3afaasee/001.mp3',
    'https://download.quranicaudio.com/quran/muhammad_patel/036.mp3',
    'https://download.quranicaudio.com/quran/mustafa_al3azzawi/067.mp3',
    'https://download.quranicaudio.com/quran/mahmood_ali_albana/073.mp3',
    'https://download.quranicaudio.com/quran/sahl_yaaseen/019.mp3',
    'https://download.quranicaudio.com/quran/sa3ood_al-shuraym/015.mp3',
    'https://download.quranicaudio.com/quran/tawfeeq_bin_saeed-as-sawaaigh/029.mp3',
    'https://download.quranicaudio.com/quran/wadee_hammadi_al-yamani/034.mp3',
    'https://download.quranicaudio.com/quran/yasser_ad-dussary/048.mp3',
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

  List<String> recitersNicName = [
    'jhn',
    'bsfr',
    'sds',
    'Not Found',
    'kyat',
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

  search(String value) {
    print(value);
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   resizeToAvoidBottomInset: false,
    //   appBar: AppBar(
    //     backgroundColor: AppColors.greenColors,
    //     brightness: Brightness.dark,
    //     title: Text('Reciters'),
    //   ),
    //   body: SafeArea(
    //     child: Container(
    //       decoration: BoxDecoration(
    //          image: DecorationImage(image: AssetImage("assets/background.png")),
    //       ),
    //       child: Padding(
    //         padding: EdgeInsets.symmetric(
    //           horizontal: getScreenWidth(10),
    //           vertical: getScreenWidth(10),
    //         ),
    //         child: ListView.builder(
    //           itemCount: recitationList.length,
    //             itemBuilder: (context, index) {
    //             return Padding(
    //               padding: EdgeInsets.symmetric(
    //                 horizontal: getScreenHeight(10),
    //                 vertical: getScreenHeight(5),
    //               ),
    //               child: Container(
    //
    //                 height: 70,
    //                 width: MediaQuery.of(context).size.width,
    //                 padding: EdgeInsets.symmetric(horizontal: 10),
    //                 decoration: BoxDecoration(
    //
    //                   borderRadius: BorderRadius.circular(10),
    //                   color: Colors.white,
    //                   boxShadow: [
    //                     BoxShadow(
    //                       color: Colors.grey.withOpacity(0.5),
    //                       spreadRadius: 1,
    //                       blurRadius: 10,
    //                       offset: Offset(
    //                           0, 3), // changes position of shadow
    //                     ),
    //                   ],
    //                 ),
    //                 child: Row(
    //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
    //                   children: [
    //                     Text(
    //                       reciters[index],
    //                       style: TextStyle(
    //                         color: AppColors.greenColors,
    //                       ),
    //                     ),
    //                     IconButton(onPressed: () {
    //                       CircularProgressIndicator();
    //                       }, icon: Icon(CupertinoIcons.cloud_download),
    //
    //                     )
    //                     // Icon
    //                     // PlayPause(isPressed: isPressed, url: recitationList[index],),
    //                   ],
    //                 ),
    //               ),
    //             );
    //             }),
    //       ),
    //     ),
    //   ),
    // );
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        key: _key,
        body: Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: _isDarkMode
                  ? BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                          "assets/background.png",
                        ),
                        fit: BoxFit.cover,
                      ),
                    )
                  : BoxDecoration(color: Colors.black),
              child: ListView(
                children: [
                  Container(
                    // decoration: BoxDecoration(
                    //   image: DecorationImage(
                    //     image: AssetImage(
                    //       "assets/background.png",
                    //     ),
                    //   ),
                    // ),
                    height: 70,
                    child: Stack(
                      children: [
                        Positioned(
                            left: 20,
                            top: 50,
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
                            left: 170,
                            top: 50,
                            child: Text(
                              "Reciter",
                              style: TextStyle(
                                  color: _isDarkMode
                                      ? AppColors.greenColors
                                      : Colors.white,
                                  fontSize: 17,
                                  fontWeight: FontWeight.bold),
                            )),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 17,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: TextField(
                      onChanged: (value) {
                        search(value);
                      },
                      decoration: InputDecoration(
                        prefixIcon: Icon(
                          Icons.search,
                          size: 30,
                          color: AppColors.boxColors,
                        ),
                        hintText: "Search Dua Here",
                        hintStyle: TextStyle(color: Colors.grey),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height * 0.65,
                    width: MediaQuery.of(context).size.width * 0.85,
                    margin: EdgeInsets.symmetric(
                      horizontal: getScreenHeight(15),
                    ),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20),
                        color: Colors.white),
                    child: Padding(
                      padding: EdgeInsets.symmetric(
                        horizontal: getScreenWidth(0),
                        vertical: getScreenWidth(10),
                      ),
                      child: ListView.builder(
                          itemCount: recitationList.length,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: EdgeInsets.symmetric(
                                //horizontal: getScreenHeight(10),
                                vertical: getScreenHeight(2),
                              ),
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    selectedIndex = index;
                                  });
                                },
                                child: Container(
                                  height: 70,
                                  padding: EdgeInsets.symmetric(horizontal: 10),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    color: selectedIndex == index
                                        ? AppColors.boxColors
                                        : Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color: AppColors.boxColors
                                            .withOpacity(0.2),
                                        spreadRadius: 1,
                                        blurRadius: 10,
                                        offset: Offset(
                                            0, 3), // changes position of shadow
                                      ),
                                    ],
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        reciters[index],
                                        style: TextStyle(
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : AppColors.greenColors,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          CircularProgressIndicator();
                                        },
                                        icon: Icon(
                                          Icons.file_download_outlined,
                                          color: selectedIndex == index
                                              ? Colors.white
                                              : AppColors.greenColors,
                                        ),
                                      )
                                      // Icon
                                      // PlayPause(isPressed: isPressed, url: recitationList[index],),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          }),
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                ],
              ),
            ),
            // Align(
            //     alignment: Alignment.bottomRight,
            //     child: Image.asset(
            //       'assets/bottomright.png',
            //       color: AppColors.greenColors,
            //       height: MediaQuery.of(context).size.height * 0.12,
            //       width: MediaQuery.of(context).size.width * 0.22,
            //     )),
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
}
