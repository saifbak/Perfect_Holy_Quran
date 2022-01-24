import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/app_colors.dart';
import 'package:perfectholyquran/utils/constants.dart';

duaListItem(dua, translation) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 1,
    ),
    decoration: BoxDecoration(
      color: Colors.white,
      borderRadius: BorderRadius.circular(10),
    ),
    child: Padding(
      padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
      child: Column(
        children: [
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Dua",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 5),
              child: Text(
                dua,
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.center,
              )),
          SizedBox(
            height: 15,
          ),
          Container(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                "Translation",
                style: TextStyle(
                  color: kSecondaryColor,
                  fontWeight: FontWeight.w500,
                  fontSize: 17,
                ),
              )),
          SizedBox(
            height: 15,
          ),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              translation,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    ),
  );
}

categoriesItem(image, title, color) {
  return Container(
    margin: EdgeInsets.symmetric(
      vertical: 1,
    ),
    color: Colors.transparent,
    width: 110,
    child: Column(
      children: [
        Container(
            height: 100,
            width: 100,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Container(
                height: 40,
                width: 40,
                child: Image.asset(
                  image,
                  width: 40,
                  height: 40,
                  fit: BoxFit.contain,
                ),
              ),
            )),
        SizedBox(
          height: 5,
        ),
        Container(
            padding: EdgeInsets.symmetric(horizontal: 5),
            child: Text(
              title,
              textAlign: TextAlign.center,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                fontSize: 13,
              ),
            ))
      ],
    ),
  );
}

searchInputField(controller, hint, backgroundColor, textColor,
    {isReadOnly, onChange}) {
  return Container(
    padding: EdgeInsets.symmetric(
      horizontal: 10,
    ),
    decoration: BoxDecoration(
        color: backgroundColor, borderRadius: BorderRadius.circular(7)),
    child: Row(children: [
      Expanded(
          flex: 5,
          child: TextField(
            onChanged: onChange == null ? (val) {} : onChange,
            readOnly: isReadOnly != null && isReadOnly ? true : false,
            style: TextStyle(
              color: Colors.black,
            ),
            controller: controller,
            decoration: InputDecoration(
              contentPadding: EdgeInsets.symmetric(vertical: 2, horizontal: 10),
              border: InputBorder.none,
              hintText: hint,
            ),
          )),
      Container(
        child: Icon(
          CupertinoIcons.search,
          color: AppColors.greenColors,
          size: 20,
        ),
      )
    ]),
  );
}