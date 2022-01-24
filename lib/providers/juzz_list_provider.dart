import 'package:flutter/material.dart';
import 'package:perfectholyquran/models/juzz_details_model.dart';
import 'package:perfectholyquran/services/juzz_details_api.dart';


enum JuzzListState {
  Initial,
  Loading,
  Loaded,
  Error,
}


class JuzzDetailsProvider with ChangeNotifier{

  JuzzListState _juzzDetailsState = JuzzListState.Initial;
  List<JuzzDetailsModel> juzzListModel = [];
  String message = '';

  JuzzDetailsProvider(int index) {
    _fetchSurahList(index);
  }

  JuzzListState get juzzDetailsState => _juzzDetailsState;



  Future<void> _fetchSurahList(int index) async {

    _juzzDetailsState = JuzzListState.Loading;
    try {
      final productList = await JuzzDetailsApi.instance.getJuzzList(index);
      juzzListModel = productList;
      _juzzDetailsState = JuzzListState.Loaded;
    } catch (e) {
      message = '$e';
      _juzzDetailsState = JuzzListState.Error;
    }
    notifyListeners();
  }


}