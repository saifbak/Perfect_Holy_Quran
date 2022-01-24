import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:perfectholyquran/models/juzz_details_model.dart';
import 'package:perfectholyquran/mychanges/audio_quran.dart';
import 'package:perfectholyquran/mychanges/sura_screen_tab.dart';
import 'package:perfectholyquran/providers/juzz_list_provider.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/widgets/play_pause.dart';
import 'package:provider/provider.dart';

class QuranJuzzScreen extends StatefulWidget {
  String  title;
  int index;
  QuranJuzzScreen({this.index, this.title, String juzzArabic});
  @override
  _QuranJuzzScreenState createState() => _QuranJuzzScreenState();
}

class _QuranJuzzScreenState extends State<QuranJuzzScreen> {
  final GlobalKey<ScaffoldState> _key = GlobalKey();
bool value=false;
  @override
  void initState() {
    super.initState();
    print(widget.index);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
    
      key: _key,
      child: 
      
      // SingleChildScrollView(
      //   child: Column(
      //     children: [
      //       Container(
      //         height: 90,
      //         child: Stack(
      //           children: [
      //             Positioned(
      //                 left: 15,
      //                 top: 60,
      //                 child: Text(
      //                   "Perfect Holy Quran",
      //                   style: TextStyle(
      //                       color: AppColors.greenColors,
      //                       fontSize: 16,
      //                       fontWeight: FontWeight.bold),
      //                 )),
      //             Positioned(
      //               right: 15,
      //               top: 50,
      //               child: Builder(builder: (context) {
      //                 return InkWell(
      //                   onTap: () {
      //                     Scaffold.of(context).openDrawer();
      //                   },
      //                   child: Icon(
      //                     Icons.menu,
      //                     size: 25,
      //                     color: AppColors.greenColors,
      //                   ),
      //                 );
      //               }),
      //             ),
      //           ],
      //         ),
      //       ),
      //       SizedBox(
      //         height: 10,
      //       ),
      //       Container(
      //         width: MediaQuery.of(context).size.width * 0.9,
      //         height: MediaQuery.of(context).size.height * 0.85,
      //         decoration: BoxDecoration(
      //           borderRadius: BorderRadius.circular(10),
      //           color: Colors.white,
      //           boxShadow: [
      //             BoxShadow(
      //               color: Colors.grey.withOpacity(0.5),
      //               spreadRadius: 1,
      //               blurRadius: 100,
      //               offset: Offset(0, 0.001), // changes position of shadow
      //             ),
      //           ],
      //         ),
      //         child: Column(
      //           children: [
      //             Padding(
      //               padding:
      //                   const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      //               child: Container(
      //                 height: 50,
      //                 width: MediaQuery.of(context).size.width,
      //                 decoration: BoxDecoration(
      //                     borderRadius: BorderRadius.circular(10),
      //                     color: AppColors.greenColors),
      //                 child: Center(
      //                     child: Text(
      //                   widget.title,
      //                   style: TextStyle(
      //                     fontFamily: ArabicFonts.Scheherazade,
      //                     package: 'google_fonts_arabic',
      //                     fontSize: 25.0,
      //                     fontWeight: FontWeight.w600,
      //                     color: Colors.white,
      //                   ),
      //                 )),
      //               ),
      //             ),
      
      
                  ChangeNotifierProvider(
                    create: (context) => JuzzDetailsProvider(widget.index),
                    child: Builder(builder: (context) {
                      final productData =
                          Provider.of<JuzzDetailsProvider>(context);
      
                      if (productData.juzzDetailsState ==
                          JuzzListState.Loading) {
                        return Center(child: CircularProgressIndicator());
                      }
                      if (productData.juzzDetailsState == JuzzListState.Error) {
                        return Center(
                            child: Text(
                                'An Error Occured ${productData.message}'));
                      }
                      final productsData = productData.juzzListModel;
                      print(productsData.length);
                      return Column(
                        children: [
                         
                          Expanded(
                            flex:6,
                          child: ListView.builder(
                              itemCount: productsData.length,
                              scrollDirection: Axis.vertical,
                              itemBuilder: (BuildContext context, int index) {
                                final prod = productsData[index];
                                return surahContainer(context, index, prod);
                              }),
                        ),
                        //  FloatingActionButton(
                        //   //  bool value=false;
                        //    onPressed: (){
                        //      print(productsData[0].audio[1]);
                        //     //  setState(() {
                        //     //    value=true;

                        //     //  });
                        //   // bool value=true;
                        //  },
                        //  child: QuranAudio(
                        //      isPressed: value,
                        //    url: productsData[0].audio,
                        //  )
                      
                        //  ),
                        ]
                      );
                    }),
                  ),);
  }

  Widget surahContainer(
      BuildContext context, int index, JuzzDetailsModel prod) {
    return   Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        child: Column(
          children:[
          // add missing ayats
          (prod.numberInSurah==81 && prod.number==750)?
         Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundColor: AppColors.greenColors,
                      radius: 10,
                      child: Text(
                        arabicNumber.convert(prod.numberInSurah),
                        ),
                    ),
                  ),
                  
                  Expanded(
                    flex: 6,
                    child: Text("۞ لَتَجِدَنَّ أَشَدَّ ٱلنَّاسِ عَدَٰوَةًۭ لِّلَّذِينَ ءَامَنُوا۟ ٱلْيَهُودَ وَٱلَّذِينَ أَشْرَكُوا۟ ۖ وَلَتَجِدَنَّ أَقْرَبَهُم مَّوَدَّةًۭ لِّلَّذِينَ ءَامَنُوا۟ ٱلَّذِينَ قَالُوٓا۟ إِنَّا نَصَٰرَىٰ ۚ ذَٰلِكَ بِأَنَّ مِنْهُمْ قِسِّيسِينَ وَرُهْبَانًۭا وَأَنَّهُمْ لَا يَسْتَكْبِرُونَ",
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.lato(
                       fontSize: 18.0,
                       fontWeight: FontWeight.w500,
                       color: AppColors.greenColors,),
                    ),
                  ),
                  
                ],

              ):

          
            (prod.numberInSurah==93 && prod.number==386)?
         Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [

                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundColor: AppColors.greenColors,
                      radius: 10,
                      child: Text(
                        arabicNumber.convert(prod.numberInSurah),
                        ),
                    ),
                  ),
                  
                  Expanded(
                    flex: 6,
                    child: Text("لَن تَنَالُوا۟ ٱلْبِرَّ حَتَّىٰ تُنفِقُوا۟ مِمَّا تُحِبُّونَ ۚ وَمَا تُنفِقُوا۟ مِن شَىْءٍۢ فَإِنَّ ٱللَّهَ بِهِۦ عَلِيمٌۭ",
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.lato(
                       fontSize: 18.0,
                       fontWeight: FontWeight.w600,
                       color: AppColors.greenColors,),
                    ),
                  ),
                  
                ],

              ):

          
            
            // (prod.number===)
            // add bismallah to every surah
            (prod.numberInSurah==1 && prod.number!=1 && prod.number!=9)?
          Column(
            children: [
              Text("بِسْمِ ٱللَّهِ ٱلرَّحْمَٰنِ ٱلرَّحِيمِ",
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.lato(
                       fontSize: 22.0,
                       fontWeight: FontWeight.w600,
                       color: AppColors.greenColors,),
                    ),

              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: CircleAvatar(
                      backgroundColor: AppColors.greenColors,
                      radius: 10,
                      child: Text(
                        arabicNumber.convert(prod.numberInSurah),
                        ),
                    ),
                  ),
                  Expanded(
                    flex: 6,
                    child: Text(prod.text.substring(39),
                    textDirection: TextDirection.rtl,
                    style: GoogleFonts.lato(
                       fontSize: 18.0,
                       fontWeight: FontWeight.w600,
                       color: AppColors.greenColors,),
                    ),
                  ),
                  
                ],

              ),
            ],
          )
             :Column(
               children:[ 
                 (prod.juz==3 && prod.numberInSurah==92 && prod.page==62 || prod.juz==7 && prod.numberInSurah==82 && prod.page==121 )?
                 Container():
              Row(
                         mainAxisAlignment: MainAxisAlignment.end,
                         crossAxisAlignment: CrossAxisAlignment.end,
                         children: [
                Expanded(
                  flex: 2,
                  child: CircleAvatar(
                    backgroundColor: AppColors.greenColors,
                    radius: 10,
                    child: Text( arabicNumber.convert(prod.numberInSurah),),
                  ),
                ),
                Expanded(
                  flex: 6,
                  child: Text(prod.text,
                  textDirection: TextDirection.rtl,
                  style: GoogleFonts.lato(
                    
                     fontSize: 18.0,
                     fontWeight: FontWeight.w600,
                     color: AppColors.greenColors,),
                  ),
                ),
                
                         ],
             
                       ),
               ]
             ),
         
          ]
        ),
      ),
    );
}
}