import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class PrivacyScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    return SafeArea(
      child: Scaffold(
        // appBar: AppBar(
        //   backgroundColor: Colors.white.withOpacity(0),
        //   // title: Text(
        //   //   "Privacy Policy",
        //   //   style: TextStyle(
        //   //       color: _isDarkMode ? Color(0xff025241) : Colors.white,
        //   //       fontSize: 20),
        //   // ),
        //   bottom: PreferredSize(
        //     preferredSize: Size(0, 80),
        //     child: Text(
        //       "Privacy Policy",
        //       style: TextStyle(
        //         color: _isDarkMode ? Color(0xff025241) : Colors.white,
        //         fontWeight: FontWeight.bold,
        //         fontSize: 20,
        //       ),
        //     ),
        //   ),
        //   // centerTitle: true,
        //   elevation: 0.0,
        //   // leading: InkWell(
        //   //     onTap: () => Navigator.of(context).pop(),
        //   //     child: Icon(
        //   //       Icons.arrow_back_ios,
        //   //       color: _isDarkMode ? Color(0xff025241) : Colors.white,
        //   //     )
        //   // ),
        //   automaticallyImplyLeading: false,
        // ),
        body: Container(
          decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage(
                "assets/background.png",
              ),
              fit: BoxFit.cover,
            ),
          ),
          padding: const EdgeInsets.only(top: 30.0),
          child: ListView(
            children: [
              SizedBox(
                height: getScreenHeight(30),
              ),
              Center(
                child: Text(
                  "Privacy Policy",
                  style: TextStyle(
                    color: _isDarkMode ? Color(0xff025241) : Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
              SizedBox(
                height: getScreenHeight(30),
              ),
              Center(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.9,
                  height: 460,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 5,
                        blurRadius: 7,
                        offset: Offset(0, 3), // changes position of shadow
                      ),
                    ],
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Image.asset(
                        "assets/privacy.PNG",
                        scale: 1.5,
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Text(
                        "Privacy Policy",
                        style: TextStyle(
                          color: AppColors.greenColors,
                          fontSize: 20,
                        ),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Text(
                            "It is a long established fact that a reader will be distracted by the readable content of a page when looking at its layout."
                            " The point of using Lorem Ipsum is that it has a more-or-less normal distribution of letters, as opposed to using 'Content here, "
                            "content here', making it look like readable English. Many desktop publishing packages and web page editors now use Lorem Ipsum as "
                            "their default model text, and a search for 'lorem ipsum' will uncover many web sites still in their infancy. Various versions have evolved"
                            " over the years, sometimes by accident, sometimes on purpose (injected humour and the like).",
//                  textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 12, color: AppColors.greenColors),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              SizedBox(
                height: getScreenHeight(30),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
