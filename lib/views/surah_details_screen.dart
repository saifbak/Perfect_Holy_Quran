import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectholyquran/models/juzz_details_model.dart';
import 'package:perfectholyquran/models/surah_details_model.dart';
import 'package:perfectholyquran/providers/juzz_list_provider.dart';
import 'package:perfectholyquran/providers/surah_details_model.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:provider/provider.dart';

class SurahDetailsScreen extends StatefulWidget {
  int index;
  String title;
  SurahDetailsScreen({this.index, this.title});
  @override
  _SurahDetailsScreenState createState() => _SurahDetailsScreenState();
}

class _SurahDetailsScreenState extends State<SurahDetailsScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();

  @override
  void initState() {
    super.initState();

    print("surah index: " + widget.index.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _key,
      body: ListView(
        children: [
          Container(
            height: 90,
            child: Stack(
              children: [
                Positioned(
                    left: 15,
                    top: 60,
                    child: Text(
                      "Perfect Holy Quran",
                      style: TextStyle(
                          color: AppColors.greenColors,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    )),
                Positioned(
                  right: 15,
                  top: 50,
                  child: Builder(builder: (context) {
                    return InkWell(
                      onTap: () {
                        Scaffold.of(context).openDrawer();
                      },
                      child: Icon(
                        Icons.menu,
                        size: 25,
                        color: AppColors.greenColors,
                      ),
                    );
                  }),
                ),
              ],
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.85,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: Colors.grey.withOpacity(0.5),
                  spreadRadius: 5,
                  blurRadius: 100,
                  offset: Offset(0, 0.001), // changes position of shadow
                ),
              ],
            ),
            child: ListView(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                  child: Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: AppColors.greenColors),
                    child: Center(
                        child: Text(
                      widget.title,
                      style: GoogleFonts.lato(
                        fontSize: 25.0,
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    )),
                  ),
                ),
                Container(
                  height: MediaQuery.of(context).size.height * 0.73,
                  child: ChangeNotifierProvider(
                    create: (context) => SurahDetailsProvider(widget.index),
                    child: Builder(builder: (context) {
                      final productData =
                          Provider.of<SurahDetailsProvider>(context);

                      if (productData.surahDetailsState ==
                          SurahDetailsState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (productData.surahDetailsState ==
                          SurahDetailsState.Error) {
                        return Center(
                            child: Text(
                                'An Error Occured ${productData.message}'));
                      }
                      final productsData = productData.surahDetailsModel;
                      print(productsData.length);
                      return ListView.builder(
                          itemCount: productsData.length,
                          scrollDirection: Axis.vertical,
                          itemBuilder: (BuildContext context, int index) {
                            final prod = productsData[index];
                            return surahContainer(context, index, prod);
                          });
                    }),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget surahContainer(
      BuildContext context, int index, SurahDetailsModel prod) {
    return Padding(
      padding: const EdgeInsets.only(right: 20),
      child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5.0),
          ),
          child: Wrap(
            alignment: WrapAlignment.end,
            crossAxisAlignment: WrapCrossAlignment.end,
            children: [
              for (var i = 0; i < prod.ayahs.length * 2; i++)
                i % 2 != 0
                    ? Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Flexible(
                                flex: 9,
                                fit: FlexFit.tight,
                                child: Text(
                                  prod.ayahs[i == 0 ? 0 : (i ~/ 2).toInt()]
                                      .text,
                                  textAlign: TextAlign.start,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                    fontSize: 25.0,
                                    fontWeight: FontWeight.w600,
                                    color: AppColors.greenColors,
                                  ),
//                TextStyle(color: AppColors.greenColors, fontSize: 22),
                                ),
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Flexible(
                                fit: FlexFit.loose,
                                child: Container(
                                    height: 23,
                                    width: 20,
                                    decoration: BoxDecoration(
                                        border: Border.all(color: Colors.black),
                                        shape: BoxShape.circle),
                                    child: Center(
                                      child: Text(
                                        prod
                                            .ayahs[
                                                i == 0 ? 0 : (i ~/ 2).toInt()]
                                            .numberInSurah
                                            .toString(),
                                        style: TextStyle(
                                          fontSize: 25.0,
                                          fontWeight: FontWeight.w600,
                                          color: AppColors.greenColors,
                                        ),
                                      ),
                                    )),
                              ),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 20, right: 5, top: 5),
                            child: Divider(
                              thickness: 1,
                              color: AppColors.greenColors,
                            ),
                          )
                        ],
                      )
                    : Container()
            ],
          )),
    );
  }
}
