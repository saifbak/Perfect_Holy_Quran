import 'package:flutter/material.dart';
import 'package:perfectholyquran/models/surah_list_model.dart';
import 'package:perfectholyquran/services/surahlist_api.dart';

enum SurahListState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class SurahListProvider with ChangeNotifier {
  SurahListState _surahListState = SurahListState.Initial;
  List<Surah> surahListModel = [];
  String message = '';

  SurahListProvider() {
    _fetchSurahList();
  }

  SurahListState get surahListState => _surahListState;

  Future<void> _fetchSurahList() async {
    _surahListState = SurahListState.Loading;
    try {
      var productList = await SurahListApi.instance.getSurahList();
     surahListModel=productList.surahs.toList();
      _surahListState = SurahListState.Loaded;
    } catch (e) {
      message = '$e';
      _surahListState = SurahListState.Error;
    }
   
  }
   notifyListeners();
}
