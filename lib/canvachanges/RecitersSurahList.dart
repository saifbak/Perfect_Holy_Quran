import 'dart:convert';

import 'package:assets_audio_player/assets_audio_player.dart';
//import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

import 'ReciterSurahDetails.dart';
import 'package:perfectholyquran/views/drawer_screen.dart';

class ReciterSurahList extends StatefulWidget {
  String nickName;
  String reciterFullName;

  ReciterSurahList(this.nickName, this.reciterFullName);

  @override
  _ReciterSurahListState createState() => _ReciterSurahListState();
}

class _ReciterSurahListState extends State<ReciterSurahList> {
  AssetsAudioPlayer assetsAudioPlayer = new AssetsAudioPlayer();

  bool playing = false;
  bool surahPlaying = false;
  int _selectedIndex = 0;
  bool btnpress = true;

  Future<List<dynamic>> getSurahList() async {
    String url = 'https://api.quran.com/api/v4/chapters';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    return json.decode(response.body)['chapters'];
  }

  @override
  void initState() {
    super.initState();
    setupSurahAudio(1);
  }

  @override
  void dispose() {
    super.dispose();
    assetsAudioPlayer.dispose();
  }

  void setupSurahAudio(int surahNo) {
    assetsAudioPlayer.open(
        Playlist(audios: [
          Audio.network(
              'https://server6.mp3quran.net/${widget.nickName}/00${surahNo}.mp3',
              metas: Metas(
                title: widget.nickName,
                artist: 'Ahmed',
              ))
        ]),
        showNotification: true,
        autoStart: false);
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

/*  _getVideo( int surahNo) async  {
    var url = 'https://server6.mp3quran.net/${widget.nickName}/00${surahNo}.mp3';
    playing = false;
    Fluttertoast.showToast(msg: url, toastLength: Toast.LENGTH_LONG, gravity: ToastGravity.BOTTOM, timeInSecForIosWeb: 1, backgroundColor: Colors.white60, textColor: Colors.black54, fontSize: 12.0);


    if (surahPlaying) {
      var res =  await _audioPlayer.pause();
      if (res == 1) {
        setState(() {
          surahPlaying = false;
        });
      }
    } else {
      var res = await _audioPlayer.play(url, isLocal: true);
      if (res == 1) {
        setState(() {
          surahPlaying = true;
        });
      }
    }

  }*/

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(title: Text(widget.reciterFullName), backgroundColor: AppColors.greenColors,),
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
            Container(
              child: SingleChildScrollView(
                child: FutureBuilder<List<dynamic>>(
                  future: getSurahList(),
                  builder: (context, snapshot) {
                    if (snapshot.hasData) {
                      return Column(
                        children: [
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
                          Text(
                            widget.reciterFullName,
                            style: TextStyle(
                                color: _isDarkMode
                                    ? AppColors.greenColors
                                    : Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Container(
                              height: MediaQuery.of(context).size.height * 0.65,
                              // color: Colors.black12,
                              child: ListView.builder(
                                shrinkWrap: true,
                                itemCount: snapshot.data?.length,
                                itemBuilder: (context, index) {
                                  var arabicName =
                                      snapshot.data[index]['name_arabic'];
                                  var id = snapshot.data[index]['id'];
                                  var englishName =
                                      snapshot.data[index]['name_simple'];

                                  return GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                RecitersSurahDetail(
                                              surahName: arabicName,
                                              surahIndex: id,
                                              reciterName: widget.nickName,
                                            ),
                                          ),
                                        );
                                      },
                                      child: Card(
                                        elevation: 0.0,
                                        color: _selectedIndex == index
                                            ? AppColors.boxColors
                                            : Colors.white,
                                        child: ListTile(
                                          hoverColor: AppColors.boxColors,
                                          autofocus: true,
                                          dense: true,
                                          leading: InkWell(
                                            onTap: () {
                                              setState(() {
                                                _selectedIndex = index;
                                              });
                                            },
                                            child: Wrap(
                                              children: [
                                                //Text("${index + 1}."),
                                                SizedBox(
                                                  width: 2,
                                                ),
                                                Text(
                                                  id.toString() +
                                                      "." +
                                                      " " +
                                                      englishName,
                                                  style: TextStyle(
                                                    fontWeight: FontWeight.w500,
                                                    color: _selectedIndex !=
                                                            index
                                                        ? AppColors.greenColors
                                                        : Colors.white,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          trailing: Text(
                                            arabicName,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              color: _selectedIndex != index
                                                  ? AppColors.greenColors
                                                  : Colors.white,
                                            ),
                                          ),
                                        ),
                                      ));
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: 20)
                        ],
                      );
                    }
                    return Center(child: CircularProgressIndicator());
                  },
                ),
              ),
            )
          ],
        ),
        drawerEnableOpenDragGesture: true,
        drawer: DrawerScreen(),
      ),
    );
  }
}
