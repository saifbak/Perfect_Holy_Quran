import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:perfectholyquran/App%20Utils/duaListItem.dart';
import 'package:perfectholyquran/models/duaCategoryModel.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/views/duaDetailScreen.dart';

class DuaCategoriesScreen extends StatefulWidget {
  @override
  _DuaCategoriesScreenState createState() => _DuaCategoriesScreenState();
}

class _DuaCategoriesScreenState extends State<DuaCategoriesScreen> {
  var searchController = TextEditingController();

  DuaCategoryModel categories;
  List<DuaCategories> categoriesFiltered;
  loadData() async {
    final String response =
        await rootBundle.loadString('assets/jsonData/categories.json');
    var jsonDecoded = json.decode(response);
    categories = DuaCategoryModel.fromJson(jsonDecoded);
    categories.duaCategories = categories.duaCategories.take(14).toList();
    categoriesFiltered = categories.duaCategories;
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    loadData();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   title: Text('Categories'),
        //   backgroundColor: kPrimaryColor,
        //   brightness: Brightness.dark,
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/background1.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          child: Stack(
            children: [
              Align(
                  alignment: Alignment.topRight,
                  child: Image.asset(
                    'assets/topright.png',
                    color: AppColors.greenColors,
                    height: MediaQuery.of(context).size.height * 0.13,
                    width: MediaQuery.of(context).size.width * 0.29,
                  )),
              Container(
                color: kPrimaryColor.withOpacity(.1),
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                child: Column(
                  children: [
                    Container(
                      // decoration: BoxDecoration(
                      //   image: DecorationImage(
                      //     image: AssetImage(
                      //       "assets/background.png",
                      //     ),
                      //   ),
                      // ),
                      height: 80,
                      child: Stack(
                        children: [
                          Positioned(
                              left: 20,
                              top: 50,
                              child: GestureDetector(
                                onTap: () => Navigator.pop(context),
                                child: Icon(Icons.arrow_back_ios,
                                    color: AppColors.greenColors),
                              )),
                          Positioned(
                              left: 130,
                              top: 50,
                              child: Text(
                                "Categories",
                                style: TextStyle(
                                    color: AppColors.greenColors,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold),
                              )),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 17,
                    ),
                    Container(
                      margin: const EdgeInsets.all(10.0),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey,
                            spreadRadius: 1,
                            blurRadius: 1,
                            offset: Offset(3, 3), // changes position of shadow
                          ),
                        ],
                      ),
                      child: TextField(
                        onChanged: (value) {
                          filterData(value);
                        },
                        decoration: InputDecoration(
                          prefixIcon: Icon(
                            Icons.search,
                            size: 30,
                            color: AppColors.boxColors,
                          ),
                          hintText: "Search Dua Here",
                          hintStyle: TextStyle(color: Colors.grey),
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15),
                          ),
                          fillColor: Colors.white,
                          filled: true,
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        child: categoriesFiltered == null
                            ? Center(
                                child: CupertinoActivityIndicator(),
                              )
                            : ListView(children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 15.0),
                                  child: Text(
                                    "Categories",
                                    style: kHeadlineStyle.copyWith(
                                      color: kPrimaryColor,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: 10,
                                ),
                                Wrap(
                                  alignment: WrapAlignment.spaceEvenly,
                                  runSpacing: 10,
                                  children: [
                                    InkWell(
                                      onTap: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  DuaDetailsScreen(0)),
                                        );
                                      },
                                      child: categoriesItem(
                                        duaIcons[0],
                                        "All",
                                        AppColors.boxColors,
                                      ),
                                    ),
                                    for (var item in categoriesFiltered)
                                      GestureDetector(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DuaDetailsScreen(item.iId)),
                                          );
                                        },
                                        child: categoriesItem(
                                          duaIcons[item.iId],
                                          item.enTitle,
                                          AppColors.boxColors,
                                        ),
                                      )
                                  ],
                                ),
                              ]),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  filterData(val) {
    categoriesFiltered = categories.duaCategories;
    categoriesFiltered = categoriesFiltered
        .where((element) => element.enTitle.contains(val))
        .toList();
    setState(() {});
  }
}
