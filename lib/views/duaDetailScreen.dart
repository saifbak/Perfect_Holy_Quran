import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectholyquran/App%20Utils/duaListItem.dart';
import 'package:perfectholyquran/models/duaModel.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

class DuaDetailsScreen extends StatefulWidget {
  var groupId;
  DuaDetailsScreen(this.groupId);

  @override
  _DuaDetailsScreenState createState() => _DuaDetailsScreenState();
}

class _DuaDetailsScreenState extends State<DuaDetailsScreen> {
  DuaModel duaList;

  @override
  void initState() {
    super.initState();
    loadData();
  }

  loadData() async {
    final String response =
        await rootBundle.loadString('assets/jsonData/dua.json');

    var jsonDecoded = jsonDecode(response);
    duaList = DuaModel.fromJson(jsonDecoded);
    duaList.duaList = widget.groupId == 0
        ? duaList.duaList.toList()
        : duaList.duaList.where((e) => e.groupId == widget.groupId).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dua'),
        backgroundColor: AppColors.greenColors,
        brightness: Brightness.dark,
      ),
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(
              "assets/background.png",
              //color: Colors.green.withOpacity(.1),
            ),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        child: SafeArea(
          child: Column(
            children: [
              SizedBox(
                height: 20,
              ),
              Expanded(
                child: Container(
                  child: duaList == null
                      ? Center(
                          child: CupertinoActivityIndicator(),
                        )
                      : Column(children: [
                          SizedBox(
                            height: 10,
                          ),
                          Expanded(
                            child: ListView(
                              children: [
                                for (var item in duaList.duaList)
                                  duaListItem(item.arDua, item.enTranslation),
                              ],
                            ),
                          ),
                        ]),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
