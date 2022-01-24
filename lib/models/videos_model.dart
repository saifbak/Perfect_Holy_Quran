import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class VideosModel with ChangeNotifier {
  final int id;
  final String description;
  final String status;
  final String video;
  final String link;
  final String date;

  VideosModel(
      {this.id,
        this.description,
        this.status,
        this.video,
        this.link,
        this.date});




}

