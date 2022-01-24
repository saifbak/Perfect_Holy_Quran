import 'dart:convert';
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:focused_menu/focused_menu.dart';
import 'package:focused_menu/modals.dart';
import 'package:http/http.dart' as http;
import 'package:perfectholyquran/canvaDBFiles/newDBHelper.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';
import 'package:perfectholyquran/views/drawer_screen.dart';
import 'package:perfectholyquran/widgets/PositionSeekWidget.dart';
import 'package:perfectholyquran/widgets/drawerItem.dart';
import 'package:perfectholyquran/views/get_all_bookmarks.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SurahDetails extends StatefulWidget {
  int surahIndex;
  String surahName;

  SurahDetails({this.surahIndex, this.surahName});

  @override
  _SurahDetailsState createState() => _SurahDetailsState();
}

List fonts = [
  GoogleFonts.scheherazade,
  GoogleFonts.almarai,
  GoogleFonts.amiri,
  GoogleFonts.katibeh,
  GoogleFonts.tajawal,
];

int myindex = 0;

class _SurahDetailsState extends State<SurahDetails> {
  int totalPages = 0;
  AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();
  String translateDropDownValue = "english_saheeh";

  void getDropDownItem() {
    setState(() {
      translateDropDownValue = translateDropDownValue;
      print("Here is value" + translateDropDownValue);
    });
  }

