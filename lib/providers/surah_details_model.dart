import 'package:flutter/material.dart';
import 'package:perfectholyquran/models/surah_details_model.dart';
import 'package:perfectholyquran/services/surah_details_api.dart';

enum SurahDetailsState {
  Initial,
  Loading,
  Loaded,
  Error,
}

class SurahDetailsProvider with ChangeNotifier {
  SurahDetailsState _surahdetailsState = SurahDetailsState.Initial;
  List<SurahDetailsModel> surahDetailsModel;
  String message = '';

  SurahDetailsProvider(int index) {
    _fetchSurahDetailsList(index);
  }

  SurahDetailsState get surahDetailsState => _surahdetailsState;

  Future<void> _fetchSurahDetailsList(int index) async {
    _surahdetailsState = SurahDetailsState.Loading;
    try {
      final productList =
          await SurahDetailsApi.instance.getSurahDetailsList(index);
      surahDetailsModel = productList as List<SurahDetailsModel>;
      _surahdetailsState = SurahDetailsState.Loaded;
    } catch (e) {
      message = '$e';
      print(e);
      _surahdetailsState = SurahDetailsState.Error;
    }
    notifyListeners();
  }
}
