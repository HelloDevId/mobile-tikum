import 'package:flutter/material.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_headers.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_product.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_title_product.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "TIKUM",
              style: MyFont.poppins(
                  fontSize: 18, color: TikumColor, fontWeight: FontWeight.bold),
            ),
            Text(
              "Cookery and Coffee",
              style: MyFont.montserrat(
                  fontSize: 12, color: softgrey, fontWeight: FontWeight.normal),
            ),
          ],
        ),
        backgroundColor: white,
        shadowColor: Colors.transparent,
      ),
      body: Scrollbar(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [WidgetHeaders(), WidgetTitleProduct(), WidgetProduct()],
          ),
        ),
      ),
    );
  }
}
