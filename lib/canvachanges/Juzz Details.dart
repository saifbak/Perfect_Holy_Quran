import 'dart:convert';

//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:perfectholyquran/views/drawer_screen.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectholyquran/widgets/PositionSeekWidget.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ayah {
  int number;
  String text;
  int numberInSurah;
  int juz;
  int manzil;
  int page;
  int ruku;
  int hizbQuarter;
  int surah;

  ayah({
    this.number,
    this.text,
    this.numberInSurah,
    this.juz,
    this.manzil,
    this.page,
    this.ruku,
    this.hizbQuarter,
    this.surah,
  });

  ayah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    text = json['text'];
    numberInSurah = json['numberInSurah'];
    juz = json['juz'];
    manzil = json['manzil'];
    page = json['page'];
    ruku = json['ruku'];
    hizbQuarter = json['hizbQuarter'];
    surah = json['surah']['number'];
  }
}

class surah {
  int number;
  String name;
  String englishName;
  String englishNameTranslation;
  String revelationType;
  int numberOfAyahs;
  List<ayah> ayahs;

  surah(
      {this.number,
      this.name,
      this.englishName,
      this.englishNameTranslation,
      this.revelationType,
      this.numberOfAyahs,
      this.ayahs});

  surah.fromJson(Map<String, dynamic> json) {
    number = json['number'];
    name = json['name'];
    englishName = json['englishName'];
    englishNameTranslation = json['englishNameTranslation'];
    revelationType = json['revelationType'];
    numberOfAyahs = json['numberOfAyahs'];
    ayahs = [];
  }
}

class JuzzDetails extends StatefulWidget {
  int juzzIndex;
  String juzzName;

  JuzzDetails({this.juzzIndex, this.juzzName});

  @override
  _JuzzDetailsState createState() => _JuzzDetailsState();
}

List fonts = [
  GoogleFonts.scheherazade,
  GoogleFonts.almarai,
  GoogleFonts.amiri,
  GoogleFonts.katibeh,
  GoogleFonts.tajawal,
];

int myindex = 0;

class _JuzzDetailsState extends State<JuzzDetails> {
  bool surahPlaying = false;
  int selectedIndex = -1;
  List name = [];
  List<surah> surahData = [];

