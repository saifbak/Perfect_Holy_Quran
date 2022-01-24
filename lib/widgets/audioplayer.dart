
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';


// class MyAudioPlayer extends StatefulWidget {
//   @override
//   _MyAudioPlayerState createState() => _MyAudioPlayerState();
// }

// class _MyAudioPlayerState extends State<MyAudioPlayer>
//   with TickerProviderStateMixin {
//   AnimationController
//   iconController; // make sure u have flutter sdk > 2.12.0 (null safety)
//   bool isAnimated = false;
//   bool showPlay = true;
//   bool shopPause = false;
//   AssetsAudioPlayer audioPlayer = AssetsAudioPlayer();


//   @override
//   void initState() {
//     super.initState();

//     iconController = AnimationController(
//         vsync: this, duration: Duration(milliseconds: 1000)
//         );

//     audioPlayer.open(Audio('assets/quran/audio/001/001.mp3'),autoStart: false,);
//     // final assetsAudioPlayer = AssetsAudioPlayer();

// // try {
// //      audioPlayer.open(
    
// //         Audio("assets/quran/audio/001/001.mp3"),
// //         autoStart:false,

// //     );
// // } catch (t) {
// //     //mp3 unreachable
// // }
    
//   }


//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: AppBar(
//           centerTitle: true,
//           title: Text("Playing Audio File Flutter"),
//         ),
//         body: Center(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.center,
//             children: [
//               Image.network("https://i.pinimg.com/originals/f7/3a/5b/f73a5b4b7262440684a2b5c39e684304.jpg",width: 300,),
//               SizedBox(height: 30,),
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                  InkWell(child: Icon(CupertinoIcons.backward_fill),onTap: (){
//                    audioPlayer.seekBy(Duration(seconds: -10));
//                  },),
//                   GestureDetector(
//                     onTap: () {
//                       setState(() {
                        
//                       });
//                       AnimateIcon();
//                     },
//                     child: AnimatedIcon(
//                       icon: AnimatedIcons.play_pause,
//                       progress: iconController,
//                       size: 50,
//                       color: Colors.black,
//                     ),
//                   ),
//                   InkWell(child: Icon(CupertinoIcons.forward_fill),onTap: (){
//                     setState(() {
                      
//                     });
//                     audioPlayer.seekBy(Duration(seconds: 2));
//                     audioPlayer.seek(Duration(seconds: 2));
//                     audioPlayer.next();
//                   },),
//                 ],
//               ),

//             ],
//           ),
//         ));
//   }

//   void AnimateIcon() {
//     setState(() {
//       isAnimated = !isAnimated;

//      if(isAnimated)
//        {
//          setState(() {
           
//          });
//          iconController.forward();
//          audioPlayer.play();
//        }else{
//          setState(() {
           
//          });
//        iconController.reverse();
//        audioPlayer.pause();
//      }


//     });
//   }
  
//   @override
//   void dispose() {
//     // TODO: implement dispose
//     iconController.dispose();
//     audioPlayer.dispose();
//     super.dispose();
//   }
// }