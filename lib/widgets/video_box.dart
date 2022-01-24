import 'dart:async';

import 'package:perfectholyquran/models/videos_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';



class VideoBox extends StatefulWidget {
  @override
  _VideoBoxState createState() => _VideoBoxState();
}

class _VideoBoxState extends State<VideoBox> {
  YoutubePlayerController _controller;

  void runYoutubePlayer() {


    _controller = YoutubePlayerController(
        initialVideoId: YoutubePlayer.convertUrlToId('https://www.youtube.com/watch?v=wyQg8bBIwLE'),
        flags: YoutubePlayerFlags(
          enableCaption: false,
          autoPlay: false,
          isLive: false,
        ));
  }


  @override
  void initState() {
    super.initState();
    // final testData = Provider.of<VideosModel>(context, listen: false);
    // setState(() {
    //   if (testData.link != null) {
    runYoutubePlayer();
    //   }
    // });
  }

  // @override
  // void didChangeDependencies() {
  //   final testData = Provider.of<VideosModel>(context);
  //   if (testData.link != null) {
  //     setState(() {
  //       runYoutubePlayer();
  //     });
  //   } else {
  //     return null;
  //   }
  //
  //   super.didChangeDependencies();
  // }

  @override
  void deactivate() {
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {


    // if (testData.link != null) {

    return YoutubePlayerBuilder(
      player: YoutubePlayer(
        controller: _controller,
      ),
      builder: (context, player) {
        return Container(
          height: 250.0,
          width: 100.0,
          child: player,
        );
      },
    );
    // } else {
    //   return Container(
    //       height: 24.0.h,
    //       width: 100.0.w,
    //       child: VideoItem(
    //           'https://hospitality92.com/uploads/videos/' + testData.video));
    // }
  }
}
