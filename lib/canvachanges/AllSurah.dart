import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:perfectholyquran/utils/app_colors.dart';
import 'SurahDetail.dart';

class AllSurah extends StatefulWidget {
  @override
  _AllSurahState createState() => _AllSurahState();
}

class _AllSurahState extends State<AllSurah> {
  Future<List<dynamic>> getSurahList() async {
    String url = 'https://api.quran.com/api/v4/chapters';
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json',
    });
    print("Surah --> $response");
    return json.decode(response.body)['chapters'];
  }

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height,
      child: SingleChildScrollView(
        child: FutureBuilder<List<dynamic>>(
          future: getSurahList(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(0.0),
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: snapshot.data?.length,
                            itemBuilder: (context, index) {
                              var arabicName =
                                  snapshot.data[index]['name_arabic'];
                              var englishName =
                                  snapshot.data[index]['name_simple'];
                              var id = snapshot.data[index]['id'];

                              return Column(
                                children: [
                                  GestureDetector(
                                      onTap: () {
                                        _onSelected(index);
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => SurahDetails(
                                                surahIndex: id,
                                                surahName: englishName),
                                          ),
                                        );
                                      },
                                      child: Container(
                                        padding: EdgeInsets.all(0),
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          border: Border.all(
                                            color: _selectedIndex != null &&
                                                    _selectedIndex == index
                                                ? AppColors.boxColors
                                                : Colors.white,
                                            width: 3,
                                          ),
                                          borderRadius:
                                              _selectedIndex != null &&
                                                      _selectedIndex == index
                                                  ? BorderRadius.circular(8)
                                                  : BorderRadius.circular(0),
                                          boxShadow: _selectedIndex != null &&
                                                  _selectedIndex == index
                                              ? [
                                                  BoxShadow(
                                                    color: Colors.grey
                                                        .withOpacity(0.4),
                                                    spreadRadius: 3,
                                                    blurRadius: 4,
                                                    offset: Offset(0,
                                                        1), // changes position of shadow
                                                  ),
                                                ]
                                              : [],
                                        ),
                                        child: ListTile(
                                          hoverColor: AppColors.boxColors,
                                          autofocus: true,
                                          dense: true,
                                          leading: Wrap(
                                            children: [
                                              //Text("${index + 1}."),
                                              SizedBox(
                                                width: 2,
                                              ),
                                              Text(
                                                id.toString() +
                                                    "." +
                                                    " " +
                                                    englishName,
                                                style: TextStyle(
                                                    color:
                                                        AppColors.greenColors,
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
                                            ],
                                          ),
                                          trailing: Text(
                                            arabicName,
                                            style: TextStyle(
                                                color: AppColors.greenColors,
                                                fontSize: 16,
                                                fontFamily: "Noto Sans Arabic",
                                                fontWeight: FontWeight.w500),
                                            textAlign: TextAlign.right,
                                          ),
                                        ),
                                      )

                                      /*Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Material(
                                        elevation: 2,
                                        borderRadius: BorderRadius.circular(2),
                                        child: Container(
                                          decoration: BoxDecoration(color: Colors.white, borderRadius: BorderRadius.circular(2)),
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              crossAxisAlignment: CrossAxisAlignment.start,
                                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                              children: [
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text(
                                                      id.toString() + "." + " " + englishName,
                                                      style: TextStyle(color: Colors.grey, fontSize: 10.0, fontFamily: 'Mulish', fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                                Padding(
                                                  padding: const EdgeInsets.all(8.0),
                                                  child: Container(
                                                    child: Text(
                                                      arabicName,
                                                      style: TextStyle(color: Colors.black87, fontSize: 12.0, fontWeight: FontWeight.w600),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),*/

                                      ),
                                  Divider(
                                    height: 1,
                                    color: AppColors.boxColors,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: 20)
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
