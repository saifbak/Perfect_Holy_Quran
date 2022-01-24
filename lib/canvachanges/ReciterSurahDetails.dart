import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:assets_audio_player/assets_audio_player.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/views/drawer_screen.dart';

class RecitersSurahDetail extends StatefulWidget {
  int surahIndex;
  String surahName;
  String reciterName;

  RecitersSurahDetail({this.surahIndex, this.surahName, this.reciterName});

  @override
  _RecitersSurahDetailState createState() => _RecitersSurahDetailState();
}

class _RecitersSurahDetailState extends State<RecitersSurahDetail> {
  AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();

  @override
  void initState() {
    super.initState();
    setupSurahAudio();
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
                'https://server6.mp3quran.net/${widget.reciterName}/00${widget.surahIndex}.mp3',
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
                'https://server6.mp3quran.net/${widget.reciterName}/0${widget.surahIndex}.mp3',
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
                'https://server6.mp3quran.net/${widget.reciterName}/${widget.surahIndex}.mp3',
                metas: Metas(
                  title: widget.surahName,
                  artist: 'Ahmed',
                ))
          ]),
          showNotification: true,
          autoStart: true);
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

  Future<List<dynamic>> getSurahList() async {
    String url =
        'https://quranenc.com/api/translation/sura/english_saheeh/${widget.surahIndex}';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['result'];
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        //appBar: AppBar(title: Text(widget.reciterName + widget.surahName +widget.surahIndex.toString()),),
        body: Stack(
          children: [
            Container(
                decoration: _isDarkMode
                    ? BoxDecoration(
                        image: DecorationImage(
                        image: AssetImage(
                          "assets/background.png",
                        ),
                        fit: BoxFit.cover,
                      ))
                    : BoxDecoration(color: Colors.black)),
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
            SingleChildScrollView(
              child: Column(
                children: [
                  // SizedBox(height: 32),
                  SizedBox(
                    height: 60,
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                        },
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 25,
                          color: _isDarkMode
                              ? AppColors.greenColors
                              : Colors.white,
                        ),
                      ),
                      Text(
                        "Perfect Holy Quran",
                        style: TextStyle(
                            color: _isDarkMode
                                ? AppColors.greenColors
                                : Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                      Builder(builder: (context) {
                        return InkWell(
                          onTap: () {
                            Scaffold.of(context).openDrawer();
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(top: 8.0),
                            child: Image.asset(
                              "assets/menuIcon.png",
                            ),
                          ),
                        );
                      }),
                    ],
                  ),
                  SizedBox(
                    height: 10,
                  ),

                  // : Padding(
                  //     padding: const EdgeInsets.all(8.0),
                  //     child: Text(
                  //       "بِسْمِ ٱللَّٰهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                  //       maxLines: 2,
                  //       style: TextStyle(
                  //           fontSize: 16.0,
                  //           // fontFamily:
                  //           //     'Noor-e-Hidayat',
                  //           color:
                  //               _isDarkMode ? Colors.black : Colors.white,
                  //           fontWeight: FontWeight.w800),
                  //       textAlign: TextAlign.end,
                  //     ),
                  //   ),
                  // Container(
                  //   child: Row(
                  //     children: [
                  //       SizedBox(
                  //         width: 10,
                  //       ),
                  //       Text("${widget.surahName}", style: TextStyle(fontSize: 16)),
                  //       Spacer(),
                  //       Container(child: assetsAudioPlayer.builderIsPlaying(builder: (context, isPlaying) {
                  //         return Row(
                  //           mainAxisAlignment: MainAxisAlignment.center,
                  //           crossAxisAlignment: CrossAxisAlignment.center,
                  //           children: [
                  //             IconButton(
                  //                 onPressed: () => isPlaying ? pauseMusic() : playMusic(),
                  //                 icon: Icon(
                  //                   isPlaying == false ? Icons.play_circle_fill : Icons.pause_circle_filled,
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

                  FutureBuilder<List<dynamic>>(
                    future: getSurahList(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return Container(
                          height: 540,
                          margin: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          color: Colors.white,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text("${widget.surahName}",
                                  style: TextStyle(
                                      fontSize: 20,
                                      color: _isDarkMode
                                          ? AppColors.greenColors
                                          : Colors.white,
                                      fontWeight: FontWeight.bold)),
                              widget.surahName == 'الفاتحة'
                                  ? SizedBox()
                                  : Image.asset(
                                      "assets/Bismillah.png",
                                      scale: 1.2,
                                    ),
                              Expanded(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  itemCount: snapshot.data?.length,
                                  itemBuilder: (context, index) {
                                    var arabicName =
                                        snapshot.data[index]['arabic_text'];
                                    var translation =
                                        snapshot.data[index]['translation'];
                                    return GestureDetector(
                                      child: Padding(
                                        padding: const EdgeInsets.all(4.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: Text(
                                                "" + arabicName,
                                                maxLines: 2,
                                                style: TextStyle(
                                                    fontSize: 18,
                                                    color: _isDarkMode
                                                        ? AppColors.greenColors
                                                        : Colors.white,
                                                    fontWeight:
                                                        FontWeight.bold),
                                                textAlign: TextAlign.end,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        );
                      }
                      return Center(child: CircularProgressIndicator());
                    },
                  ),
                ],
              ),
            ),
            Positioned(
              bottom: 0,
              left: 15,
              child: Container(
                height: 120,
                width: 160,
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
                          width: MediaQuery.of(context).size.width * 0.45,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20)),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 5),
                                width: MediaQuery.of(context).size.width * 0.42,
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
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold),
                                ),
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
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
        ),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerScreen(),
      ),
    );
  }
}
