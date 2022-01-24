//
//
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:perfectholyquran/utils/app_colors.dart';
// import 'package:perfectholyquran/widgets/video_box.dart';
// import 'package:provider/provider.dart';
//
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
//
// class VideosScreen extends StatefulWidget {
//   @override
//   _VideosScreenState createState() => _VideosScreenState();
// }
//
// class _VideosScreenState extends State<VideosScreen> {
//   var _isInit = true;
//   var _isLoading = false;
//
//   // @override
//   // void initState() {
//   //   // TODO: implement initState
//   //   Provider.of<VideosProvider>(context, listen: false)
//   //       .fetchVideos()
//   //       .then((value) {
//   //     if (value) setState(() {});
//   //   });
//   //   super.initState();
//   // }
//
//   // @override
//   // void didChangeDependencies() {
//   //   if (_isInit) {
//   //     setState(() {
//   //       _isLoading = true;
//   //     });
//   //
//   //     Provider.of<VideosProvider>(context, listen: false)
//   //         .fetchVideos()
//   //         .then((value) {
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //     });
//   //   }
//   //   _isInit = false;
//   //   super.didChangeDependencies();
//   // }
//   @override
//   Widget build(BuildContext context) {
//
//     return Scaffold(
//       backgroundColor: Colors.white,
//       appBar: AppBar(
//         backgroundColor: AppColors.greenColors,
//
//         title: Center(
//           child: Text('Videos', style: TextStyle(
//               fontSize: 14.0
//           ),),
//         ),
//       ),
//       body: Align(
//           alignment: Alignment.topCenter,
//           child: Container(
//             height: 800.0,
//             color: Colors.transparent,
//             child: _isLoading
//                 ? Center(
//               child: CircularProgressIndicator(),
//             )
//                 : ListView(
//               children: [
//                 VideoBox()
//               ],
//             )
//           )),
//     );
//   }
// }
//
//
//
//

import 'package:flutter/material.dart';
import '../models/channel_model.dart';
import '../models/video_model.dart';
import 'package:perfectholyquran/views/video_screen.dart';
import '../services/api_service.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

class VideosScreen extends StatefulWidget {
  final String id;

  const VideosScreen({Key key, this.id}) : super(key: key);
  @override
  _VideosScreenState createState() => _VideosScreenState(this.id);
}

class _VideosScreenState extends State<VideosScreen> {
  Channel _channel;
  bool _isLoading = false;
  final String id;

  _VideosScreenState(this.id);

  @override
  void initState() {
    super.initState();
    _initChannel();
  }

  _initChannel() async {
    Channel channel = await APIService.instance
        .fetchChannel(channelId: id);
    setState(() {
      _channel = channel;
    });
  }

  _buildProfileInfo() {
    return Container(
      margin: EdgeInsets.all(20.0),
      padding: EdgeInsets.all(20.0),
      height: 100.0,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            offset: Offset(0, 1),
            blurRadius: 6.0,
          ),
        ],
      ),
      child: Row(
        children: <Widget>[
          CircleAvatar(
            backgroundColor: Colors.white,
            radius: 35.0,
            backgroundImage: NetworkImage(_channel.profilePictureUrl),
          ),
          SizedBox(width: 12.0),
          Expanded(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  _channel.title,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
                Text(
                  '${_channel.subscriberCount} subscribers',
                  style: TextStyle(
                    color: Colors.grey[600],
                    fontSize: 16.0,
                    fontWeight: FontWeight.w600,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  _buildVideo(Video video) {
    return GestureDetector(
      onTap: () => Navigator.push(
        context,
        MaterialPageRoute(
          builder: (_) => VideoScreen(id: video.id),
        ),
      ),
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 20.0, vertical: 5.0),
        padding: EdgeInsets.all(10.0),
        height: 140.0,
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              offset: Offset(0, 1),
              blurRadius: 6.0,
            ),
          ],
        ),
        child: Row(
          children: <Widget>[
            Image(
              width: 150.0,
              image: NetworkImage(video.thumbnailUrl),
            ),
            SizedBox(width: 10.0),
            Expanded(
              child: Text(
                video.title,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 18.0,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _loadMoreVideos() async {
    _isLoading = true;
    List<Video> moreVideos = await APIService.instance
        .fetchVideosFromPlaylist(playlistId: _channel.uploadPlaylistId);
    List<Video> allVideos = _channel.videos..addAll(moreVideos);
    setState(() {
      _channel.videos = allVideos;
    });
    _isLoading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.greenColors,
        title: Text('YouTube Channel'),
      ),
      body: _channel != null
          ? NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollDetails) {
          if (!_isLoading &&
              _channel.videos.length != int.parse(_channel.videoCount) &&
              scrollDetails.metrics.pixels ==
                  scrollDetails.metrics.maxScrollExtent) {
            _loadMoreVideos();
          }
          return false;
        },
        child: ListView.builder(
          itemCount: 1 + _channel.videos.length,
          itemBuilder: (BuildContext context, int index) {
            if (index == 0) {
              return _buildProfileInfo();
            }
            Video video = _channel.videos[index - 1];
            return _buildVideo(video);
          },
        ),
      )
          : Center(
        child: CircularProgressIndicator(
          valueColor: AlwaysStoppedAnimation<Color>(
            Theme.of(context).primaryColor, // Red
          ),
        ),
      ),
    );
  }
}