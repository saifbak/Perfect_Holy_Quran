import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class MadinahLiveScreen extends StatefulWidget {
  @override
  _MadinahLiveScreenState createState() => _MadinahLiveScreenState();
}

class _MadinahLiveScreenState extends State<MadinahLiveScreen> {
  YoutubePlayerController _controller;
  TextEditingController _idController;
  TextEditingController _seekToController;

  PlayerState _playerState;
  YoutubeMetaData _videoMetaData;
  double _volume = 100;
  bool _muted = false;
  bool _isPlayerReady = false;

  var id = YoutubePlayer.convertUrlToId(
      "https://www.youtube.com/watch?v=vhzJaC8YeJc");

  @override
  void initState() {
    _controller = YoutubePlayerController(
      initialVideoId: id.toString(),
      flags: const YoutubePlayerFlags(
        mute: false,
        autoPlay: true,
        disableDragSeek: false,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: true,
      ),
    )..addListener(listener);
    _idController = TextEditingController();
    _seekToController = TextEditingController();
    _videoMetaData = const YoutubeMetaData();
    _playerState = PlayerState.unknown;
  }

  void listener() {
    if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _playerState = _controller.value.playerState;
        _videoMetaData = _controller.metadata;
      });
    }
  }

  @override
  void deactivate() {
    // Pauses video while navigating to next page.
    _controller.pause();
    super.deactivate();
  }

  @override
  void dispose() {
    _controller.dispose();
    _idController.dispose();
    _seekToController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // return Scaffold(
    //   body: SafeArea(
    //     child: Center(
    //       child: YoutubePlayer(
    //         controller: _controller,
    //         showVideoProgressIndicator: true,
    //       ),
    //     ),
    //   ),
    // );

    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        title: Text('Madina Live'),
        backgroundColor: AppColors.greenColors,
      ),
      body: SafeArea(
        child: Center(
          child: YoutubePlayerBuilder(
            onExitFullScreen: () {
              // The player forces portraitUp after exiting fullscreen. This overrides the behaviour.
              SystemChrome.setPreferredOrientations(DeviceOrientation.values);
            },
            player: YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: Colors.blueAccent,
              topActions: <Widget>[
                const SizedBox(width: 8.0),
                Expanded(
                  child: Text(
                    _controller.metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 18.0,
                    ),
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                // IconButton(
                //   icon: const Icon(
                //     Icons.settings,
                //     color: Colors.white,
                //     size: 25.0,
                //   ),
                //   onPressed: () {
                //   },
                // ),
              ],
              onReady: () {
                _isPlayerReady = true;
              },
              onEnded: (data) {
                // _controller
                //     .load(_ids[(_ids.indexOf(data.videoId) + 1) % _ids.length]);
              },
            ),
            builder: (context, player) => ListView(
              children: [
                player,
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
