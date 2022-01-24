import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:perfectholyquran/models/juzz_details_model.dart';

class JuzzDetailsApi {
  static JuzzDetailsApi _instance;


  JuzzDetailsApi._();

  static JuzzDetailsApi get instance {
    if (_instance == null) {
      _instance = JuzzDetailsApi._();
    }
    return _instance;
  }

  Future<List<JuzzDetailsModel>> getJuzzList(int index) async {

    final response = await http.get(Uri.parse("http://api.alquran.cloud/v1/juz/+$index+/ar.alafasy"));
    print("http://api.alquran.cloud/v1/juz/+$index+/quran-uthmani");
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);

      var data = responseBody['data']['ayahs'] as List;
      print(data);
      var map = data.map<JuzzDetailsModel>((json) => JuzzDetailsModel.fromJson(json));
      return map.toList();
    }else{
      print("status 400");
      return null;
    }

  }
}