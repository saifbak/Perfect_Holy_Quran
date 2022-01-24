import 'package:flutter/services.dart' show rootBundle;
import 'package:http/http.dart' as http;
import 'package:perfectholyquran/models/message_model.dart';
import 'package:perfectholyquran/models/sura_audio.dart';
import 'package:perfectholyquran/models/sura_audio.dart';
import 'package:perfectholyquran/models/sura_audio.dart';
import 'package:perfectholyquran/models/sura_audio.dart';
import 'package:perfectholyquran/mychanges/sura_list_model.dart';
import 'dart:async';

import 'package:perfectholyquran/mychanges/surah_model.dart';


class QuranAPI {
 Future <Sura> readSurah(int index) async {
    final response = await rootBundle.loadString('assets/quran/surah/surah_$index.json');
    // print("Resopp+$response");
     final sura = suraFromJson(response);
    return sura; 

}



Future <List<Suralist>> readSurahlist() async {
    final response = await rootBundle.loadString('assets/quran/surah.json');
    print("Resopp+$response");
    // final responser= json.decode(response);   
     final List<Suralist> suralist = suralistFromJson(response.toString());
    // print("Response"+suralist.toString());
    return suralist; 
}



  Future<List<Message>> getMessages() async {
    var url = Uri.parse("https://quran.mobaspire.com/Api/messages_api/api-fetch-all.php");
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      List<Message> message=messageFromJson(response.body);
      return  message;
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }

  
  Future<List<SuraAudio>> Suraudio() async {
    var url = Uri.parse("https://quran.mobaspire.com/Api/audioquran_api/api-fetch-all.php");
    final response = await http.get(url);
    
    if (response.statusCode == 200) {
      List<SuraAudio> audio=suraAudioFromJson(response.body);
      return  audio;
    } else {
      print("Failed to load");
      throw Exception("Failed  to Load Post");
    }
  }
  

//   Future<JuzModel> getJuzz(int index) async {
//     var url = Uri.parse("http://api.alquran.cloud/v1/juz/$index/quran-uthmani");
//     final response = await http.get(url);

//     if (response.statusCode == 200) {
//       return JuzModel.fromJSON(json.decode(response.body));
//     } else {
//       print("Failed to load");
//       throw Exception("Failed  to Load Post");
//     }
//   }
}