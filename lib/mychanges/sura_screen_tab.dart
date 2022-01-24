import 'package:arabic_numbers/arabic_numbers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectholyquran/models/sura_audio.dart';
import 'package:perfectholyquran/mychanges/quran_api.dart';
import 'package:perfectholyquran/mychanges/sura_in_juz_list.dart';
import 'package:perfectholyquran/mychanges/sura_list_model.dart';
import 'package:perfectholyquran/mychanges/surah_model.dart';
import 'package:perfectholyquran/providers/surahlist_provider.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/widgets/play_pause.dart';
import 'package:path_provider/path_provider.dart';

ArabicNumbers arabicNumber = ArabicNumbers();

class SurahScreenTab extends StatefulWidget {
  const SurahScreenTab({Key key}) : super(key: key);

  @override
  _SurahScreenTabState createState() => _SurahScreenTabState();
}

class _SurahScreenTabState extends State<SurahScreenTab> {
  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    //final surah = Provider
    return Scaffold(
        // appBar: AppBar(title: Text("Surahs"),),
        //body: SurahListProvider()

        /*FutureBuilder<List<Suralist>>(
          future: QuranAPI().readSurahlist(),
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            // print(snapshot.data.toString());
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            } else if (snapshot.connectionState == ConnectionState.done) {
              if (snapshot.hasError) {
                return Text(snapshot.error.toString());
              } else if (snapshot.hasData) {
                return ListView.builder(
                    itemCount: 114,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          _onSelected(index);
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => SuraDetailPage(index + 1)),
                          );
                        },
                        child: Card(
                          elevation: 4.0,
                          color: _selectedIndex != null && _selectedIndex == index ? AppColors.boxColors : Colors.white,
                          child: ListTile(
                            // title: Text(snapshot.data[index].title),
                            leading: Wrap(
                              children: [
                                Text("${index + 1}."),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(snapshot.data[index].title.toString()),
                              ],
                            ),
                            trailing: Text(snapshot.data[index].titleAr.toString()),
                          ),
                        ),
                      );
                    });
              }
            }
            return Text('State: ${snapshot.connectionState}');
          }),*/
        );
  }
}

class SuraDetailPage extends StatelessWidget {
  int index;

  SuraDetailPage(this.index);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SurahBuilder(index),
    );
  }
}

class SurahBuilder extends StatefulWidget {
  int index;

  SurahBuilder(this.index);

  @override
  _SurahBuilderState createState() => _SurahBuilderState();
}

class _SurahBuilderState extends State<SurahBuilder> {
  SuraAudio _suraAudio;

  // var suraudio;
  @override
  void initState() {
    super.initState();
    QuranAPI().Suraudio();
  }

  bool btnpress = true;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
          // mainAxisAlignment: MainAxisAlignment.start,
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: FutureBuilder(
                  future: QuranAPI().readSurah(widget.index),

                  // a previously-obtained Future<String> or null
                  builder:
                      (BuildContext context, AsyncSnapshot<Sura> snapshot) {
                    // print(snapshot.data!.name.toString());
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(child: CircularProgressIndicator());
                    } else if (snapshot.connectionState ==
                        ConnectionState.done) {
                      if (snapshot.hasError) {
                        return const Text('Error');
                      } else if (snapshot.hasData) {
                        return Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 1,
                                child: Container(
                                  child: Row(
                                    children: [
                                      // SizedBox(width: 10,),
                                      CircleAvatar(
                                        radius: 15,
                                        // maxRadius: 10,
                                        backgroundColor: Colors.white,
                                        child: PlayPause(
                                          url: audiolinks[widget.index]
                                              .toString(),
                                          isPressed: btnpress,
                                        ),
                                      ),
                                      SizedBox(
                                        width: 10,
                                      ),
                                      Text(
                                          "Sura ${snapshot.data.name.toString()}",
                                          style: TextStyle(fontSize: 16)),
                                      Spacer(),
                                      IconButton(
                                          onPressed: () {
                                            setState(() {
                                              if (btnpress) {
                                                btnpress = false;
                                              } else {
                                                btnpress = true;
                                              }
                                            });
                                          },
                                          icon: btnpress
                                              ? Icon(
                                                  CupertinoIcons.chevron_down)
                                              : Icon(CupertinoIcons.chevron_up))
                                    ],
                                  ),
                                  // width: 200,
                                  width: MediaQuery.of(context).size.width,
                                  height: 30,
                                  decoration: BoxDecoration(
                                    color: Color(0xff5FBEAA),
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(30),
                                      bottomLeft: Radius.circular(30.0),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex: 6,
                                child: Visibility(
                                  visible: btnpress,
                                  child: ListView.builder(
                                      itemCount: snapshot.data.count,
                                      itemBuilder: (context, index) {
                                        return Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Container(
                                            child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment.center,
                                                children: [
                                                  (index == 0)
                                                      ? Container()
                                                      : CircleAvatar(
                                                          backgroundColor:
                                                              AppColors
                                                                  .greenColors,
                                                          radius: (index > 99)
                                                              ? 15
                                                              : 10,
                                                          child: Text(
                                                            arabicNumber
                                                                .convert(index)
                                                                .toString(),
                                                          ),
                                                        ),
                                                  Flexible(
                                                    flex: 10,
                                                    fit: FlexFit.tight,
                                                    child: Text(
                                                      snapshot.data
                                                          .verse["verse_$index"]
                                                          .toString(),
                                                      textAlign:
                                                          TextAlign.start,
                                                      textDirection:
                                                          TextDirection.rtl,
                                                      style: GoogleFonts.farsan(
                                                        fontSize: 20.0,
                                                        fontWeight:
                                                            FontWeight.w500,
                                                        color: AppColors
                                                            .greenColors,
                                                      ),
                                                    ),
                                                  ),
                                                ]),
                                          ),
                                        );
                                      }),
                                ),
                              ),
                            ]);
                      } else {
                        return const Text('Empty data');
                      }
                    } else {
                      return Text('State: ${snapshot.connectionState}');
                    }
                  }),
            ),
          ]),
    );
  }
}
