//import 'package:flutter/material.dart';
//import 'package:perfectholyquran/utils/constants.dart';
//import 'package:perfectholyquran/widgets/quranPages.dart';
//import 'package:page_turn/page_turn.dart';
//
//class VisualQuran extends StatefulWidget {
//  const VisualQuran({key}) : super(key: key);
//
//  @override
//  _VisualQuranState createState() => _VisualQuranState();
//}
//
//class _VisualQuranState extends State<VisualQuran> {
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
//  final _controller = GlobalKey<PageTurnState>();
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
//      body: SafeArea(
//        child: PageTurn(
//          key: _controller,
//          duration: Duration(milliseconds: 200),
//          backgroundColor: Colors.white,
//          showDragCutoff: false,
//          lastPage: Container(child: Center(child: Text('Last Page!'))),
//          children: <Widget>[
//            for (var i = 0; i < juzzArabic.length; i++)
//              QuranPages(
//                page: i,
//                title: juzzArabic[i],
//              ),
//          ],
//        ),
//      ),
//    );
//  }
//}

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/constants.dart';


class VisualQuran extends StatelessWidget {

  List<String> imgList = [
    'assets/images/quran/1.png', 'assets/images/quran/2.png', 'assets/images/quran/3.png', 'assets/images/quran/4.png', 'assets/images/quran/5.png',
    'assets/images/quran/6.png', 'assets/images/quran/7.png', 'assets/images/quran/8.png', 'assets/images/quran/9.png', 'assets/images/quran/10.png',
    'assets/images/quran/11.png', 'assets/images/quran/12.png', 'assets/images/quran/13.png', 'assets/images/quran/14.png', 'assets/images/quran/15.png',
    'assets/images/quran/16.png', 'assets/images/quran/17.png', 'assets/images/quran/18.png', 'assets/images/quran/19.png', 'assets/images/quran/20.png',
    'assets/images/quran/21.png', 'assets/images/quran/22.png', 'assets/images/quran/23.png', 'assets/images/quran/24.png', 'assets/images/quran/25.png',
    'assets/images/quran/26.png', 'assets/images/quran/27.png', 'assets/images/quran/28.png', 'assets/images/quran/29.png', 'assets/images/quran/30.png',
    'assets/images/quran/31.png', 'assets/images/quran/32.png', 'assets/images/quran/33.png', 'assets/images/quran/34.png', 'assets/images/quran/35.png',
    'assets/images/quran/36.png', 'assets/images/quran/37.png', 'assets/images/quran/38.png', 'assets/images/quran/39.png', 'assets/images/quran/40.png',
    'assets/images/quran/41.png', 'assets/images/quran/42.png', 'assets/images/quran/43.png', 'assets/images/quran/44.png', 'assets/images/quran/45.png',
    'assets/images/quran/46.png', 'assets/images/quran/47.png', 'assets/images/quran/48.png', 'assets/images/quran/49.png', 'assets/images/quran/50.png',
    'assets/images/quran/51.png', 'assets/images/quran/52.png', 'assets/images/quran/53.png', 'assets/images/quran/54.png', 'assets/images/quran/55.png',
    'assets/images/quran/56.png', 'assets/images/quran/57.png', 'assets/images/quran/58.png', 'assets/images/quran/59.png', 'assets/images/quran/60.png',
    'assets/images/quran/61.png', 'assets/images/quran/62.png', 'assets/images/quran/63.png', 'assets/images/quran/64.png', 'assets/images/quran/65.png',
    'assets/images/quran/66.png', 'assets/images/quran/67.png', 'assets/images/quran/68.png', 'assets/images/quran/69.png', 'assets/images/quran/70.png',
    'assets/images/quran/71.png', 'assets/images/quran/72.png', 'assets/images/quran/73.png', 'assets/images/quran/74.png', 'assets/images/quran/75.png',
    'assets/images/quran/76.png', 'assets/images/quran/77.png', 'assets/images/quran/78.png', 'assets/images/quran/79.png', 'assets/images/quran/80.png',
    'assets/images/quran/81.png', 'assets/images/quran/82.png', 'assets/images/quran/83.png', 'assets/images/quran/84.png', 'assets/images/quran/85.png',
    'assets/images/quran/86.png', 'assets/images/quran/87.png', 'assets/images/quran/88.png', 'assets/images/quran/89.png', 'assets/images/quran/90.png',
    'assets/images/quran/91.png', 'assets/images/quran/92.png', 'assets/images/quran/93.png', 'assets/images/quran/94.png', 'assets/images/quran/95.png',
    'assets/images/quran/96.png', 'assets/images/quran/97.png', 'assets/images/quran/98.png', 'assets/images/quran/99.png', 'assets/images/quran/100.png',

    'assets/images/quran/101.png', 'assets/images/quran/102.png', 'assets/images/quran/103.png', 'assets/images/quran/104.png', 'assets/images/quran/105.png',
    'assets/images/quran/106.png', 'assets/images/quran/107.png', 'assets/images/quran/108.png', 'assets/images/quran/109.png', 'assets/images/quran/110.png',
    'assets/images/quran/111.png', 'assets/images/quran/112.png', 'assets/images/quran/113.png', 'assets/images/quran/114.png', 'assets/images/quran/115.png',
    'assets/images/quran/116.png', 'assets/images/quran/117.png', 'assets/images/quran/118.png', 'assets/images/quran/119.png', 'assets/images/quran/120.png',
    'assets/images/quran/221.png', 'assets/images/quran/222.png', 'assets/images/quran/223.png', 'assets/images/quran/224.png', 'assets/images/quran/225.png',
    'assets/images/quran/226.png', 'assets/images/quran/227.png', 'assets/images/quran/228.png', 'assets/images/quran/229.png', 'assets/images/quran/230.png',
    'assets/images/quran/231.png', 'assets/images/quran/232.png', 'assets/images/quran/233.png', 'assets/images/quran/234.png', 'assets/images/quran/235.png',
    'assets/images/quran/236.png', 'assets/images/quran/237.png', 'assets/images/quran/238.png', 'assets/images/quran/239.png', 'assets/images/quran/240.png',
    'assets/images/quran/241.png', 'assets/images/quran/242.png', 'assets/images/quran/243.png', 'assets/images/quran/244.png', 'assets/images/quran/245.png',
    'assets/images/quran/246.png', 'assets/images/quran/247.png', 'assets/images/quran/248.png', 'assets/images/quran/249.png', 'assets/images/quran/250.png',
    'assets/images/quran/251.png', 'assets/images/quran/252.png', 'assets/images/quran/253.png', 'assets/images/quran/254.png', 'assets/images/quran/255.png',
    'assets/images/quran/256.png', 'assets/images/quran/257.png', 'assets/images/quran/258.png', 'assets/images/quran/259.png', 'assets/images/quran/260.png',
    'assets/images/quran/261.png', 'assets/images/quran/262.png', 'assets/images/quran/263.png', 'assets/images/quran/264.png', 'assets/images/quran/265.png',
    'assets/images/quran/266.png', 'assets/images/quran/267.png', 'assets/images/quran/268.png', 'assets/images/quran/269.png', 'assets/images/quran/270.png',
    'assets/images/quran/271.png', 'assets/images/quran/272.png', 'assets/images/quran/273.png', 'assets/images/quran/274.png', 'assets/images/quran/275.png',
    'assets/images/quran/276.png', 'assets/images/quran/277.png', 'assets/images/quran/278.png', 'assets/images/quran/279.png', 'assets/images/quran/280.png',
    'assets/images/quran/281.png', 'assets/images/quran/282.png', 'assets/images/quran/283.png', 'assets/images/quran/284.png', 'assets/images/quran/285.png',
    'assets/images/quran/286.png', 'assets/images/quran/287.png', 'assets/images/quran/288.png', 'assets/images/quran/289.png', 'assets/images/quran/290.png',
    'assets/images/quran/291.png', 'assets/images/quran/292.png', 'assets/images/quran/293.png', 'assets/images/quran/294.png', 'assets/images/quran/295.png',
    'assets/images/quran/296.png', 'assets/images/quran/297.png', 'assets/images/quran/298.png', 'assets/images/quran/299.png', 'assets/images/quran/200.png',

    'assets/images/quran/201.png', 'assets/images/quran/202.png', 'assets/images/quran/203.png', 'assets/images/quran/204.png', 'assets/images/quran/205.png',
    'assets/images/quran/206.png', 'assets/images/quran/207.png', 'assets/images/quran/208.png', 'assets/images/quran/209.png', 'assets/images/quran/210.png',
    'assets/images/quran/211.png', 'assets/images/quran/212.png', 'assets/images/quran/213.png', 'assets/images/quran/214.png', 'assets/images/quran/215.png',
    'assets/images/quran/216.png', 'assets/images/quran/217.png', 'assets/images/quran/218.png', 'assets/images/quran/219.png', 'assets/images/quran/220.png',
    'assets/images/quran/221.png', 'assets/images/quran/222.png', 'assets/images/quran/223.png', 'assets/images/quran/224.png', 'assets/images/quran/225.png',
    'assets/images/quran/226.png', 'assets/images/quran/227.png', 'assets/images/quran/228.png', 'assets/images/quran/229.png', 'assets/images/quran/230.png',
    'assets/images/quran/231.png', 'assets/images/quran/232.png', 'assets/images/quran/233.png', 'assets/images/quran/234.png', 'assets/images/quran/235.png',
    'assets/images/quran/236.png', 'assets/images/quran/237.png', 'assets/images/quran/238.png', 'assets/images/quran/239.png', 'assets/images/quran/240.png',
    'assets/images/quran/241.png', 'assets/images/quran/242.png', 'assets/images/quran/243.png', 'assets/images/quran/244.png', 'assets/images/quran/245.png',
    'assets/images/quran/246.png', 'assets/images/quran/247.png', 'assets/images/quran/248.png', 'assets/images/quran/249.png', 'assets/images/quran/250.png',
    'assets/images/quran/251.png', 'assets/images/quran/252.png', 'assets/images/quran/253.png', 'assets/images/quran/254.png', 'assets/images/quran/255.png',
    'assets/images/quran/256.png', 'assets/images/quran/257.png', 'assets/images/quran/258.png', 'assets/images/quran/259.png', 'assets/images/quran/260.png',
    'assets/images/quran/261.png', 'assets/images/quran/262.png', 'assets/images/quran/263.png', 'assets/images/quran/264.png', 'assets/images/quran/265.png',
    'assets/images/quran/266.png', 'assets/images/quran/267.png', 'assets/images/quran/268.png', 'assets/images/quran/269.png', 'assets/images/quran/270.png',
    'assets/images/quran/271.png', 'assets/images/quran/272.png', 'assets/images/quran/273.png', 'assets/images/quran/274.png', 'assets/images/quran/275.png',
    'assets/images/quran/276.png', 'assets/images/quran/277.png', 'assets/images/quran/278.png', 'assets/images/quran/279.png', 'assets/images/quran/280.png',
    'assets/images/quran/281.png', 'assets/images/quran/282.png', 'assets/images/quran/283.png', 'assets/images/quran/284.png', 'assets/images/quran/285.png',
    'assets/images/quran/286.png', 'assets/images/quran/287.png', 'assets/images/quran/288.png', 'assets/images/quran/289.png', 'assets/images/quran/290.png',
    'assets/images/quran/291.png', 'assets/images/quran/292.png', 'assets/images/quran/293.png', 'assets/images/quran/294.png', 'assets/images/quran/295.png',
    'assets/images/quran/296.png', 'assets/images/quran/297.png', 'assets/images/quran/298.png', 'assets/images/quran/299.png', 'assets/images/quran/300.png',

    'assets/images/quran/301.png', 'assets/images/quran/302.png', 'assets/images/quran/303.png', 'assets/images/quran/304.png', 'assets/images/quran/305.png',
    'assets/images/quran/306.png', 'assets/images/quran/307.png', 'assets/images/quran/308.png', 'assets/images/quran/309.png', 'assets/images/quran/310.png',
    'assets/images/quran/311.png', 'assets/images/quran/312.png', 'assets/images/quran/313.png', 'assets/images/quran/314.png', 'assets/images/quran/315.png',
    'assets/images/quran/316.png', 'assets/images/quran/317.png', 'assets/images/quran/318.png', 'assets/images/quran/319.png', 'assets/images/quran/320.png',
    'assets/images/quran/321.png', 'assets/images/quran/322.png', 'assets/images/quran/323.png', 'assets/images/quran/324.png', 'assets/images/quran/325.png',
    'assets/images/quran/326.png', 'assets/images/quran/327.png', 'assets/images/quran/328.png', 'assets/images/quran/329.png', 'assets/images/quran/330.png',
    'assets/images/quran/331.png', 'assets/images/quran/332.png', 'assets/images/quran/333.png', 'assets/images/quran/334.png', 'assets/images/quran/335.png',
    'assets/images/quran/336.png', 'assets/images/quran/337.png', 'assets/images/quran/338.png', 'assets/images/quran/339.png', 'assets/images/quran/340.png',
    'assets/images/quran/341.png', 'assets/images/quran/342.png', 'assets/images/quran/343.png', 'assets/images/quran/344.png', 'assets/images/quran/345.png',
    'assets/images/quran/346.png', 'assets/images/quran/347.png', 'assets/images/quran/348.png', 'assets/images/quran/349.png', 'assets/images/quran/350.png',
    'assets/images/quran/351.png', 'assets/images/quran/352.png', 'assets/images/quran/353.png', 'assets/images/quran/354.png', 'assets/images/quran/355.png',
    'assets/images/quran/356.png', 'assets/images/quran/357.png', 'assets/images/quran/358.png', 'assets/images/quran/359.png', 'assets/images/quran/360.png',
    'assets/images/quran/361.png', 'assets/images/quran/362.png', 'assets/images/quran/363.png', 'assets/images/quran/364.png', 'assets/images/quran/365.png',
    'assets/images/quran/366.png', 'assets/images/quran/367.png', 'assets/images/quran/368.png', 'assets/images/quran/369.png', 'assets/images/quran/370.png',
    'assets/images/quran/371.png', 'assets/images/quran/372.png', 'assets/images/quran/373.png', 'assets/images/quran/374.png', 'assets/images/quran/375.png',
    'assets/images/quran/376.png', 'assets/images/quran/377.png', 'assets/images/quran/378.png', 'assets/images/quran/379.png', 'assets/images/quran/380.png',
    'assets/images/quran/381.png', 'assets/images/quran/382.png', 'assets/images/quran/383.png', 'assets/images/quran/384.png', 'assets/images/quran/385.png',
    'assets/images/quran/386.png', 'assets/images/quran/387.png', 'assets/images/quran/388.png', 'assets/images/quran/389.png', 'assets/images/quran/390.png',
    'assets/images/quran/391.png', 'assets/images/quran/392.png', 'assets/images/quran/393.png', 'assets/images/quran/394.png', 'assets/images/quran/395.png',
    'assets/images/quran/396.png', 'assets/images/quran/397.png', 'assets/images/quran/398.png', 'assets/images/quran/399.png', 'assets/images/quran/400.png',

    'assets/images/quran/401.png', 'assets/images/quran/402.png', 'assets/images/quran/403.png', 'assets/images/quran/404.png', 'assets/images/quran/405.png',
    'assets/images/quran/406.png', 'assets/images/quran/407.png', 'assets/images/quran/408.png', 'assets/images/quran/409.png', 'assets/images/quran/410.png',
    'assets/images/quran/411.png', 'assets/images/quran/412.png', 'assets/images/quran/413.png', 'assets/images/quran/414.png', 'assets/images/quran/415.png',
    'assets/images/quran/416.png', 'assets/images/quran/417.png', 'assets/images/quran/418.png', 'assets/images/quran/419.png', 'assets/images/quran/420.png',
    'assets/images/quran/421.png', 'assets/images/quran/422.png', 'assets/images/quran/423.png', 'assets/images/quran/424.png', 'assets/images/quran/425.png',
    'assets/images/quran/426.png', 'assets/images/quran/427.png', 'assets/images/quran/428.png', 'assets/images/quran/429.png', 'assets/images/quran/430.png',
    'assets/images/quran/431.png', 'assets/images/quran/432.png', 'assets/images/quran/433.png', 'assets/images/quran/434.png', 'assets/images/quran/435.png',
    'assets/images/quran/436.png', 'assets/images/quran/437.png', 'assets/images/quran/438.png', 'assets/images/quran/439.png', 'assets/images/quran/440.png',
    'assets/images/quran/441.png', 'assets/images/quran/442.png', 'assets/images/quran/443.png', 'assets/images/quran/444.png', 'assets/images/quran/445.png',
    'assets/images/quran/446.png', 'assets/images/quran/447.png', 'assets/images/quran/448.png', 'assets/images/quran/449.png', 'assets/images/quran/450.png',
    'assets/images/quran/451.png', 'assets/images/quran/452.png', 'assets/images/quran/453.png', 'assets/images/quran/454.png', 'assets/images/quran/455.png',
    'assets/images/quran/456.png', 'assets/images/quran/457.png', 'assets/images/quran/458.png', 'assets/images/quran/459.png', 'assets/images/quran/460.png',
    'assets/images/quran/461.png', 'assets/images/quran/462.png', 'assets/images/quran/463.png', 'assets/images/quran/464.png', 'assets/images/quran/465.png',
    'assets/images/quran/466.png', 'assets/images/quran/467.png', 'assets/images/quran/468.png', 'assets/images/quran/469.png', 'assets/images/quran/470.png',
    'assets/images/quran/471.png', 'assets/images/quran/472.png', 'assets/images/quran/473.png', 'assets/images/quran/474.png', 'assets/images/quran/475.png',
    'assets/images/quran/476.png', 'assets/images/quran/477.png', 'assets/images/quran/478.png', 'assets/images/quran/479.png', 'assets/images/quran/480.png',
    'assets/images/quran/481.png', 'assets/images/quran/482.png', 'assets/images/quran/483.png', 'assets/images/quran/484.png', 'assets/images/quran/485.png',
    'assets/images/quran/486.png', 'assets/images/quran/487.png', 'assets/images/quran/488.png', 'assets/images/quran/489.png', 'assets/images/quran/490.png',
    'assets/images/quran/491.png', 'assets/images/quran/492.png', 'assets/images/quran/493.png', 'assets/images/quran/494.png', 'assets/images/quran/495.png',
    'assets/images/quran/496.png', 'assets/images/quran/497.png', 'assets/images/quran/498.png', 'assets/images/quran/499.png', 'assets/images/quran/500.png',

    'assets/images/quran/501.png', 'assets/images/quran/502.png', 'assets/images/quran/503.png', 'assets/images/quran/504.png', 'assets/images/quran/505.png',
    'assets/images/quran/506.png', 'assets/images/quran/507.png', 'assets/images/quran/508.png', 'assets/images/quran/509.png', 'assets/images/quran/510.png',
    'assets/images/quran/511.png', 'assets/images/quran/512.png', 'assets/images/quran/513.png', 'assets/images/quran/514.png', 'assets/images/quran/515.png',
    'assets/images/quran/516.png', 'assets/images/quran/517.png', 'assets/images/quran/518.png', 'assets/images/quran/519.png', 'assets/images/quran/520.png',
    'assets/images/quran/521.png', 'assets/images/quran/522.png', 'assets/images/quran/523.png', 'assets/images/quran/524.png', 'assets/images/quran/525.png',
    'assets/images/quran/526.png', 'assets/images/quran/527.png', 'assets/images/quran/528.png', 'assets/images/quran/529.png', 'assets/images/quran/530.png',
    'assets/images/quran/531.png', 'assets/images/quran/532.png', 'assets/images/quran/533.png', 'assets/images/quran/534.png', 'assets/images/quran/535.png',
    'assets/images/quran/536.png', 'assets/images/quran/537.png', 'assets/images/quran/538.png', 'assets/images/quran/539.png', 'assets/images/quran/540.png',
    'assets/images/quran/541.png', 'assets/images/quran/542.png', 'assets/images/quran/543.png', 'assets/images/quran/544.png', 'assets/images/quran/545.png',
    'assets/images/quran/546.png', 'assets/images/quran/547.png', 'assets/images/quran/548.png', 'assets/images/quran/549.png', 'assets/images/quran/550.png',
    'assets/images/quran/551.png', 'assets/images/quran/552.png', 'assets/images/quran/553.png', 'assets/images/quran/554.png', 'assets/images/quran/555.png',
    'assets/images/quran/556.png', 'assets/images/quran/557.png', 'assets/images/quran/558.png', 'assets/images/quran/559.png', 'assets/images/quran/560.png',
    'assets/images/quran/561.png', 'assets/images/quran/562.png', 'assets/images/quran/563.png', 'assets/images/quran/564.png', 'assets/images/quran/565.png',
    'assets/images/quran/566.png', 'assets/images/quran/567.png', 'assets/images/quran/568.png', 'assets/images/quran/569.png', 'assets/images/quran/570.png',
    'assets/images/quran/571.png', 'assets/images/quran/572.png', 'assets/images/quran/573.png', 'assets/images/quran/574.png', 'assets/images/quran/575.png',
    'assets/images/quran/576.png', 'assets/images/quran/577.png', 'assets/images/quran/578.png', 'assets/images/quran/579.png', 'assets/images/quran/580.png',
    'assets/images/quran/581.png', 'assets/images/quran/582.png', 'assets/images/quran/583.png', 'assets/images/quran/584.png', 'assets/images/quran/585.png',
    'assets/images/quran/586.png', 'assets/images/quran/587.png', 'assets/images/quran/588.png', 'assets/images/quran/589.png', 'assets/images/quran/590.png',
    'assets/images/quran/591.png', 'assets/images/quran/592.png', 'assets/images/quran/593.png', 'assets/images/quran/594.png', 'assets/images/quran/595.png',
    'assets/images/quran/596.png', 'assets/images/quran/597.png', 'assets/images/quran/598.png', 'assets/images/quran/599.png', 'assets/images/quran/600.png',

    'assets/images/quran/601.png', 'assets/images/quran/602.png', 'assets/images/quran/603.png', 'assets/images/quran/604.png',

  ];

