

import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/views/videos_screen.dart';


class ChannelsOverviewScreen extends StatefulWidget {
  @override
  _ChannelsOverviewScreenState createState() => _ChannelsOverviewScreenState();
}

class _ChannelsOverviewScreenState extends State<ChannelsOverviewScreen> {
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColors,
        title: Text('YouTube Channels'),
      ),
      body: Column(
        children: [
          ChannelBox('https://static-01.daraz.pk/p/07c1c906f5f2a64ba2c10e02b03bd695.jpg',
              'Yasmin Mogahed', 'UCjr67rJYy3mtZgF-hx6lQhA'),
          ChannelBox('https://yt3.ggpht.com/ytc/AKedOLRb2RI_BPKMTTQW6KoQ-qeqvoM24M7G9t2FH4xN5Q=s900-c-k-c0x00ffffff-no-rj',
              'Yaqeen Institute', 'UC3vHW2h22WE-pNi5WJtRIjg'),
          ChannelBox('https://yt3.ggpht.com/ytc/AKedOLSMFGRI1YeIqHa9d2GDzDLqNiUVA0Quqt1P1dyBDQ=s900-c-k-c0x00ffffff-no-rj',
              'Bayyinah Institute', 'UCRtiU-lpcBSi-ipFKyfIkug'),
        ],
      ),
    );
    
  }
  Widget ChannelBox(String channelImage, String channelName, String id){
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return VideosScreen(id: id,);
              },
            ),
          );
        },
        child: Material(
          elevation: 4,
          borderRadius: BorderRadius.circular(20),
          child: Container(
            height:MediaQuery.of(context).size.height*0.20,
            width: MediaQuery.of(context).size.width,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(


              children: [
                Flexible(
                  flex: 1,
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: Image.network(channelImage, fit: BoxFit.cover,)),
                ),

                Flexible(
                  flex: 1,
                  child: Padding(
                    padding: EdgeInsets.only(left: 8, right: 5, top: 5, bottom: 5),
                    child: Text(channelName,
                      overflow: TextOverflow.fade,
                      style: TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 22
                    ),),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}