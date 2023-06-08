import 'package:flutter/material.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';

class WidgetTitleProduct extends StatelessWidget {
  const WidgetTitleProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.fromLTRB(15, 15, 15, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Menus",
            style: MyFont.poppins(
                fontSize: 13, color: black, fontWeight: FontWeight.bold),
          ),
          Text(
            "Various food and drink menus",
            style: MyFont.poppins(
                fontSize: 12, color: softgrey, fontWeight: FontWeight.normal),
          )
        ],
      ),
    );
  }
}
