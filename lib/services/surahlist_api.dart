import 'dart:convert';
import 'package:perfectholyquran/models/surah_list_model.dart';
import 'package:http/http.dart' as http;

class SurahListApi {
  static SurahListApi _instance;

  SurahListApi._();

  static SurahListApi get instance {
    if (_instance == null) {
      _instance = SurahListApi._();
    }
    return _instance;
  }

  Future<SurahsList> getSurahList() async {
    var url = Uri.parse("http://api.alquran.cloud/v1/quran/quran-uthmani");
    final response = await http.get(url);

    if (response.statusCode == 200) {
      return SurahsList.fromJSON(json.decode(response.body));
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
}