  //AudioPlayer _audioPlayer = new AudioPlayer();
  AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    getMyFont();
    getSurahList1();
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  void setupSurahAudio(int surahIndex, String surahName) {
    if (surahIndex <= 9) {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio.network(
                'https://server6.mp3quran.net/a_ahmed/00${surahIndex}.mp3',
                metas: Metas(
                  title: surahName,
                  artist: 'Ahmed',
                ))
          ]),
          showNotification: true,
          autoStart: false);
    } else if (surahIndex <= 99) {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio.network(
                'https://server6.mp3quran.net/a_ahmed/0${surahIndex}.mp3',
                metas: Metas(
                  title: surahName,
                  artist: 'Ahmed',
                ))
          ]),
          showNotification: true,
          autoStart: false);
    } else {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio.network(
                'https://server6.mp3quran.net/a_ahmed/${surahIndex}.mp3',
                metas: Metas(
                  title: surahName,
                  artist: 'Ahmed',
                ))
          ]),
          showNotification: true,
          autoStart: false);
    }
  }

  playMusic() async {
    await assetsAudioPlayer.play();
  }

  pauseMusic() async {
    await assetsAudioPlayer.pause();
  }

  skipNext() async {
    await assetsAudioPlayer.next();
  }

  skipPrevious() async {
    await assetsAudioPlayer.previous();
  }

  // Future<List<dynamic>> getSurahList() async {
  //   try {
  //     String url = 'http://api.alquran.cloud/v1/juz/1/quran-uthmani';
  //     var response = await http.get(Uri.parse(url), headers: {
  //       'Content-Type': 'application/json',
  //       'Accept': 'application/json',
  //     });

  //     // print("Api run -->" + json.decode(response.body)['data']);
  //     // var data = json.decode(response.body);
  //     List data = json.decode(response.body)['data']['ayahs'];
  //     // print("Surah --> $surahs");
  //     // setState(() {
  //     // surahs = data;
  //     // });
  //     // for (var ayah in json.decode(response.body)['data']['ayahs']) {
  //     //   for (var i = 0; i < surahs.length; i++) {
  //     //     if (surahs[i]['number'] == ayah['surah']['number']) {
  //     //       surahs[i]['ayats'].add(ayah);
  //     //       print(surahs[i]['ayats']);
  //     //     }
  //     //   }
  //     // }

  //     return data;
  //     // return json.decode(response.body)['data']['ayahs'];
  //   } catch (e) {
  //     print("Error $e");
  //   }
  // }

  getSurahList1() async {
    try {
      String url =
          'http://api.alquran.cloud/v1/juz/${widget.juzzIndex}/quran-uthmani';
      var response = await http.get(Uri.parse(url), headers: {
        'Content-Type': 'application/json',
        'Accept': 'application/json',
      });

      // print("Api run -->" + json.decode(response.body)['data']);
      var data =
          json.decode(response.body)['data']['surahs'] as Map<String, dynamic>;

      List<surah> surahs =
          data.entries.map((entry) => surah.fromJson(entry.value)).toList();

      List<ayah> ayahs =
          (json.decode(response.body)['data']['ayahs'] as List<dynamic>)
              .map((entry) => ayah.fromJson(entry))
              .toList();

      // List data = json.decode(response.body)['data']['ayahs'];
      // print("Surah --> $surahs");
      // setState(() {
      // });
      for (ayah a in ayahs) {
        for (var i = 0; i < surahs.length; i++) {
          if (surahs[i].number == a.surah) {
            surahs[i].ayahs.add(a);
          }
        }
      }

      setState(() {
        this.surahData = surahs;
      });
      print("Surahs ${surahs[1]}");

      // return json.decode(response.body)['data']['ayahs'];
    } catch (e) {
      print("Error 1 $e");
    }
  }

  Future<void> getMyFont() async {
    final prefs = await SharedPreferences.getInstance();

    setState(() {
      myindex = prefs.getInt('index') ?? "0";
      print(myindex);
    });
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;

    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: Text("${widget.juzzName}"),),
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    decoration: _isDarkMode
                        ? BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage(
                                  "assets/background.png",
                                ),
                                fit: BoxFit.cover))
                        : BoxDecoration(color: Colors.black)),
                // Align(
                //     alignment: Alignment.bottomRight,
                //     child: Image.asset(
                //       'assets/bottomright.png',
                //       color: AppColors.greenColors,
                //       height: MediaQuery.of(context).size.height * 0.12,
                //       width: MediaQuery.of(context).size.width * 0.22,
                //     )),
                // Align(
                //     alignment: Alignment.bottomLeft,
                //     child: Image.asset(
                //       'assets/bottomleft.png',
                //       color: AppColors.greenColors,
                //       height: MediaQuery.of(context).size.height * 0.12,
                //       width: MediaQuery.of(context).size.width * 0.29,
                //     )),
                // Align(
                //     alignment: Alignment.topRight,
                //     child: Image.asset(
                //       'assets/topright.png',
                //       color: AppColors.greenColors,
                //       height: MediaQuery.of(context).size.height * 0.12,
                //       width: MediaQuery.of(context).size.width * 0.29,
                //     )),
                SingleChildScrollView(
                  child: Column(
                    children: [
                      SizedBox(height: 60),
                      SingleChildScrollView(
                        scrollDirection: Axis.vertical,
                        child: Column(
                          children: [
                            Container(
                              width: MediaQuery.of(context).size.width,
                              padding: EdgeInsets.symmetric(horizontal: 20),
                              child: Stack(
                                alignment: Alignment.centerLeft,
                                children: [
                                  GestureDetector(
                                    onTap: () => Navigator.pop(context),
                                    child: Icon(
                                      Icons.arrow_back,
                                      size: 25,
                                      color: _isDarkMode
                                          ? Color(0xff025241)
                                          : Colors.white,
                                    ),
                                  ),
                                  Positioned(
                                    left: 50,
                                    child: Text(
                                      "Perfect Holy Quran",
                                      style: TextStyle(
                                          color: _isDarkMode
                                              ? Color(0xff025241)
                                              : Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: 80,
                                  // ),

                                  Positioned(
                                    right: 0,
                                    child: Builder(builder: (context) {
                                      return InkWell(
                                        onTap: () {
                                          Scaffold.of(context).openDrawer();
                                        },
                                        child:
                                            Image.asset("assets/menuIcon.png"),
                                        // Icon(
                                        //   Icons.menu,
                                        //   size: 25,
                                        //   color: _isDarkMode
                                        //       ? Color(0xff025241)
                                        //       : Colors.white,
                                        // ),
                                      );
                                    }),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(height: 10),
                            Container(
                              height: 560,
                              width: MediaQuery.of(context).size.width * 0.90,
                              decoration: BoxDecoration(
                                  color:
                                      _isDarkMode ? Colors.white : Colors.black,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20))),
                              child: Column(
                                children: [
                                  SizedBox(height: 5),
                                  Padding(
                                    padding: const EdgeInsets.all(5.0),
                                    child: Text(
                                      "Juzz ${widget.juzzIndex}",
                                      style: TextStyle(
                                        fontSize: 14,
                                        color: _isDarkMode
                                            ? Color(0xff025241)
                                            : Colors.white,
                                      ),
                                    ),
                                  ),
                                  Text("${widget.juzzName}",
                                      style: TextStyle(
                                          fontSize: 18,
                                          color: _isDarkMode
                                              ? Color(0xff025241)
                                              : Colors.white,
                                          fontWeight: FontWeight.bold)),

                                  Image.asset(
                                    "assets/Bismillah.png",
                                    scale: 1.2,
                                  ),

                                  // widget.juzzName == 'Alīf-Lām-Mīm'
                                  //     ? SizedBox()
                                  //     :
                                  // Container(
                                  //   // child: Row(
                                  //   //   children: [
                                  //   //     SizedBox(
                                  //   //       width: 10,
                                  //   //     ),
                                  //   //     // Text("${widget.juzzName}", style: TextStyle(fontSize: 16)),
                                  //   //     // Spacer(),
                                  //   //     // Container(child: assetsAudioPlayer.builderIsPlaying(builder: (context, isPlaying) {
                                  //   //     //   return Row(
                                  //   //     //     mainAxisAlignment: MainAxisAlignment.center,
                                  //   //     //     crossAxisAlignment: CrossAxisAlignment.center,
                                  //   //     //     children: [
                                  //   //     //       IconButton(
                                  //   //     //           onPressed: () => isPlaying ? playMusic() : pauseMusic(),
                                  //   //     //           icon: Icon(
                                  //   //     //             isPlaying == false ? Icons.play_circle_fill : Icons.pause_circle_filled,
                                  //   //     //           )),
                                  //   //     //     ],
                                  //   //     //   );
                                  //   //     // }))
                                  //   //   ],
                                  //   // ),
                                  //   // width: 200,
                                  //   width: MediaQuery.of(context).size.width,
                                  //   height: 50,
                                  //   decoration: BoxDecoration(
                                  //     color: Color(0xff5FBEAA),
                                  //     borderRadius: BorderRadius.only(
                                  //       topLeft: Radius.circular(00),
                                  //       bottomLeft: Radius.circular(00.0),
                                  //     ),
                                  //   ),
                                  // ),
                                  Expanded(
                                    // padding: const EdgeInsets.only(
                                    //     left: 4.0, right: 4.0),
                                    //     height: MediaQuery.of(context)
                                    //             .size
                                    //             .height *
                                    //         0.50,
                                    //     width: MediaQuery.of(context)
                                    //             .size
                                    //             .width *
                                    //         0.90,
                                    //     decoration: BoxDecoration(
                                    //       borderRadius:
                                    //           BorderRadius.circular(20),
                                    //       color: _isDarkMode
                                    //           ? Colors.white
                                    //           : Colors.black,
                                    //     ),
                                    child: InteractiveViewer(
                                      child: ListView.builder(
                                        physics: ClampingScrollPhysics(),
                                        itemCount: surahData.length,
                                        itemBuilder: (context, index) {
                                          // var arabicName = snapshot
                                          //     .data[index]['text'];
                                          // var number = snapshot
                                          //     .data[index]['number'];
                                          // name.add(
                                          //     snapshot.data[index]
                                          //         ['surah']['name']);
                                          return Column(
                                            children: [
                                              // Container(
                                              //   margin: const EdgeInsets.only(right: 8.0, left: 8.0),
                                              //   height: 15,
                                              //   width: 15,
                                              //   alignment: Alignment.center,
                                              //   child: CircleAvatar(
                                              //     child: Text(
                                              //       number.toString(),
                                              //       style: TextStyle(fontSize: 8),
                                              //     ),
                                              //   ),
                                              // ),
                                              // Padding(
                                              //   padding:
                                              //       const EdgeInsets.all(8.0),
                                              //   child: Text(
                                              //     surahData[index]
                                              //         .englishName
                                              //         .toString(),
                                              //     // maxLines: 2,
                                              //     style: TextStyle(
                                              //       fontSize: 18.0,
                                              //       fontFamily:
                                              //           'Noto Naskh Arabic',
                                              //       fontWeight: FontWeight.w600,
                                              //       color: _isDarkMode
                                              //           ? Color(0xff025241)
                                              //           : Colors.white,
                                              //     ),
                                              //     textAlign: TextAlign.end,
                                              //   ),
                                              // ),

                                              Align(
                                                alignment:
                                                    Alignment.centerRight,
                                                child: Container(
                                                  height: 40,
                                                  width: MediaQuery.of(context)
                                                          .size
                                                          .width *
                                                      0.50,
                                                  padding: const EdgeInsets
                                                          .symmetric(
                                                      horizontal: 10,
                                                      vertical: 0),
                                                  decoration: BoxDecoration(
                                                    color: AppColors.boxColors,
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(25),
                                                      bottomLeft:
                                                          Radius.circular(25),
                                                    ),
                                                    border: Border.all(
                                                        color: Colors.blueGrey,
                                                        width: 1,
                                                        style:
                                                            BorderStyle.solid),
                                                  ),
                                                  child: InkWell(
                                                    onTap: () {
                                                      setState(() {
                                                        if (selectedIndex ==
                                                            index) {
                                                          selectedIndex = -1;
                                                        } else {
                                                          selectedIndex = index;
                                                        }
                                                        setupSurahAudio(
                                                            surahData[index]
                                                                .number,
                                                            surahData[index]
                                                                .englishName);
                                                        widget.juzzName =
                                                            surahData[index]
                                                                .englishName;
                                                      });
                                                    },
                                                    child: Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceEvenly,
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .center,
                                                      children: [
                                                        Icon(
                                                          Icons.play_circle,
                                                          size: 25,
                                                          color: Colors.white,
                                                        ),
                                                        // SizedBox(
                                                        //   width: MediaQuery.of(
                                                        //               context)
                                                        //           .size
                                                        //           .width *
                                                        //       0.05,
                                                        // ),
                                                        Expanded(
                                                          child: Padding(
                                                            padding:
                                                                const EdgeInsets
                                                                        .only(
                                                                    bottom:
                                                                        4.0),
                                                            child: Text(
                                                              surahData[index]
                                                                  .englishName
                                                                  .toString(),
                                                              // maxLines: 2,
                                                              style: TextStyle(
                                                                fontSize: 16.0,
                                                                fontFamily:
                                                                    'Noto Naskh Arabic',
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                color: Colors
                                                                    .white,
                                                              ),
                                                              textAlign:
                                                                  TextAlign
                                                                      .center,
                                                            ),
                                                          ),
                                                        ),
                                                        Icon(
                                                          selectedIndex == index
                                                              ? Icons
                                                                  .keyboard_arrow_up
                                                              : Icons
                                                                  .keyboard_arrow_down,
                                                          size: 25,
                                                          color: Colors.white,
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              // Container(
                                              //   margin: const EdgeInsets
                                              //           .only(
                                              //       right: 8.0,
                                              //       left: 8.0),
                                              //   height: 50,
                                              //   width: 100,
                                              //   alignment:
                                              //       Alignment.center,
                                              //   decoration: BoxDecoration(
                                              //       borderRadius:
                                              //           BorderRadius
                                              //               .circular(
                                              //                   20),
                                              //       color: Colors.white,
                                              //       border: Border.all(
                                              //           color: _isDarkMode
                                              //               ? Color(
                                              //                   0xff5FBEAA)
                                              //               : Colors
                                              //                   .black,
                                              //           width: 1)),
                                              //   child: Center(
                                              //     child: Text(
                                              //       name.toString(),
                                              //       style: TextStyle(
                                              //           fontSize: 14,
                                              //           color: _isDarkMode
                                              //               ? Color(
                                              //                   0xff5FBEAA)
                                              //               : Colors
                                              //                   .black),
                                              //     ),
                                              //   ),
                                              // ),
                                              SizedBox(height: 10),
                                              selectedIndex == index
                                                  ? Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              0),
                                                      child: ListView.builder(
                                                        shrinkWrap: true,
                                                        physics:
                                                            NeverScrollableScrollPhysics(),
                                                        itemCount: surahData[
                                                                        index]
                                                                    .englishName ==
                                                                'Al-Faatiha'
                                                            ? surahData[index]
                                                                    .ayahs
                                                                    .length -
                                                                1
                                                            : surahData[index]
                                                                .ayahs
                                                                .length,
                                                        itemBuilder: (_, i) {
                                                          return Wrap(
                                                            crossAxisAlignment:
                                                                WrapCrossAlignment
                                                                    .center,
                                                            alignment:
                                                                WrapAlignment
                                                                    .end,
                                                            verticalDirection:
                                                                VerticalDirection
                                                                    .up,
                                                            children: [
                                                              Container(
                                                                height: 20,
                                                                width: 20,
                                                                alignment:
                                                                    Alignment
                                                                        .topRight,
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            20),
                                                                    color: Colors
                                                                        .white,
                                                                    border: Border.all(
                                                                        color: _isDarkMode
                                                                            ? Color(
                                                                                0xff5FBEAA)
                                                                            : Colors
                                                                                .black,
                                                                        width:
                                                                            1)),
                                                                child: Center(
                                                                  child: Text(
                                                                    (i + 1)
                                                                        .toString(),
                                                                    style:
                                                                        TextStyle(
                                                                      fontSize:
                                                                          10,
                                                                      fontWeight:
                                                                          FontWeight
                                                                              .bold,
                                                                      color: _isDarkMode
                                                                          ? Color(
                                                                              0xff5FBEAA)
                                                                          : Colors
                                                                              .black,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .center,
                                                                  ),
                                                                ),
                                                              ),
                                                              Container(
                                                                width: MediaQuery.of(
                                                                            context)
                                                                        .size
                                                                        .width *
                                                                    0.77,
                                                                padding:
                                                                    const EdgeInsets
                                                                            .only(
                                                                        left:
                                                                            15,
                                                                        right:
                                                                            15),
                                                                child: Text(
                                                                  surahData[index]
                                                                              .englishName ==
                                                                          'Al-Faatiha'
                                                                      ? surahData[
                                                                              index]
                                                                          .ayahs[i +
                                                                              1]
                                                                          .text
                                                                          .toString()
                                                                      : surahData[
                                                                              index]
                                                                          .ayahs[
                                                                              i]
                                                                          .text
                                                                          .toString(),
                                                                  // maxLines: 2,
                                                                  style:
                                                                      TextStyle(
                                                                    fontSize:
                                                                        26,
                                                                    // fontFamily:
                                                                    //     "Noto Sans Arabic",
                                                                    fontFamily:
                                                                        "Saleem Quran Font",
                                                                    // fontWeight:
                                                                    //     FontWeight
                                                                    //         .w600,
                                                                    color: _isDarkMode
                                                                        ? Color(
                                                                            0xff025241)
                                                                        : Colors
                                                                            .white,
                                                                  ),
                                                                  textAlign:
                                                                      TextAlign
                                                                          .end,
                                                                ),
                                                              ),
                                                            ],
                                                          );
                                                        },
                                                      ),
                                                    )
                                                  : SizedBox(),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: 20)
                                ],
                              ),
                            ),
                            SizedBox(
                              height: 100,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 15,
                  child: Container(
                    height: 140,
                    width: 180,
                    margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                    decoration: BoxDecoration(),
                    child: Column(
                      children: [
                        Flexible(
                          flex: 2,
                          child: Material(
                            elevation: 4,
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            child: Container(
                              width: MediaQuery.of(context).size.width * 0.55,
                              decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    margin: EdgeInsets.symmetric(horizontal: 5),
                                    width: MediaQuery.of(context).size.width *
                                        0.55,
                                    height: 8,
                                    decoration: BoxDecoration(
                                      color: Color(0xff5FBEAA),
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(20),
                                          topRight: Radius.circular(20)),
                                    ),
                                  ),
                                  Spacer(),
                                  Padding(
                                      padding: EdgeInsets.only(left: 10),
                                      child: Text(
                                        "Now Playing",
                                        style: TextStyle(
                                            color: Color(0xff025241),
                                            fontSize: 12,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  SizedBox(
                                    height: 3,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(left: 5),
                                    child: Text(
                                      " ${widget.juzzName}",
                                      style: TextStyle(
                                          color: Color(0xff025241),
                                          fontSize: 17,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  Spacer(),
                                  assetsAudioPlayer.builderRealtimePlayingInfos(
                                    builder:
                                        (context, RealtimePlayingInfos infos) {
                                      if (infos == null) {
                                        return SizedBox();
                                      }
                                      return PositionSeekWidget(
                                        currentPosition: infos.currentPosition,
                                        duration: infos.duration,
                                        seekTo: (to) {
                                          assetsAudioPlayer.seek(to);
                                        },
                                      );
                                    },
                                  ),
                                  Spacer(),
                                ],
                              ),
                            ),
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: Material(
                            shadowColor: Colors.black,
                            borderRadius: BorderRadius.circular(20),
                            elevation: 4,
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Padding(
                                padding: EdgeInsets.symmetric(horizontal: 5),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Icon(
                                      Icons.fast_rewind_outlined,
                                      color: Color(0xff5FBEAA),
                                      size: 25,
                                    ),
                                    assetsAudioPlayer.builderIsPlaying(
                                        builder: (context, isPlaying) {
                                      return Container(
                                          height: 60,
                                          width: 60,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              color: Color(0xff5FBEAA)),
                                          child: Center(
                                              child: GestureDetector(
                                                  onTap: () => isPlaying
                                                      ? pauseMusic()
                                                      : playMusic(),
                                                  child: Icon(
                                                    isPlaying == false
                                                        ? Icons.play_arrow
                                                        : Icons.pause,
                                                    size: 30,
                                                    color: Colors.white,
                                                  ))));
                                    }),
                                    Icon(
                                      Icons.fast_forward_outlined,
                                      color: Color(0xff5FBEAA),
                                      size: 25,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            )),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerScreen(),
      ),
    );
  }
}
