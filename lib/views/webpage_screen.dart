import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:webview_flutter/webview_flutter.dart';


class WebpagesScreen extends StatefulWidget {
  final String url;
  final String title;
  WebpagesScreen({@required this.url, @required this.title});

  @override
  _WebpagesScreenState createState() => _WebpagesScreenState();
}

class _WebpagesScreenState extends State<WebpagesScreen> {
  Completer<WebViewController> _controller = Completer<WebViewController>();
  bool isLoading = true;


  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(

      appBar: AppBar(
          backgroundColor: AppColors.greenColors,
          elevation: 0,
          centerTitle: true,
          title: Text(widget.title,)
      ),

      body:  Stack(
        children: [
          WebView(
            initialUrl: widget.url,
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) {
              _controller.complete(webViewController);
            },
            onPageFinished: (finish) {
              setState(() {
                isLoading = false;
              });
            },
          ),
          isLoading ? Center(
            child: Container(
              height: 80,
              width: 80,
              child: CircularProgressIndicator(
                backgroundColor: Colors.primaries[0],
                strokeWidth: 2,
              ),
            ),
          )
              : Stack(),
        ],
      ),
    );
  }
}
