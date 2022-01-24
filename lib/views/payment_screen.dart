import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:perfectholyquran/utils/app_colors.dart';

class PaymentScreen extends StatefulWidget {
  @override
  _PaymentScreenState createState() => _PaymentScreenState();
}

class _PaymentScreenState extends State<PaymentScreen> {
  TextEditingController cardHolderNameController = TextEditingController();
  TextEditingController cardNumberController = TextEditingController();
  TextEditingController expiresDateController = TextEditingController();
  TextEditingController cvvController = TextEditingController();

  final _formKey = GlobalKey<FormState>();
  bool _autoValidate = false;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Payment Details",
          style: TextStyle(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.greenColors,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  controller: cardHolderNameController,
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(labelText: 'Holder Name', labelStyle: TextStyle(fontSize: 12)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Card Holder Name';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cardNumberController,
                  maxLength: 16,
                  decoration: InputDecoration(
                    labelText: 'Creadit Card Number',
                    labelStyle: TextStyle(fontSize: 12),
                    suffixIcon: Icon(
                      Icons.credit_card,
                      color: AppColors.greenColors,
                    ),
                  ),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Creadit Card No';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child:  TextFormField(
                  keyboardType: TextInputType.datetime,
                  controller: expiresDateController,
                  decoration: InputDecoration(labelText: 'Expires Date', labelStyle: TextStyle(fontSize: 12)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter Expires date';
                    }
                    return null;
                  },
                ),
              ),

              SizedBox(
                height: 20,
              ),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cvvController,
                  maxLength: 3,
                  decoration: InputDecoration(labelText: 'CVV' , labelStyle: TextStyle(fontSize: 12)),
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please enter CVV No';
                    }
                    return null;
                  },
                ),
              ),
              SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  if (_formKey.currentState.validate()) {
                    _formKey.currentState.save();

                    Fluttertoast.showToast(
                        msg: "Purchased Successfully",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.greenColors,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
//
//                    Navigator.push(context, MaterialPageRoute(
//                      builder: (context) => PickupPayNowScreen(firstName: widget.firstName, lastName: widget.lastName,
//                        email: widget.email, contact: widget.contact, hotelName: widget.hotelName,
//                        booking_date: widget.booking_date, adult: widget.adult, child: widget.child,
//                        destination: widget.destination, pickup_date: widget.pickup_date, pickup_time: widget.pickup_time,),
//                    ),
//                    );
//
                  } else {
                    setState(() {
                      _autoValidate = true;
                    });

                    Fluttertoast.showToast(
                        msg: "Please Complete the form properly",
                        toastLength: Toast.LENGTH_LONG,
                        gravity: ToastGravity.BOTTOM,
                        timeInSecForIosWeb: 1,
                        backgroundColor: AppColors.greenColors,
                        textColor: Colors.white,
                        fontSize: 16.0
                    );
                  }


                },
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: 50,
                  alignment: Alignment.bottomRight,
                  padding: EdgeInsets.symmetric(horizontal: 30.0),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30.0),
                      color: AppColors.greenColors),
                  child: Center(
                    child: Text(
                      "Purchase",
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
