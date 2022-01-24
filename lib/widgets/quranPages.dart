import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/constants.dart';

class QuranPages extends StatelessWidget {
  final int page;
  final String title;

  const QuranPages({Key key, this.page, this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {

    int i;
    if (page == 0) {
      i = page + 1;
      print(i);
    } else if (page == 1) {
      i = page + 1;
      print(i);
    } else if (page == 2) {
      i = page + 1;
      print(i);
    } else if (page == 3) {
      i = page + 1;
      print(i);
    } else if (page == 4) {
      i = page + 1;
      print(i);
    } else if (page == 5) {
      i = page + 1;
      print(i);
    } else if (page == 7) {
      i = page + 1;
      print(i);
    } else if (page == 8) {
      i = page + 1;
      print(i);
    } else if (page == 9) {
      i = page + 1;
      print(i);
    } else if (page == 10) {
      i = page + 1;
      print(i);
    } else if (page == 11) {
      i = page + 1;
      print(i);
    } else if (page == 12) {
      i = page + 1;
      print(i);
    } else if (page == 13) {
      i = page + 1;
      print(i);
    } else if (page == 14) {
      i = page + 1;
      print(i);
    } else if (page == 15) {
      i = page + 1;
      print(i);
    } else if (page == 16) {
      i = page + 1;
      print(i);
    } else if (page == 17) {
      i = page + 1;
      print(i);
    } else if (page == 18) {
      i = page + 1;
      print(i);
    } else if (page == 19) {
      i = page + 1;
      print(i);
    } else if (page == 20) {
      i = page + 1;
      print(i);
    } else if (page == 21) {
      i = page + 1;
      print(i);
    } else if (page == 22) {
      i = page + 1;
      print(i);
    } else if (page == 23) {
      i = page + 1;
      print(i);
    } else if (page == 24) {
      i = page + 1;
      print(i);
    } else if (page == 25) {
      i = page + 1;
      print(i);
    } else if (page == 26) {
      i = page + 1;
      print(i);
    } else if (page == 27) {
      i = page + 1;
      print(i);
    } else if (page == 28) {
      i = page + 1;
      print(i);
    } else if (page == 29) {
      i = page + 1;
      print(i);
    }


    return DefaultTextStyle.merge(
      style: TextStyle(fontSize: 16.0),
      child: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 8.0),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
            decoration: BoxDecoration(
                border: Border.all(
                  color: kPrimaryColor,
                ),
                borderRadius: BorderRadius.circular(10)),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  "CHAPTER $i",
                  style: TextStyle(
                    fontSize: 32.0,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24.0,
                    fontWeight: FontWeight.w500,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 32.0),
//                Row(
//                  crossAxisAlignment: CrossAxisAlignment.start,
//                  children: <Widget>[
//                    Expanded(
//                      child: Text(
//                          "Alice was beginning to get very tired of sitting by her sister on the bank, and of"
//                          " having nothing to do: once or twice she had peeped into the book her sister was "
//                          "reading, but it had no pictures or conversations in it, `and what is the use of "
//                          "a book,' thought Alice `without pictures or conversation?'"),
//                    ),
//                    Container(
//                      margin: const EdgeInsets.only(left: 12.0),
//                      color: Colors.black26,
//                      width: 160.0,
//                      height: 220.0,
//                      child: Placeholder(),
//                    ),
//                  ],
//                ),
//                const SizedBox(height: 0.0),
//                Text(
//                    "So she was considering in her own mind (as well as she could, for the hot day made her "
//                    "feel very sleepy and stupid), whether the pleasure of making a daisy-chain would be "
//                    "worth the trouble of getting up and picking the daisies, when suddenly a White "
//                    "Rabbit with pink eyes ran close by her.\n"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
