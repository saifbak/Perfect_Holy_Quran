import 'dart:async';

import 'dart:typed_data';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:like_button/like_button.dart';
import 'package:path_provider/path_provider.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/models/ayat_wallpapers.dart';
import 'package:screenshot/screenshot.dart';
import 'package:http/http.dart';
import 'package:path_provider/path_provider.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:share/share.dart';
import 'dart:async';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui' as ui;

class AyatList extends StatefulWidget {
  final AyatWallPapers ayatwallpapers;

  const AyatList({Key key, this.ayatwallpapers}) : super(key: key);

  @override
  _AyatListState createState() => _AyatListState();
}

class _AyatListState extends State<AyatList> {
  // bool button1, button2;
  // static GlobalKey _globalKey = GlobalKey();
  // @override
  // void initState() {
  //   button1 = false;
  //   button2 = false;
  //   super.initState();
  // }
  Future<void> share() async {
    await FlutterShare.share(
        title: 'Holly Quran',
        text: widget.ayatwallpapers.ayat,
        linkUrl: widget.ayatwallpapers.translation +
            ' (' +
            widget.ayatwallpapers.surahnayatNum +
            ')',
        chooserTitle: widget.ayatwallpapers.surahnayatNum);
  }

  int _counter = 0;
  Uint8List _imageFile;

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  Future screenShot() {
    screenshotController
        .capture(delay: const Duration(milliseconds: 10))
        .then((Uint8List image) async {
      if (image != null) {
        final directory = await getApplicationDocumentsDirectory();
        final imagePath = await File('${directory.path}/image.png').create();
        await imagePath.writeAsBytes(image);

        /// Share Plugin
        await Share.shareFiles([imagePath.path]);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 0),
      child: Container(
        height: 200,
        width: 220,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.2),
              spreadRadius: 1,
              blurRadius: 10,
              offset: Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Column(
          children: [
            Expanded(
                child: Screenshot(
                    controller: screenshotController,
                    child: Container(
                        width: double.infinity,
                        child: Stack(
                          children: [
                            Container(
                              width: double.infinity,
                              height: double.infinity,
                              child: Image.asset(
                                // ayatwallpapers.image,
                                "assets/iayahImages.jpg",
                                fit: BoxFit.fill,
                              ),
                            ),
                            Container(
                              color: AppColors.greenColors.withOpacity(.3),
                            ),
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    //  "إِنَّ اللَّـهَ عَلَىٰ كُلِّ شَيْءٍ قَدِيرٌ",
                                    widget.ayatwallpapers.ayat,
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? AppColors.greenColors
                                          : AppColors.greenColors,
                                    ),
                                  ),
                                  Text(
                                    //"For Allah hath power over all things"
                                    widget.ayatwallpapers.translation,
                                    textAlign: TextAlign.center,
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? AppColors.greenColors
                                          : AppColors.greenColors,
                                    ),
                                  ),
                                  Text(
                                    //"Al-Baqara - 2:20"
                                    widget.ayatwallpapers.surahnayatNum,
                                    style: TextStyle(
                                      color: _isDarkMode
                                          ? AppColors.greenColors
                                          : AppColors.greenColors,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        )))),
            Container(
              padding: EdgeInsets.symmetric(vertical: 7),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                      child: GestureDetector(
                    onTap: () {
                      share();
                    },
                    //shareScreenshot,
                    child: Icon(
                      Icons.share,
                      size: 20,
                      color: AppColors.greenColors,
                    ),
                  )),

                  Expanded(
                      child: GestureDetector(
                          onTap: () {
                            screenShot();
                            // screenshotController
                            //     .capture()
                            //     .then((Uint8List image) {
                            //   //Capture Done
                            //   setState(() {
                            //     _imageFile = image;
                            //   });
                            // }).catchError((onError) {
                            //   print(onError);
                            // });
                          },
                          child: Icon(
                            Icons.file_download_outlined,
                            color: AppColors.greenColors,
                          ))),
                  Expanded(
                    child: LikeButton(
                      size: 20,
                      circleColor: CircleColor(
                          start: Color(0xff00ddff), end: Color(0xff0099cc)),
                      bubblesColor: BubblesColor(
                        dotPrimaryColor: Color(0xff33b5e5),
                        dotSecondaryColor: Color(0xff0099cc),
                      ),
                      likeBuilder: (bool isLiked) {
                        return Icon(
                          CupertinoIcons.hand_thumbsup,
                          color: isLiked ? Colors.red : AppColors.greenColors,
                          size: 20,
                        );
                      },
                      // likeCount: 0,
                      // countBuilder: (int count, bool isLiked, String text) {
                      //   var color = isLiked ? Colors.red : Colors.grey;
                      //   Widget result;
                      //   if (count == 0) {
                      //     result = Text(
                      //       "like",
                      //       style: TextStyle(color: color),
                      //     );
                      //   } else
                      //     result = Text(
                      //       text,
                      //       style: TextStyle(color: color),
                      //     );
                      //   return result;
                      // },
                    ),
                  ),
                  // Expanded(
                  //     child: GestureDetector(
                  //       onTap: liked,
                  //       child: Icon(
                  //   CupertinoIcons.hand_thumbsup,
                  //   color: AppColors.greenColors,
                  // ),
                  //     )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

// Future<Null> shareScreenshot() async {
//   setState(() {
//     button1 = true;
//   });
//   try {
//     RenderRepaintBoundary boundary =
//     _globalKey.currentContext.findRenderObject();
//     if (boundary.debugNeedsPaint) {
//       Timer(Duration(seconds: 1), () => shareScreenshot());
//       return null;
//     }
//     ui.Image image = await boundary.toImage();
//     final directory = (await getExternalStorageDirectory()).path;
//     ByteData byteData = await image.toByteData(format: ui.ImageByteFormat.png);
//     Uint8List pngBytes = byteData.buffer.asUint8List();
//     File imgFile = new File('$directory/screenshot.png');
//     imgFile.writeAsBytes(pngBytes);
//     final RenderBox box = context.findRenderObject();
//     Share.shareFile(File('$directory/screenshot.png'),
//         subject: 'Share ScreenShot',
//         text: 'Hello, check your share files!',
//         sharePositionOrigin: box.localToGlobal(Offset.zero) & box.size
//     );
//   } on PlatformException catch (e) {
//     print("Exception while taking screenshot:" + e.toString());
//   }
//   setState(() {
//     button1 = false;
//   });
// }
}
