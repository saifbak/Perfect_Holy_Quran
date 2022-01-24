import 'package:flutter/material.dart';
import 'package:perfectholyquran/models/messages_model.dart';
import 'package:perfectholyquran/services/messages_api.dart';

enum MessagesState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class MessagesProvider with ChangeNotifier {
  MessagesState _messagesState = MessagesState.Initial;
  List<MessagesModel> messagesModel;
  String message = '';

  MessagesProvider() {
    _fetchSurahDetailsList();
  }

  MessagesState get messagesState => _messagesState;

  Future<void> _fetchSurahDetailsList() async {
    _messagesState = MessagesState.Loading;
    try {
      final productList = await MessagesApi.instance.getMessagesList();
      messagesModel = productList;
      _messagesState = MessagesState.Loaded;
    } catch (e) {
      message = '$e';
      print(e);
      _messagesState = MessagesState.Error;
    }
    notifyListeners();
  }
}
