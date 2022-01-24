// import 'package:audioplayers/audioplayers.dart';
// import 'package:flutter/material.dart';
// import 'package:perfectholyquran/utils/app_colors.dart';

// class QuranAudio extends StatefulWidget {
//   final String url;
//   final bool isPressed;
//   const QuranAudio({
//     Key key,
//     this.isPressed = false,
//     this.url,
//   }) : super(key: key);


//   @override
//   _QuranAudioState createState() => _QuranAudioState();
// }

// class _QuranAudioState extends State<QuranAudio> {
//   bool _isPressed;
//   AudioPlayer audioPlayer = AudioPlayer();
//   AudioCache cache= new AudioCache();
//   // AssetsAudioPlayer assetsAudioPlayer = AssetsAudioPlayer();

//   bool playing = false;

//   @override
//   void initState() {
//     super.initState();
//     _isPressed = widget.isPressed;
//   }

//   @override
//   void dispose() {
//     audioPlayer.stop();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return GestureDetector(
//         onTap: (){
//           setState(()  {
//             _isPressed = !_isPressed;
//             if (!playing ){
//               playing = true;
//               // audioPlayer.setUrl(widget.url);
//                 // print(audioPlayer.isLocalUrl(widget.url));
                
//               audioPlayer.play(widget.url.toString());
            
//               // try{
//               //   assetsAudioPlayer.open(Audio.network(widget.url));
//               // }catch(t){
//               //   print(t);
//               // }
//             } else {
//               playing = false;
//               audioPlayer.stop();
//               // assetsAudioPlayer.stop();
//             }
//           });
//         },
//         child:
//         _isPressed ?
//         Icon(
//           Icons.pause_circle_filled_rounded,
//           color: AppColors.greenColors,
//           size: 40,
//         )
//             :
//         Icon(
//           Icons.play_circle_fill,
//           color: AppColors.greenColors,
//           size: 40,
//         )

//     );

//   }
// }