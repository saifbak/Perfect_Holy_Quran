import 'package:flutter/material.dart';
import 'package:perfectholyquran/canvachanges/Juzz%20Details.dart';
import 'package:perfectholyquran/mychanges/detail_screen.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/views/quran_juzz_screen.dart';

class JuzzListScreen extends StatefulWidget {
  @override
  _JuzzListScreenState createState() => _JuzzListScreenState();
}

class _JuzzListScreenState extends State<JuzzListScreen> {
  List<String> juzzArabic = [
    'آلم',
    'سَيَقُولُ',
    'تِلْكَ ٱلْرُّسُلُ',
    'لَنْ تَنَالُوْ الْبِرَّ',
    'وَٱلْمُحْصَنَاتُ',
    'لَا يُحِبُّ ٱللهُ',
    'وَإِذَا سَمِعُوا',
    'وَلَوْ أَنَّنَا',
    'قَالَ ٱلْمَلَأُ',
    'وَٱعْلَمُواْ',
    'يَعْتَذِرُونَ',
    'وَمَا مِنْ دَآبَّةٍ',
    'وَمَا أُبَرِّئُ',
    'رُبَمَا',
    'سُبْحَانَ ٱلَّذِى',
    'قَالَ أَلَمْ',
    'ٱقْتَرَبَ لِلْنَّاسِ',
    'قَدْ أَفْلَحَ',
    'وَقَالَ ٱلَّذِينَ',
    'أَمَّنْ خَلَقَ',
    'أُتْلُ مَاأُوْحِیَ',
    'وَمَنْ يَّقْنُتْ',
    'وَمَآ لي',
    'فَمَنْ أَظْلَمُ',
    'إِلَيْهِ يُرَدُّ',
    'حم',
    'قَالَ فَمَا خَطْبُكُم',
    'قَدْ سَمِعَ ٱللهُ',
    'تَبَارَكَ ٱلَّذِى',
    'عَمَّ'
  ];

  List<String> juzzEnglish = [
    'Alīf-Lām-Mīm',
    'Sayaqūlu',
    'Tilka ’r-Rusulu',
    'Lan tanaloo albirra',
    'Wa’l-muḥṣanātu',
    'Lā yuḥibbu-’llāhu',
    'Wa ’Idha Samiʿū',
    'Wa-law annanā',
    'Qāla ’l-mala’u',
    'Wa-’aʿlamū',
    'Yaʿtazerūn',
    'Wa mā min dābbatin',
    'Wa mā ubarri’u',
    'Rubamā',
    'Subḥāna ’lladhī',
    'Qāla ’alam',
    'Iqtaraba li’n-nāsi',
    'Qad ’aflaḥa',
    'Wa-qāla ’lladhīna',
    'A’man Khalaqa',
    'Otlu ma oohiya',
    'Wa-man yaqnut',
    'Wa-Mali',
    'Fa-man ’aẓlamu',
    'Ilayhi yuraddu',
    'Ḥā’ Mīm',
    'Qāla fa-mā khaṭbukum',
    'Qad samiʿa ’llāhu',
    'Tabāraka ’lladhī',
    'Amma'
  ];

  int _selectedIndex = 0;

  _onSelected(int index) {
    setState(() => _selectedIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        color: Colors.white,
        height: MediaQuery.of(context).size.height,
        child: ListView(
          shrinkWrap: true,
          physics: ClampingScrollPhysics(),
          children: [
            ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                scrollDirection: Axis.vertical,
                itemCount: juzzArabic.length,
                itemBuilder: (context, index) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          _onSelected(index);
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => JuzzDetails(
                                      juzzIndex: index + 1,
                                      juzzName: juzzEnglish[index])));
                        },
                        child: Container(
                          margin: EdgeInsets.symmetric(vertical: 1),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            border: Border.all(
                              color: _selectedIndex != null &&
                                      _selectedIndex == index
                                  ? AppColors.boxColors
                                  : Colors.white,
                              width: 3,
                            ),
                            borderRadius: _selectedIndex != null &&
                                    _selectedIndex == index
                                ? BorderRadius.circular(8)
                                : BorderRadius.circular(0),
                            boxShadow: _selectedIndex != null &&
                                    _selectedIndex == index
                                ? [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.4),
                                      spreadRadius: 3,
                                      blurRadius: 4,
                                      offset: Offset(
                                          0, 1), // changes position of shadow
                                    ),
                                  ]
                                : [],
                          ),
                          child: ListTile(
                            // hoverColor: AppColors.boxColors,
                            autofocus: false,
                            dense: true,
                            leading: Wrap(
                              children: [
                                Text(
                                  "${index + 1}.",
                                  style: TextStyle(
                                      color: AppColors.greenColors,
                                      fontSize: 18,
                                      fontWeight: FontWeight.w500),
                                ),
                                SizedBox(
                                  width: 2,
                                ),
                                Text(
                                  juzzEnglish[index],
                                  style: TextStyle(
                                      color: AppColors.greenColors,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500),
                                ),
                              ],
                            ),
                            trailing: Text(
                              juzzArabic[index],
                              style: TextStyle(
                                  color: AppColors.greenColors,
                                  fontSize: 16,
                                  fontFamily: "Noto Sans Arabic",
                                  fontWeight: FontWeight.w500),
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ),
                      Divider(color: AppColors.boxColors, height: 1),
                    ],
                  );
                }),
          ],
        ));
  }
}