  @override
  void initState() {
    super.initState();

    getSurahList(transWord: 'english_saheeh');
    setupSurahAudio();

    getMyFont();
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  void setupSurahAudio() {
    if (widget.surahIndex <= 9) {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio.network(
                'https://server6.mp3quran.net/a_ahmed/00${widget.surahIndex}.mp3',
                metas: Metas(
                  title: widget.surahName,
                  artist: 'Ahmed',
                ))
          ]),
          showNotification: true,
          autoStart: false);
    } else if (widget.surahIndex <= 99) {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio.network(
                'https://server6.mp3quran.net/a_ahmed/0${widget.surahIndex}.mp3',
                metas: Metas(
                  title: widget.surahName,
                  artist: 'Ahmed',
                ))
          ]),
          showNotification: true,
          autoStart: false);
    } else {
      assetsAudioPlayer.open(
          Playlist(audios: [
            Audio.network(
                'https://server6.mp3quran.net/a_ahmed/${widget.surahIndex}.mp3',
                metas: Metas(
                  title: widget.surahName,
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

  List<String> translations = [
    'Urdu',
    'English',
    'German',
    'French',
    'Spanish',
    'Turkish',
    'Persian',
    'Pashto',
  ];

  List<String> translationsNickName = [
    'urdu_junagarhi',
    'english_saheeh',
    'german_bubenheim',
    'french_montada',
    'spanish_garcia',
    'turkish_rwwad',
    'persian_ih',
    'pashto_zakaria',
  ];

  Future<List<dynamic>> getSurahList({String transWord}) async {
    String url =
        'https://quranenc.com/api/translation/sura/$transWord/${widget.surahIndex}';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['result'];
  }

  final dbHelper = DatabaseHelper.instance;

  void hideKeyboard(BuildContext context) {
    SystemChannels.textInput.invokeMethod('TextInput.hide');
    FocusScope.of(context).requestFocus(FocusNode());
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
    print(widget.surahIndex);
    void _insert(String ayaText, String ayaTranslation, String ayaNo) async {
      Map<String, dynamic> row = {
        DatabaseHelper.columnAyatNumber: ayaNo,
        DatabaseHelper.columnChapterNo: widget.surahIndex,
        DatabaseHelper.columnAyatText: ayaText,
        DatabaseHelper.columnAyatTranslation: ayaTranslation,
        DatabaseHelper.columnChapterName: widget.surahName,
      };
      final id = await dbHelper.insert(row);
      print('inserted row id: $id');
    }

    void _query() async {
      final allRows = await dbHelper.queryAllRows();
      print('query all rows:');
      allRows.forEach((row) => print(row));
    }

    return SafeArea(
      child: Scaffold(
        body: Container(
            height: MediaQuery.of(context).size.height,
            child: Stack(
              children: [
                Container(
                    height: MediaQuery.of(context).size.height,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(height: 60),
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
                                      child: Image.asset("assets/menuIcon.png"),
                                    );
                                  }),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: 10),
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       SizedBox(
                          //         width: 10,
                          //       ),
                          //       Text("${widget.surahName}", style: TextStyle(fontSize: 16)),
                          //       Spacer(),
                          //       Container(child: assetsAudioPlayer.builderIsPlaying(
                          //           builder: (context, isPlaying) {
                          //         return Row(
                          //           mainAxisAlignment: MainAxisAlignment.center,
                          //           crossAxisAlignment: CrossAxisAlignment.center,
                          //           children: [
                          //             IconButton(
                          //                 onPressed: () =>
                          //                     isPlaying ? pauseMusic() : playMusic(),
                          //                 icon: Icon(
                          //                   isPlaying == false
                          //                       ? Icons.play_circle_fill
                          //                       : Icons.pause_circle_filled,
                          //                   size: 30,
                          //                 )),
                          //           ],
                          //         );
                          //       }))
                          //     ],
                          //   ),
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
                          // Container(
                          //   child: DropDownField(
                          //     hintText: "Select Translation",
                          //     hintStyle: const TextStyle(
                          //         fontSize: 16,
                          //         color: Colors.grey,
                          //         fontWeight: FontWeight.w400),
                          //     enabled: true,
                          //     items: translationsNickName,
                          //     onValueChanged: (value) {
                          //       setState(() {
                          //         translateDropDownValue = value;
                          //       });
                          //     },
                          //   ),
                          // ),

                          Container(
                            height: 560,
                            width: MediaQuery.of(context).size.width * 0.90,
                            decoration: BoxDecoration(
                                color:
                                    _isDarkMode ? Colors.white : Colors.black,
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: FutureBuilder<List<dynamic>>(
                              future: getSurahList(
                                  transWord: translateDropDownValue),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      // GestureDetector(
                                      //   onTap:(){
                                      //     hideKeyboard(context);
                                      //   },
                                      //   child: Container(
                                      //
                                      //     child: DropDownField(
                                      //       hintText: "Select Translation",
                                      //       hintStyle: const TextStyle(
                                      //           fontSize: 14,
                                      //           color: AppColors.greenColors,
                                      //           fontWeight: FontWeight.w400),
                                      //       enabled: true,
                                      //       items: translationsNickName,
                                      //
                                      //       onValueChanged: (value) {
                                      //         setState(() {
                                      //
                                      //           translateDropDownValue = value;
                                      //         });
                                      //       },
                                      //     ),
                                      //   ),
                                      // ),
                                      Padding(
                                        padding: const EdgeInsets.all(5.0),
                                        child: Text(
                                          "Surah ${widget.surahIndex}",
                                          style: TextStyle(
                                            fontSize: 14,
                                            color: _isDarkMode
                                                ? Color(0xff025241)
                                                : Colors.white,
                                          ),
                                        ),
                                      ),
                                      Text("${widget.surahName}",
                                          style: TextStyle(
                                              fontSize: 18,
                                              color: _isDarkMode
                                                  ? Color(0xff025241)
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold)),

                                      Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            //if({widget.surahName}== 'Al-Fatihah')  else
                                            Image.asset(
                                              "assets/Bismillah.png",
                                              scale: 1.2,
                                            ),
                                            // widget.surahName == 'Al-Fatihah'
                                            //     ? SizedBox()
                                            //     :

                                            // Padding(
                                            //     padding:
                                            //         const EdgeInsets.all(
                                            //             8.0),
                                            //     child: Text(
                                            //       "بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                                            //       maxLines: 2,
                                            //       style: fonts[myindex](
                                            //         fontSize: 30.0,
                                            //         // fontFamily:
                                            //         //     'Noor-e-Hidayat',
                                            //         color: _isDarkMode
                                            //             ? Color(
                                            //                 0xff025241)
                                            //             : Colors.white,
                                            //         fontWeight:
                                            //             FontWeight.w800,
                                            //       ),
                                            //       textAlign:
                                            //           TextAlign.end,
                                            //     ),
                                            //   ),
                                            // Align(
                                            //   alignment: Alignment.centerLeft,
                                            //   child: Padding(
                                            //     padding: const EdgeInsets.all(8.0),
                                            //     child: Text(
                                            //       "In the name of God, the Most Gracious, the Most Merciful",
                                            //       style: TextStyle(
                                            //           color: _isDarkMode ? Color(0xff025241): Colors.white
                                            //       ),
                                            //       textAlign: TextAlign.left,
                                            //     ),
                                            //   ),
                                            // ),
                                          ],
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),
                                      Align(
                                        alignment: Alignment.centerRight,
                                        child: Container(
                                          height: 40,
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width *
                                              0.48,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 5),
                                          decoration: BoxDecoration(
                                            color: AppColors.boxColors,
                                            borderRadius: BorderRadius.only(
                                              topLeft: Radius.circular(25),
                                              bottomLeft: Radius.circular(25),
                                            ),
                                            border: Border.all(
                                                color: Colors.blueGrey,
                                                width: 1,
                                                style: BorderStyle.solid),
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Icon(
                                                Icons.language,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                              Flexible(
                                                child: DropdownButton<String>(
                                                  focusColor: Colors.white,
                                                  value: translateDropDownValue,
                                                  dropdownColor:
                                                      AppColors.boxColors,
                                                  //elevation: 5,
                                                  style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 16,
                                                  ),
                                                  iconEnabledColor:
                                                      AppColors.boxColors,
                                                  iconDisabledColor:
                                                      AppColors.boxColors,
                                                  underline:
                                                      DropdownButtonHideUnderline(
                                                          child: Container()),
                                                  items: translationsNickName
                                                      .asMap()
                                                      .entries
                                                      .map<
                                                          DropdownMenuItem<
                                                              String>>((entry) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: entry.value,
                                                      child: Text(
                                                        translations[entry.key],
                                                        style: TextStyle(
                                                          color: Colors.white,
                                                          fontSize: 18,
                                                        ),
                                                        maxLines: 1,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    );
                                                  }).toList(),
                                                  selectedItemBuilder:
                                                      (BuildContext context) =>
                                                          translationsNickName
                                                              .asMap()
                                                              .entries
                                                              .map(
                                                                  (e) => Center(
                                                                        child:
                                                                            Text(
                                                                          translations[
                                                                              e.key],
                                                                          style:
                                                                              TextStyle(
                                                                            color:
                                                                                Colors.white,
                                                                            fontSize:
                                                                                18,
                                                                          ),
                                                                          textAlign:
                                                                              TextAlign.end,
                                                                        ),
                                                                      ))
                                                              .toList(),
                                                  // hint: Text(
                                                  //   "Translation Language",
                                                  //   style: TextStyle(
                                                  //       color: Colors.black,
                                                  //       fontSize: 12,
                                                  //       fontWeight:
                                                  //           FontWeight.w500),
                                                  // ),
                                                  onChanged: (String value) {
                                                    setState(() {
                                                      translateDropDownValue =
                                                          value;
                                                    });
                                                  },
                                                ),
                                              ),
                                              Icon(
                                                Icons.keyboard_arrow_down,
                                                size: 25,
                                                color: Colors.white,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        height: 2,
                                      ),

                                      Expanded(
                                        child: InteractiveViewer(
                                          child: ListView.builder(
                                            shrinkWrap: true,
                                            itemCount:
                                                widget.surahName == 'Al-Fatihah'
                                                    ? snapshot.data?.length - 1
                                                    : snapshot.data?.length,
                                            itemBuilder: (context, index) {
                                              String arabicName = "";
                                              String translation = "";
                                              String ayaNo = "";

                                              if (widget.surahName ==
                                                  'Al-Fatihah') {
                                                arabicName =
                                                    snapshot.data[index + 1]
                                                        ['arabic_text'];
                                                translation =
                                                    snapshot.data[index + 1]
                                                        ['translation'];
                                                ayaNo = (index + 1).toString();
                                              } else {
                                                arabicName = snapshot
                                                    .data[index]['arabic_text'];
                                                translation = snapshot
                                                    .data[index]['translation'];
                                                ayaNo = (index + 1).toString();
                                              }
                                              return Column(
                                                children: [
                                                  FocusedMenuHolder(
                                                    menuItems: <
                                                        FocusedMenuItem>[
                                                      FocusedMenuItem(
                                                          title:
                                                              Text("Bookmark"),
                                                          onPressed: () {
                                                            _insert(
                                                                arabicName,
                                                                translation,
                                                                ayaNo);
                                                          },
                                                          trailingIcon: Icon(
                                                              Icons.bookmark)),
                                                      // FocusedMenuItem(
                                                      //     title: Text("Favourite"),
                                                      //     onPressed: () {},
                                                      //     trailingIcon: Icon(
                                                      //       Icons.favorite,
                                                      //       color: Colors.red,
                                                      //     )),
                                                    ],
                                                    onPressed: () {
                                                      _query();
                                                    },
                                                    child: Padding(
                                                      padding: const EdgeInsets
                                                              .symmetric(
                                                          horizontal: 0),
                                                      child: Column(
                                                        // crossAxisAlignment:
                                                        //     CrossAxisAlignment.end,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .end,
                                                        children: [
                                                          Container(
                                                            child: Row(
                                                              // crossAxisAlignment:
                                                              //     CrossAxisAlignment
                                                              //         .center,
                                                              mainAxisAlignment:
                                                                  MainAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Container(
                                                                  width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width *
                                                                      0.75,
                                                                  padding:
                                                                      const EdgeInsets
                                                                          .only(
                                                                    right: 16.0,
                                                                    left: 5,
                                                                  ),
                                                                  child: Text(
                                                                    arabicName,
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
                                                                          ? Colors
                                                                              .black
                                                                          : Colors
                                                                              .white,
                                                                    ),
                                                                    textAlign:
                                                                        TextAlign
                                                                            .end,
                                                                    // style: fonts[myindex](
                                                                    //     fontSize: 18.0,

                                                                    //     color: _isDarkMode
                                                                    //         ? Colors
                                                                    //             .black
                                                                    //         : Colors
                                                                    //             .white,
                                                                    //     fontWeight:
                                                                    //         FontWeight
                                                                    //             .w800),
                                                                  ),
                                                                ),
                                                                Container(
                                                                  margin: const EdgeInsets
                                                                          .only(
                                                                      right:
                                                                          8.0,
                                                                      left:
                                                                          8.0),
                                                                  height: 20,
                                                                  width: 20,
                                                                  alignment:
                                                                      Alignment
                                                                          .center,
                                                                  decoration: BoxDecoration(
                                                                      borderRadius:
                                                                          BorderRadius.circular(
                                                                              20),
                                                                      color: Colors
                                                                          .white,
                                                                      border: Border.all(
                                                                          color: _isDarkMode
                                                                              ? Color(0xff5FBEAA)
                                                                              : Colors.black,
                                                                          width: 1)),
                                                                  child: Center(
                                                                    child: Text(
                                                                      ayaNo,
                                                                      style: TextStyle(
                                                                          fontSize:
                                                                              10,
                                                                          color: _isDarkMode
                                                                              ? Color(0xff5FBEAA)
                                                                              : Colors.black),
                                                                    ),
                                                                  ),
                                                                ),
                                                              ],
                                                            ),
                                                          ),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Container(
                                                              width:
                                                                  MediaQuery.of(
                                                                          context)
                                                                      .size
                                                                      .width,
                                                              decoration: BoxDecoration(
                                                                  border: Border.all(
                                                                      width:
                                                                          0.2,
                                                                      color: AppColors
                                                                          .boxColors)),
                                                              padding:
                                                                  const EdgeInsets
                                                                      .all(8.0),
                                                              child: Text(
                                                                translation,
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        14.0,
                                                                    fontFamily:
                                                                        'Noto Sans Arabic',
                                                                    color: _isDarkMode
                                                                        ? Color(
                                                                            0xff025241)
                                                                        : Colors
                                                                            .white),
                                                                textAlign:
                                                                    TextAlign
                                                                        .left,
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ),
                                                  SizedBox(height: 8)
                                                ],
                                              );
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  );
                                }
                                return Center(
                                    child: CircularProgressIndicator());
                              },
                            ),
                          ),
                          SizedBox(
                            height: 100,
                          ),
                        ],
                      ),
                    ),
                    decoration: _isDarkMode
                        ? BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                "assets/background.png",
                              ),
                              fit: BoxFit.cover,
                            ),
                          )
                        : BoxDecoration(color: Colors.black)),
                // Align(
                //     alignment: Alignment.bottomCenter,
                //     child: Image.asset('assets/lavender.png', color: AppColors.greenColors, height: MediaQuery.of(context).size.height*0.15, width: MediaQuery.of(context).size.width*0.30,)),

                Positioned(
                  bottom: 0,
                  left: 10,
                  child: Container(
                    height: 150,
                    width: 190,
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
                                      " ${widget.surahName}",
                                      style: TextStyle(
                                          color: Color(0xff025241),
                                          fontSize: 16,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  // Spacer(),
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
                //     child: RotationTransition(
                //       turns: AlwaysStoppedAnimation(-1 / 2),
                //       child: Image.asset(
                //         'assets/bottomleft.png',
                //         color: AppColors.greenColors,
                //         height: MediaQuery.of(context).size.height * 0.12,
                //         width: MediaQuery.of(context).size.width * 0.29,
                //       ),
                //     )),
                // Align(
                //     alignment: Alignment.topRight,
                //     child: Image.asset(
                //       'assets/topright.png',
                //       color: AppColors.greenColors,
                //       height: MediaQuery.of(context).size.height * 0.12,
                //       width: MediaQuery.of(context).size.width * 0.29,
                //     )),
              ],
            )),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerScreen(),
      ),
    );
  }
}
//
// class NewDrawer extends StatefulWidget{
//   @override
//   _NewDrawerState createState() => _NewDrawerState();
// }
//
// class _NewDrawerState extends State<NewDrawer> {
//   String translateDropDownValue = "english_saheeh";
//
//   void getDropDownItem() {
//     setState(() {
//       translateDropDownValue = translateDropDownValue;
//       print("Here is value" + translateDropDownValue);
//     });
//   }
//   List<String> translationsNickName = [
//     'urdu_junagarhi',
//     'english_saheeh',
//     'german_bubenheim',
//     'french_montada',
//     'spanish_garcia',
//     'turkish_rwwad',
//     'persian_ih',
//     'pashto_zakaria',
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return ClipRRect(
//
//       borderRadius: BorderRadius.circular(10),
//       child: Theme(
//         data: Theme.of(context).copyWith(
//           canvasColor: AppColors.greenColors,
//         ),
//         child: Drawer(
//
//           child: SafeArea(
//             child: ListView(
//               children: [
//                 Image.asset(
//                   'assets/logo.png',
//                   width: 140,
//                   height: 140,
//                 ),
//                 SizedBox(
//                   height: getScreenHeight(30),
//                 ),
//                 Padding(
//                   padding: EdgeInsets.only(left: 35),
//                   child: Container(
//                     height: 2.0,
//                     width: MediaQuery.of(context).size.width,
//                     color: Colors.white.withOpacity(0.2),
//                   ),
//                 ),
//
//
//                 SizedBox(
//                   height: getScreenHeight(20),
//                 ),
//                 DrawerItem(
//                   title: 'Book Marks',
//                   icon: Icons.bookmark,
//                   onTap: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute(
//                         builder: (context) {
//                           return GetAllBookmarks();
//                         },
//                       ),
//                     );
//                   },
//                 ),
//                 SizedBox(
//                   height: getScreenHeight(20),
//                 ),
//
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
