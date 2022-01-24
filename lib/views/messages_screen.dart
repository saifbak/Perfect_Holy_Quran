import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:intl/intl.dart';
import 'package:perfectholyquran/models/message_model.dart';
import 'package:perfectholyquran/models/messages_model.dart';
import 'package:perfectholyquran/mychanges/quran_api.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:provider/provider.dart';

import 'dart:convert';
import 'package:html/parser.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;





class MessagesScreen extends StatefulWidget {
  @override
  _MessagesScreenState createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen> {
  var _isLoading = true; //For progress bar
  var posts;
  var imgUrl;

  //initialization
  void initState() {
    super.initState();
    _fetchData();
  }
  //Function to fetch data from JSON
  @override
  _fetchData() async {
    print("attempting");
    final url =
        "https://www.googleapis.com/blogger/v3/blogs/274500741576810163/posts/?key=AIzaSyBcz7pA0o-Rh8DRT5WdsK24aB_frhaYI0I";
    final response = await http.get(Uri.parse(url));
    print(response);
    if (response.statusCode == 200) {
      //HTTP OK is 200
      final Map items = json.decode(response.body);
      var post = items['items'];

      setState(() {
        _isLoading = false;
        this.posts = post;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    print(imgUrl
        .toString());

    return new Scaffold(
        appBar: new AppBar(
          title: new Text("Messages"),
          backgroundColor: AppColors.greenColors,
          actions: <Widget>[
            new IconButton(
                icon: new Icon(Icons.refresh),
                onPressed: () {
                  setState(() {
                    _isLoading = true;
                  });
                  _fetchData();
                })
          ],
        ),
        body: new Center(
            child: _isLoading
                ? new CircularProgressIndicator()
                : new ListView.builder(
              itemCount: this.posts != null ? this.posts.length : 0,
              itemBuilder: (context, i) {
                final Post = this.posts[i];
                final postDesc = Post["content"];



                //All the below code is to fetch the image
                var document = parse(postDesc);
                //Regular expression
                RegExp regExp = new RegExp(
                  r"(https?:\/\/.*\.(?:png|jpg|gif))",
                  caseSensitive: false,
                  multiLine: false,
                );
                final match = regExp
                    .stringMatch(document.outerHtml.toString())
                    .toString();
                // print(document.outerHtml);
                // print("firstMatch : " + match);
                //Converting the regex output to image (Slashing) , since the output from regex was not perfect for me
                if (match.length > 5) {
                  if (match.contains(".jpg")) {
                    imgUrl = match.substring(0, match.indexOf(".jpg"));
                    print(imgUrl);

                  } else {

                    imgUrl =
                    "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg";
                  }
                }
                String description = document.body.text.trim();
                print(description);



                return GestureDetector(
                  onTap: () {
                    //We will pass description to postview through an argument
                    Navigator
                        .of(context)
                        .push(new MaterialPageRoute<Null>(
                      builder: (BuildContext context) {
                        return PostView(Post['title'],description,imgUrl);
                      },
                    ));
                  },
                  child: new Container(
                    padding:
                    const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 8.0),
                    child: new Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        // new Container(
                        //   width: 500.0,
                        //   height: 180.0,
                        //   decoration: new BoxDecoration(
                        //     shape: BoxShape.rectangle,
                        //     image: new DecorationImage(
                        //         fit: BoxFit.fill,
                        //         //check if the image is not null (length > 5) only then check imgUrl else display default img
                        //         image: new NetworkImage(imgUrl
                        //             .toString()
                        //             .length >
                        //             10
                        //             ? imgUrl.toString()
                        //             : "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")
                        //     ),
                        //   ),
                        // ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [new Padding(
                            padding:
                            const EdgeInsets.symmetric(vertical: 10.0),
                            child: new Text(
                              Post["title"],
                              maxLines: 3,
                              style: new TextStyle(
                                fontSize: 18.0,
                                fontWeight: FontWeight.bold,
                                color: _isDarkMode ? AppColors.greenColors: Colors.white,
                              ),
                            ),
                          ),
                            new Text(
                              Post["published"].toString().substring(0, 10),
                              maxLines: 2,

                              overflow: TextOverflow.ellipsis,
                              style: new TextStyle(fontSize: 12.0,color: _isDarkMode ? AppColors.greenColors: Colors.white,),
                            ),
                          ],
                        ),
                        new Text(
                          description.replaceAll("\n", ", "),
                          maxLines: 2,

                          overflow: TextOverflow.ellipsis,
                          style: new TextStyle(fontSize: 15.0,color: _isDarkMode ? AppColors.greenColors: Colors.white,),
                        ),

                        // new Padding(
                        //   padding:
                        //   const EdgeInsets.symmetric(vertical: 16.0),
                        //   child: new RaisedButton(
                        //     child: new Text("READ MORE",style: new TextStyle(color: Colors.white),),
                        //     color: Colors.blue,
                        //     // onPressed: () {
                        //     //   //We will pass description to postview through an argument
                        //     //   Navigator
                        //     //       .of(context)
                        //     //       .push(new MaterialPageRoute<Null>(
                        //     //     builder: (BuildContext context) {
                        //     //       return PostView(Post['title'],description,imgUrl);
                        //     //     },
                        //     //   ));
                        //     // },
                        //   ),
                        // ),
                        Divider(),
                      ],
                    ),
                  ),
                );
              },
            )));
  }
}

class PostView extends StatelessWidget {
  var desc, title, image;

