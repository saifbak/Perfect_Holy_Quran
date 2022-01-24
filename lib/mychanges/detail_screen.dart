import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/mychanges/sura_in_juz_list.dart';
import 'package:perfectholyquran/mychanges/sura_screen_tab.dart';
import 'package:perfectholyquran/views/quran_juzz_screen.dart';

class DetailScreen extends StatefulWidget {
  String juzzArabic;
  int index;

  DetailScreen(this.index, this.juzzArabic);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(children: [
        Column(
          children: [
            Expanded(
              flex: 2,
              child: Container(
                child: Row(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        "Perfect Holy Quran",
                        style: TextStyle(
                            fontSize: 24.0,
                            fontWeight: FontWeight.w700,
                            color: Color(0xff025241)),
                      ),
                    ),
                    Spacer(),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(CupertinoIcons.ellipsis_vertical))
                  ],
                ),
              ),
            ),
            SingleChildScrollView(
              child: Center(
                child: Card(
                  child: Column(
                    children: [],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 2,
              child: Center(
                child: Text(
                  widget.juzzArabic.toString(),
                  style: TextStyle(
                      fontSize: 16.0,
                      fontWeight: FontWeight.w700,
                      fontStyle: FontStyle.italic,
                      color: Color(0xff025241)),
                ),
              ),
            ),
            // SizedBox(height: 10,),
            Flexible(
              fit: FlexFit.loose,
              flex: 6,
              child: Column(
                children: [
                  for (var item in Juz[widget.index])
                    Flexible(
                        fit: FlexFit.loose, flex: 2, child: SurahBuilder(item))
                  // SizedBox(height: 10,),
                  // for ( var i in Juz[widget.index] )
                  // for (var items in i)
                  //   // print(items);
                  // Expanded(
                  //   flex: 6,
                  //   child: SuraBox(items))

                  // Expanded(
                  //   flex: 6,
                  //   child: ListView.builder(
                  //     // itemExtent: 10.0,
                  //     itemCount: 20,
                  //     itemBuilder: (context,index){
                  //       return
                  //          Padding(
                  //           padding: const EdgeInsets.only(bottom: 10,left: 160),
                  //           // child: ExpansionTileCard(
                  //           //   baseColor: Color(0xff5FBEAA),
                  //           //   title: Center(child: Text("Surah ${index+1}")),
                  //           //   borderRadius: BorderRadius.horizontal(left: Radius.circular(20)),
                  //           //   leading: Image(image: AssetImage("assets/playbtnw.png")),
                  //           //   children: [
                  //           //     Text("بِسۡمِ ٱللَّهِ ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ ١"),
                  //           //     Text("ٱلۡحَمۡدُ لِلَّهِ رَبِّ ٱلۡعَـٰلَمِینَ ٢"),
                  //           //     Text("ٱلرَّحۡمَـٰنِ ٱلرَّحِیمِ ٣"),
                  //           //     Text("مَـٰلِكِ یَوۡمِ ٱلدِّینِ ٤"),
                  //           //     Text("إِیَّاكَ نَعۡبُدُ وَإِیَّاكَ نَسۡتَعِینُ ٥"),
                  //           //     Text("ٱهۡدِنَا ٱلصِّرَ ٰ⁠طَ ٱلۡمُسۡتَقِیمَ ٦"),
                  //           //     Text("صِرَ ٰ⁠طَ ٱلَّذِینَ أَنۡعَمۡتَ عَلَیۡهِمۡ غَیۡرِ ٱلۡمَغۡضُوبِ عَلَیۡهِمۡ وَلَا ٱلضَّاۤلِّینَ ٧"),
                  //           //   ],

                  //           // ),
                  //           child: SuraBox(index),

                  //       //  Container(child: visibleContainer(true)),

                  //       );

                  //     }
                  //     ),

                  // ),
                ],
              ),
            ),
            // Stack( children: [
            //   // Player(),
            // ],),

            // FloatingActionButton(onPressed: (){},
            // child: Container(
            //   child: Player(),
            // ),
            // )
          ],
        ),
        // Positioned(
        //      //  right: 5,
        //       top: MediaQuery.of(context).size.height/1.35,
        //       bottom:0,
        //       child: Expanded(child: Player())),
      ]),
    );
  }
}

// class SuraBox extends StatefulWidget {

// int index;
//   SuraBox(this.index);

//   @override
//   _SuraBoxState createState() => _SuraBoxState();
// }

// class _SuraBoxState extends State<SuraBox> {
//   bool btnpress=false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.start,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         mainAxisSize: MainAxisSize.min,
//         children:[ Container(