  @override
  Widget build(BuildContext context) {
    CarouselController carouselController = new CarouselController();
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: kPrimaryColor,
        title: Text('Visual Quran'),
        centerTitle: true,
      ),
      body: Stack(
        children: [
            Builder(
            builder: (context) {
              final double height = MediaQuery.of(context).size.height;
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: CarouselSlider(
                  carouselController: carouselController,
                  options: CarouselOptions(
                    height: height,
                    viewportFraction: 1.0,
                    enlargeCenterPage: false,
                    scrollDirection: Axis.horizontal,

                    reverse: false,
                    // autoPlay: false,
                  ),
                  items: imgList
                      .map((item) => Container(
                    child: Center(
                        child: Image.asset(
                          item,
                          fit: BoxFit.cover,
                          height: height,
                        )),
                  ))
                      .toList(),
                ),
              );
            },
          ),
          Align(
            alignment: Alignment.center,
            child: Container(
             // color: Colors.amber,
              height: 70,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  IconButton(onPressed: (){
                    carouselController.previousPage();
                  }, icon: Icon(Icons.arrow_back_ios,size: 32, color: Colors.blue,)),
                  IconButton(onPressed: (){
                    carouselController.nextPage();
                  }, icon: Icon(Icons.arrow_forward_ios,size: 32, color: Colors.blue)),
                ],
              ),
            ),
          ),
        ],

      ),
    );
  }
}