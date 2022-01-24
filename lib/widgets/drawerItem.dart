import 'package:flutter/material.dart';
import 'package:perfectholyquran/utils/sizeConfig.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem({
    this.title,
    this.image,
    this.icon,
    this.onTap,
  });

  final String title;
  final String image;
  final VoidCallback onTap;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: getScreenWidth(15),
      ),
      child: ListTile(
        leading: (image != null)
            ? Image.asset(
                "$image",
                height: 25,
                width: 25,
              )
            : Icon(
                icon,
                color: Colors.white,
                size: getScreenHeight(25),
              ),
        title: Text(
          "$title",
          style: TextStyle(fontSize: getScreenHeight(14), color: Colors.white),
        ),
        onTap: onTap,
      ),
    );
  }
}
