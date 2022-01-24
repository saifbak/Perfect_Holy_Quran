
import 'package:flutter/cupertino.dart';
import 'package:flutter_launcher_icons/xml_templates.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
// import 'package:just_audio/just_audio.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

class PlayPause extends StatefulWidget {
  final String url;
  final bool isPressed;
  const PlayPause({
    Key key,
    this.isPressed = false,
    this.url,
  }) : super(key: key);


  @override
  _PlayPauseState createState() => _PlayPauseState();
}

class _PlayPauseState extends State<PlayPause> {
  bool _isPressed;
  // AudioPlayer audioPlayer = AudioPlayer();
  bool playing = false;

  @override
  void initState() {
    super.initState();
    _isPressed = widget.isPressed;
  
  }

  @override
  void dispose() {
    // audioPlayer.stop();
    super.dispose();
  }

 
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      
        onTap: ()  {
          
           // audioPlayer.setUrl(widget.url);
          setState(()  {
            
            _isPressed = !_isPressed;
            if (!playing ){
              playing = true;
              // audioPlayer.play();
            } else {
              playing = false;
              // audioPlayer.stop();
            }
       
       
       
        
        child:
        _isPressed ?
        Icon(
          
          CupertinoIcons.pause_fill,
          // color: Colors.white,
          size: 30,
        )
            :
        Icon(
          CupertinoIcons.play_fill,
          // color: AppColors,
          size: 30,
        
        );
        }
    );
    
        }
    );
  }
  }