import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/models/surah_list_model.dart';
import 'package:perfectholyquran/providers/surahlist_provider.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/views/surah_details_screen.dart';
import 'package:provider/provider.dart';

class SurahScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ChangeNotifierProvider(
        create: (context) => SurahListProvider(),
        child: Builder(
          builder: (context) {
            final productData = Provider.of<SurahListProvider>(context);

            if (productData.surahListState == SurahListState.Loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (productData.surahListState == SurahListState.Error) {
              return Center(
                  child: Text('An Error Occured ${productData.message}'));
            }
            else{
            final productsData = productData.surahListModel;
            print(productsData.length);
            return ListView.builder(
              
                itemCount: productsData.length,
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  final prod = productsData[index];
                  return surahContainer(context, index, prod);
                });
          }
          },
        ),
          
      ),
    );
  }

  Widget surahContainer(
      BuildContext context, int index, Surah surahListModel) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: InkWell(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => SurahDetailsScreen(
                        index: surahListModel.number,
                        title: surahListModel.name,
                      )));
        },
        child: Container(
          height: 50,
          width: MediaQuery.of(context).size.width * 0.9,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
            border: Border.all(color: AppColors.greenColors,width: 0.5),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10),
            child: Row(
//        mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  surahListModel.number.toString(),
                  style: TextStyle(color: AppColors.greenColors, fontSize: 16),
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  surahListModel.englishName.toString(),
                  style: TextStyle(color: AppColors.greenColors, fontSize: 16),
                ),
                Spacer(),
                Text(
                  surahListModel.name.toString(),
                  style: TextStyle(color: AppColors.greenColors, fontSize: 16),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
