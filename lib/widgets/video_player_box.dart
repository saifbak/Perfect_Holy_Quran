import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:video_player/video_player.dart';


class VideoItem extends StatefulWidget {
  String videoLink;
  VideoItem(this.videoLink);

  @override
  _VideoItemState createState() => _VideoItemState();
}

class _VideoItemState extends State<VideoItem> {
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;


  @override
  void initState() {
    _controller = VideoPlayerController.network(
      /*"https://hospitality92.com/uploads/products/1624530723.mp4"*/
        widget.videoLink);
    _initializeVideoPlayerFuture = _controller.initialize();
    _controller.setLooping(true);
    _controller.setVolume(1.0);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Center(
            child: FutureBuilder(
              future: _initializeVideoPlayerFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.done) {
                  return FittedBox(
                    fit: BoxFit.cover,
                    child: SizedBox(
                      height: 24.0,
                      width: 100.0,
                      child: VideoPlayer(_controller  ),
                    ),
                  );
                } else {
                  return Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            ),
          ),
          Center(
            child: Container(
              decoration: BoxDecoration(

                // color: Colors.yellow,
                  borderRadius: BorderRadius.circular(28.0)),
              child: IconButton(
                  alignment: Alignment.center,
                  onPressed: (){
                    setState(() {
                      if (_controller.value.isPlaying) {
                        _controller.pause();
                      } else {
                        _controller.play();
                      }
                    });

                  }, icon: FaIcon(_controller.value.isPlaying ? FontAwesomeIcons.pause : FontAwesomeIcons.play, color: Colors.white,size: 16.0,)),
            ),
          )
        ],
      ),
    );
  }
}