//         child: Row(
//           children: [
//           // SizedBox(width: 10,),
//           CircleAvatar(
//             radius: 15,
//             // maxRadius: 10,
//             backgroundColor: Colors.white,
//             child: IconButton(iconSize: 15, onPressed: (){}, icon: Icon(CupertinoIcons.play_fill,color: Color(0xff025241),)),
//           ),
//           SizedBox(width: 10,),
//           Text("Sura ${widget.index+1}",style: TextStyle(fontSize: 16)),
//           Spacer(),
//           IconButton(onPressed: (){
//              setState(() {
//           if (btnpress) {
//             btnpress=false;

//           } else {
//             btnpress=true;

//           }

//         });
//           },
//            icon: btnpress ? Icon(CupertinoIcons.chevron_down):Icon(CupertinoIcons.chevron_up))

//         ],),
//         width: 200,
//         height: 30,
//         decoration: BoxDecoration(
//          color: Color(0xff5FBEAA),
//          borderRadius:BorderRadius.only(
//            topLeft: Radius.circular(30),
//            bottomLeft: Radius.circular(30.0),
//          ),
//         ),
//         ),
//          Expanded(
//            flex: 6,
//            child: Visibility(
//             //  maintainAnimation: true,
//             //  maintainInteractivity: true,
//             visible: btnpress,
//             child:SurahBuilder(widget.index),
//             // replacement: Expanded(
//             //   flex: 5,
//             //   child: Container()),

//             ),
//          )
//         ]
//       ),
//     );
//   }

// }

class Player extends StatefulWidget {
  @override
  _PlayerState createState() => _PlayerState();
}

class _PlayerState extends State<Player> {
  double _sliderValue = 20;

  @override
  Widget build(BuildContext context) {
    // final assetsAudioPlayer = AssetsAudioPlayer();

    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
              // alignment: Alignment.bottomCenter,
              children: [
                Card(
                  elevation: 2.0,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Container(
                      clipBehavior: Clip.none,
                      width: 180,
                      height: 165,
                      //BoxDecoration Widget
                      decoration: BoxDecoration(
                        color: Colors.white,

                        // image: const DecorationImage(
                        //   image: NetworkImage(
                        //       'https://media.geeksforgeeks.org/wp-content/cdn-uploads/20190710102234/download3.png'),
                        //   fit: BoxFit.cover,
                        // ), //DecorationImage
                        border: Border.all(
                          color: Color(0xff5FBEAA),
                          width: 8,
                        ), //Border.all
                        borderRadius: BorderRadius.circular(30),
                      ),
                    ),
                  ),
                ),

                // Align(
                //    alignment: Alignment.bottomCenter,
                //    child:
                //  ),
                Positioned(
                    // width: 150,
                    // right: 5,
                    top: 30,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 12.0),
                          child: Text(
                            "Now Playing",
                            style: TextStyle(
                              color: Color(0xff025241),
                              fontSize: 12,
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15.0, vertical: 4.0),
                          child: Text(
                            "Al Fatheha",
                            style: TextStyle(
                                color: Color(0xff025241),
                                fontSize: 16,
                                fontWeight: FontWeight.w700),
                          ),
                        ),
                      ],
                    )),
                Positioned(
                  top: 90,
                  // bottom: 0,
                  child: Container(
                    width: 180,
                    child: Slider(
                      activeColor: Color(0xff025241),
                      inactiveColor: Colors.grey,
                      value: _sliderValue,
                      min: 0,
                      max: 100,
                      label: _sliderValue.round().toString(),
                      onChanged: (value) {
                        setState(() {
                          _sliderValue = value;
                        });
                      },
                    ),
                  ),
                ),

                Positioned(
                  top: 130,
                  // left: 2,
                  child: Stack(
                    // alignment: Alignment.bottomCenter,
                    children: [
                      Positioned(
                        //  top: 140,

                        child: Container(
                          width: 190,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius:
                                  BorderRadiusDirectional.circular(30)),
                        ),
                      ),
                      Positioned(
                        left: 60,
                        child: Container(
                          child: Row(
                            children: [
                              Image.asset(
                                "assets/reverseicon.png",
                                scale: 3.0,
                              ),
                              Image.asset(
                                "assets/reverseicon.png",
                                scale: 3.0,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                "assets/playbtn.png",
                                scale: 2.5,
                                alignment: Alignment.bottomCenter,
                              ),
                              SizedBox(
                                width: 8,
                              ),
                              Image.asset(
                                "assets/farwardicon.png",
                                scale: 3.0,
                              ),
                              Image.asset(
                                "assets/farwardicon.png",
                                scale: 3.0,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                Positioned(
                    //  right: 5,
                    top: MediaQuery.of(context).size.height / 1.35,
                    child: Player()),
              ]),
        ],
      ),
    );
    //BoxDecoration
    // /Container
  }
}
