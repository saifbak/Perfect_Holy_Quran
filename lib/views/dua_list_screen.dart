import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectholyquran/models/dua_model.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

class CategoryDuaScreen extends StatefulWidget {
  var groupId;
  CategoryDuaScreen(this.groupId);

  @override
  _CategoryDuaScreenState createState() => _CategoryDuaScreenState();
}

class _CategoryDuaScreenState extends State<CategoryDuaScreen> {
  DuaModel duaList;
  var arabicFonts = ["Amiri", "Hafs", "lateef"];

  @override
  void initState() {
    // TODO: implement initState
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
      appBar: PreferredSize(
          preferredSize: Size.fromHeight(0),
          child: AppBar(
            backgroundColor: AppColors.greenColors,
          )),
      body: SafeArea(
        child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage(
                  "assets/background.png",
                ),
                fit: BoxFit.cover,
              ),
            ),
            color: AppColors.greenColors.withOpacity(.1),
            padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
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
                            Text(
                              "Dua",
                              style: TextStyle(color: AppColors.greenColors),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Expanded(
                              child: ListView(
                                children: [
                                  for (var item in duaList.duaList)
//                                  utils.duaListItem(item.arDua,item.enTranslation)
                                    Container(
                                      margin: EdgeInsets.symmetric(
                                        vertical: 1,
                                      ),
                                      color: Colors.transparent,
                                      width: 110,
                                      child: Card(
                                        elevation: 0.5,
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                              horizontal: 10, vertical: 15),
                                          child: Column(
                                            children: [
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    "Dua",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      color:
                                                          AppColors.greenColors,
                                                      fontFamily:
                                                          arabicFonts[0],
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Text(
                                                    item.arDua,
                                                    style: TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          arabicFonts[0],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 15),
                                                  child: Text(
                                                    "Translation",
                                                    style: TextStyle(
                                                      fontSize: 22,
                                                      color:
                                                          AppColors.greenColors,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily:
                                                          arabicFonts[0],
                                                    ),
                                                  )),
                                              SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 5),
                                                  child: Text(
                                                    item.enTranslation,
                                                    style: TextStyle(
                                                      fontSize: 16,
                                                      color: Colors.black,
                                                      fontFamily:
                                                          arabicFonts[0],
                                                    ),
                                                    textAlign: TextAlign.center,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                ],
                              ),
                            ),
                          ]),
                  ),
                )
              ],
            )),
      ),
    );
  }
}
