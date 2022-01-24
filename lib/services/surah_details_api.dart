import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:perfectholyquran/models/surah_details_model.dart';

class SurahDetailsApi {
  static SurahDetailsApi _instance;


  SurahDetailsApi._();

  static SurahDetailsApi get instance {
    if (_instance == null) {
      _instance = SurahDetailsApi._();
    }
    return _instance;
  }

  Future<List<SurahDetailsModel>> getSurahDetailsList(int index) async {

    final response = await http.get(Uri.parse("https://api.alquran.cloud/v1/surah/"+index.toString()+"/editions/quran-uthmani"));
    print("https://api.alquran.cloud/v1/surah/"+index.toString()+"/editions/quran-uthmani");
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      var data = responseBody ['data'] as List;
      print(data);
      var map = data.map<SurahDetailsModel>((json) => SurahDetailsModel.fromJson(json));
      return map.toList();
    }else{
      print("status 400");
      return null;
    }

  }
}