  PostView(String title, String desc, String image) {
    this.desc = desc;
    this.title = title;
    this.image = image;
  }
  @override
  Widget build(BuildContext context) {
    var _isDarkMode = Theme.of(context).brightness == Brightness.light;
    if (desc.toString().contains("\n\n\n\n")) {
      desc = desc.toString().replaceAll("\n\n\n\n", "\n\n");
    }

    if (desc.toString().contains("\n\n\n")) {
      desc = desc.toString().replaceAll("\n\n\n", "\n");
    }
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("Messages"),
        backgroundColor: AppColors.greenColors,
      ),
      body: new Container(
          child: new SingleChildScrollView(
              child: new Column(
                children: <Widget>[
                  new Padding(
                    padding:
                    const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                    child: new Text(
                      title,
                      style: new TextStyle(
                        fontSize: 22.0,
                        color: _isDarkMode ? Color(0xff025241): Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  // new Padding(
                  //   padding:
                  //   const EdgeInsets.symmetric(vertical: 16.0, horizontal: 16.0),
                  //   child: new Container(
                  //     width: 500.0,
                  //     height: 180.0,
                  //     decoration: new BoxDecoration(
                  //       shape: BoxShape.rectangle,
                  //       image: new DecorationImage(
                  //           fit: BoxFit.fill,
                  //           //check if the image is not null (length > 5) only then check imgUrl else display default img
                  //           image: new NetworkImage(image.toString().length > 10
                  //               ? image.toString()
                  //               : "https://pbs.twimg.com/profile_images/916384996092448768/PF1TSFOE_400x400.jpg")),
                  //     ),
                  //   ),
                  // ),
                  new Padding(
                    padding:
                    const EdgeInsets.only( right: 30, left: 6, top: 16, bottom: 16),
                    child: new Text(
                      desc,
                      style: new TextStyle(
                        fontSize: 18.0,
                        color: _isDarkMode ? AppColors.greenColors: Colors.white,
                      ),
                    ),
                  ),
                ],
              ))),
    );
  }
}
// class MessagesScreen extends StatefulWidget {
//   @override
//   _MessagesScreenState createState() => _MessagesScreenState();
// }
//
// class _MessagesScreenState extends State<MessagesScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//
//       appBar:  AppBar(
//         title: Text("Messages"),
//         centerTitle: true,
//         backgroundColor: AppColors.greenColors,
//       ),
//
//       body: FutureBuilder(
//         future: QuranAPI().getMessages(),
//         builder:
//         (BuildContext context, AsyncSnapshot <List<Message>> snapshot){
//
//           if (snapshot.connectionState == ConnectionState.waiting) {
//         return Center(child: CircularProgressIndicator());
//       } else if (snapshot.connectionState == ConnectionState.done) {
//         if (snapshot.hasError) {
//           return  Text(snapshot.error.toString());
//         } else if (snapshot.hasData) {
//           return
//
//         Container(
//           decoration: BoxDecoration(
//             image: DecorationImage(image: AssetImage("assets/background.png"))
//           ),
//           child: ListView.builder(
//             itemCount: snapshot.data.length,
//             itemBuilder: (context, int index){
//
//             return Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: InkWell(
//                 onTap: (){
//                   Navigator.push(context, MaterialPageRoute(builder: (context)=>MessageDetail(snapshot.data[index].title,snapshot.data[index].arabic,snapshot.data[index].english,snapshot.data[index].day)));
//                 },
//                 child: ListTile(
//
//                           leading: CircleAvatar(
//                           backgroundImage: AssetImage("assets/logo.png"),
//                           ),
//
//                           title: Text(snapshot.data[index].title.toString()),
//                           subtitle: Text(snapshot.data[index].day.toString()),
//                           // trailing: Text(DateFormat("yyyy-MM-dd").format(DateTime.now()))
//                           ),
//               ),
//             );
//
//           }),
//         );
//           } else {
//             return const Text('Empty data');
//           }
//         } else {
//           return Text('State: }');
//         }
//         }
//
//         ),
//
//     );
// //
// }
// }

// class MessageDetail extends StatelessWidget {
//   String title;
//   String arabictext;
//   String englishtext;
//   String day;
//
//   MessageDetail(this.title,this.arabictext,this.englishtext,this.day);
//
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text(title.toString()),
//       backgroundColor: AppColors.greenColors,
//
//       centerTitle: true,
//       ),
//       body: Container(
//         decoration: BoxDecoration(
//           image: DecorationImage(image: AssetImage("assets/background.png"))
//         ),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.start,
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(title.toString(),style: TextStyle(color: AppColors.greenColors,fontSize: 16,fontWeight: FontWeight.w700),),
//           ),
//           Padding(
//             padding: const EdgeInsets.all(8.0),
//             child: Text(day.toString(),style: TextStyle(color: AppColors.greenColors,fontSize: 12,fontWeight: FontWeight.w700),),
//           ),
//           Hero(
//             tag: "messageCard",
//
//             child: Expanded(
//               flex: 1,
//               child: Card(
//                 color: Colors.grey[300],
//                 margin: EdgeInsets.all(8.0),
//                 elevation: 2.0,
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   crossAxisAlignment:CrossAxisAlignment.center,
//                   children: [
//                     // Text("For Breaking Fast - Iftar Dua - 1"),
//                     Text(arabictext.toString(),textAlign: TextAlign.left,style: GoogleFonts.lato(fontWeight: FontWeight.w700 )),
//                     Divider(thickness: 2,),
//                     Padding(
//                       padding: const EdgeInsets.all(8.0),
//                       child: Text(
//                         englishtext.toString(),
//                         style: TextStyle(fontSize: 12,fontWeight: FontWeight.w700),
//                         ),
//                     ),
//                     // SizedBox(height: 200,)
//                   ],
//                 ),
//               ),
//             ),
//           )
//         ],),
//       ),
//
//     );
//   }
// }
