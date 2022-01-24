//import 'package:flutter/material.dart';
//import 'package:google_fonts_arabic/fonts.dart';
//import 'package:perfectholyquran/providers/juzz_list_provider.dart';
//import 'package:perfectholyquran/utils/app_colors.dart';
//import 'package:perfectholyquran/utils/constants.dart';
//import 'package:perfectholyquran/views/quran_juzz_screen.dart';
//import 'package:perfectholyquran/views/visualQuran.dart';
//import 'package:provider/provider.dart';
//
//class VisualQuranScreen extends StatelessWidget {
//  List<String> juzzArabic = [
//    'آلم',
//    'سَيَقُولُ',
//    'تِلْكَ ٱلْرُّسُلُ',
//    'لَنْ تَنَالُوْ الْبِرَّ',
//    'وَٱلْمُحْصَنَاتُ',
//    'لَا يُحِبُّ ٱللهُ',
//    'وَإِذَا سَمِعُوا',
//    'وَلَوْ أَنَّنَا',
//    'قَالَ ٱلْمَلَأُ',
//    'وَٱعْلَمُواْ',
//    'يَعْتَذِرُونَ',
//    'وَمَا مِنْ دَآبَّةٍ',
//    'وَمَا أُبَرِّئُ',
//    'رُبَمَا',
//    'سُبْحَانَ ٱلَّذِى',
//    'قَالَ أَلَمْ',
//    'ٱقْتَرَبَ لِلْنَّاسِ',
//    'قَدْ أَفْلَحَ',
//    'وَقَالَ ٱلَّذِينَ',
//    'أَمَّنْ خَلَقَ',
//    'أُتْلُ مَاأُوْحِیَ',
//    'وَمَنْ يَّقْنُتْ',
//    'وَمَآ لي',
//    'فَمَنْ أَظْلَمُ',
//    'إِلَيْهِ يُرَدُّ',
//    'حم',
//    'قَالَ فَمَا خَطْبُكُم',
//    'قَدْ سَمِعَ ٱللهُ',
//    'تَبَارَكَ ٱلَّذِى',
//    'عَمَّ'
//  ];
//
//  List<String> juzzEnglish = [
//    'Alīf-Lām-Mīm',
//    'Sayaqūlu',
//    'Tilka ’r-Rusulu',
//    'Lan tanaloo albirra',
//    'Wa’l-muḥṣanātu',
//    'Lā yuḥibbu-’llāhu',
//    'Wa ’Idha Samiʿū',
//    'Wa-law annanā',
//    'Qāla ’l-mala’u',
//    'Wa-’aʿlamū',
//    'Yaʿtazerūn',
//    'Wa mā min dābbatin',
//    'Wa mā ubarri’u',
//    'Rubamā',
//    'Subḥāna ’lladhī',
//    'Qāla ’alam',
//    'Iqtaraba li’n-nāsi',
//    'Qad ’aflaḥa',
//    'Wa-qāla ’lladhīna',
//    'A’man Khalaqa',
//    'Otlu ma oohiya',
//    'Wa-man yaqnut',
//    'Wa-Mali',
//    'Fa-man ’aẓlamu',
//    'Ilayhi yuraddu',
//    'Ḥā’ Mīm',
//    'Qāla fa-mā khaṭbukum',
//    'Qad samiʿa ’llāhu',
//    'Tabāraka ’lladhī',
//    'Amma'
//  ];
//
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      appBar: AppBar(
//        brightness: Brightness.dark,
//        backgroundColor: kPrimaryColor,
//        title: Text('Visual Quran'),
//        centerTitle: true,
//      ),
//
//      body: Padding(
//        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
//        child: ListView.builder(
//            scrollDirection: Axis.vertical,
//            itemCount: juzzArabic.length,
//            itemBuilder: (context, index) {
//              return juzzContainer(context, index);
//            }),
//      ),
//    );
//  }
//
//  Widget juzzContainer(BuildContext context, int index) {
//    return Padding(
//      padding: const EdgeInsets.symmetric(vertical: 6),
//      child: InkWell(
//        onTap: () {
//          int i;
//          if (index == 0) {
//            i = index + 1;
//            print(i);
//          } else if (index == 1) {
//            i = index + 1;
//            print(i);
//          } else if (index == 2) {
//            i = index + 1;
//            print(i);
//          } else if (index == 3) {
//            i = index + 1;
//            print(i);
//          } else if (index == 4) {
//            i = index + 1;
//            print(i);
//          } else if (index == 5) {
//            i = index + 1;
//            print(i);
//          } else if (index == 7) {
//            i = index + 1;
//            print(i);
//          } else if (index == 8) {
//            i = index + 1;
//            print(i);
//          } else if (index == 9) {
//            i = index + 1;
//            print(i);
//          } else if (index == 10) {
//            i = index + 1;
//            print(i);
//          } else if (index == 11) {
//            i = index + 1;
//            print(i);
//          } else if (index == 12) {
//            i = index + 1;
//            print(i);
//          } else if (index == 13) {
//            i = index + 1;
//            print(i);
//          } else if (index == 14) {
//            i = index + 1;
//            print(i);
//          } else if (index == 15) {
//            i = index + 1;
//            print(i);
//          } else if (index == 16) {
//            i = index + 1;
//            print(i);
//          } else if (index == 17) {
//            i = index + 1;
//            print(i);
//          } else if (index == 18) {
//            i = index + 1;
//            print(i);
//          } else if (index == 19) {
//            i = index + 1;
//            print(i);
//          } else if (index == 20) {
//            i = index + 1;
//            print(i);
//          } else if (index == 21) {
//            i = index + 1;
//            print(i);
//          } else if (index == 22) {
//            i = index + 1;
//            print(i);
//          } else if (index == 23) {
//            i = index + 1;
//            print(i);
//          } else if (index == 24) {
//            i = index + 1;
//            print(i);
//          } else if (index == 25) {
//            i = index + 1;
//            print(i);
//          } else if (index == 26) {
//            i = index + 1;
//            print(i);
//          } else if (index == 27) {
//            i = index + 1;
//            print(i);
//          } else if (index == 28) {
//            i = index + 1;
//            print(i);
//          } else if (index == 29) {
//            i = index + 1;
//            print(i);
//          }
//
//          Navigator.push(
//              context,
//              MaterialPageRoute(
//                  builder: (context) => VisualQuran(title: juzzArabic[index],
//                  )));
//        },
//        child: Container(
//          height: 80,
//          width: MediaQuery.of(context).size.width * 0.9,
//          decoration: BoxDecoration(
//            borderRadius: BorderRadius.circular(10),
//            color: Colors.white,
//            border: Border.all(color: Colors.black, width: 1),
//          ),
//          child: Padding(
//            padding: const EdgeInsets.symmetric(horizontal: 10),
//            child: Row(
//              children: [
//                Text(
//                  index.toString(),
//                  style: TextStyle(color: AppColors.greenColors, fontSize: 16),
//                ),
//                SizedBox(
//                  width: 10,
//                ),
//                Text(
//                  juzzEnglish[index],
//                  style: TextStyle(
//                    fontSize: 16.0,
//                    color: AppColors.greenColors,
//                  ),
//                ),
//                Spacer(),
//                Text(
//                  juzzArabic[index],
//                  style: TextStyle(
//                    fontFamily: ArabicFonts.Scheherazade,
//                    package: 'google_fonts_arabic',
//                    fontSize: 20.0,
//                    fontWeight: FontWeight.w600,
//                    color: AppColors.greenColors,
//                  ),
//                ),
//              ],
//            ),
//          ),
//        ),
//      ),
//    );
//  }
//}
