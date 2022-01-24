import 'package:flutter/material.dart';
import 'package:perfectholyquran/services/paypal_payment.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';
import 'package:perfectholyquran/views/payment_screen.dart';

class SadqaScreen extends StatefulWidget {
  @override
  _SadqaScreenState createState() => _SadqaScreenState();
}

class _SadqaScreenState extends State<SadqaScreen> {

  List<String> gifts = ['2 Copies', '4 Copies', '6 Copies', '8 Copies', '12 Copies', '15 Copies', '20 Copies', '30 Copies', '50 Copies', '100 Copies'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        brightness: Brightness.dark,
        backgroundColor: kPrimaryColor,
        title: Text('Sadqa Jaria Gift Pool'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            SizedBox(height: 30,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 25),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text("Your Purchased Gifts", style: TextStyle(fontSize: 16, color: Colors.black),),

                  Container(
                    height: 40,
                    width: 40,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: AppColors.greenColors,
                    ),

                    child: Center(child: Text("0", style: TextStyle(fontSize: 16, color: Colors.white),)),
                  ),

                ],
              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: EdgeInsets.symmetric(horizontal: 10),
              child: GridView.builder(
                  itemCount: gifts.length,
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 3, crossAxisSpacing: 10, mainAxisSpacing: 10),
                  itemBuilder: (BuildContext context, int index) {

                    return InkWell(
                      onTap: () {
                     // Navigator.push(context, MaterialPageRoute(builder: (context) {return PaymentScreen();}));
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (BuildContext context) => PaypalPayment(
                              onFinish: (number) async {

                                // payment done
                                print('order id: '+number);

                              },
                            ),
                          ),
                        );
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 10,
                              offset: Offset(
                                  0, 3), // changes position of shadow
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset("assets/quranRail.png", height: 60, width: 60,),
                            SizedBox(height: 10,),
                            Text(gifts[index],
                              style: TextStyle(
                                fontSize: 12,
                                color: AppColors.greenColors,
                              ),),
                          ],
                        ),
                      ),
                    );
                  }

              ),
            ),

            SizedBox(height: 20,),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("Gift Info", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "You can purchase and gift these copies as 'Hadiya' "
                    "to users of our app (randomly selected) to earn ajar."
                    "You can distribute gifts to your friend and family.",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 10,),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Divider(
                thickness: 2,
                color: AppColors.greenColors,
              ),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Text("How It Works?", style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),),
            ),

            SizedBox(height: 10,),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "PHQ will offer Quran Majeed app without adds for free (as Sadqa Jaria from you) to new users till the purchased number of copies have been downloaded",
                softWrap: false,
                overflow: TextOverflow.ellipsis,
                maxLines: 6,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                ),
              ),
            ),

            SizedBox(height: 30,),
          ],
        ),
      ),
    );
  }
}
