import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:perfectholyquran/models/messages_model.dart';

class MessagesApi {
  static MessagesApi _instance;


  MessagesApi._();

  static MessagesApi get instance {
    if (_instance == null) {
      _instance = MessagesApi._();
    }
    return _instance;
  }

  Future<List<MessagesModel>> getMessagesList() async {

    final response = await http.get(Uri.parse("https://www.googleapis.com/blogger/v3/blogs/122208699935946349/posts?key=AIzaSyAMLgkSdBE2NjJ-WPIIhpq2kXE-H44Ng-Q"));
    print("https://www.googleapis.com/blogger/v3/blogs/122208699935946349/posts?key=AIzaSyAMLgkSdBE2NjJ-WPIIhpq2kXE-H44Ng-Q");
    if(response.statusCode == 200){
      var responseBody = jsonDecode(response.body);
      print(responseBody);

      var data = responseBody['items'] as List;
      print(data);
      var map = data.map<MessagesModel>((json) => MessagesModel.fromJson(json));
      return map.toList();
    }else{
      print("status 400");
      return null;
    }

  }
}