import 'package:flutter/material.dart';
import 'package:tikum_mobile/controllers/popular_product_controller.dart';
import 'package:tikum_mobile/pages/HomePage.dart';
import 'package:tikum_mobile/pages/food/popular_food_detail.dart';
import 'package:tikum_mobile/pages/food/recommended_food_detail.dart';
import 'package:tikum_mobile/pages/home/food_page_body.dart';
import 'package:tikum_mobile/pages/home/main_food_page.dart';
import 'package:tikum_mobile/pages/CartPage.dart';
import 'package:tikum_mobile/pages/ItemPage.dart';
import 'package:get/get.dart';
import 'package:tikum_mobile/pages/profile/login.dart';
import 'package:tikum_mobile/pages/profile/register.dart';
import 'package:tikum_mobile/helper/dependencies.dart' as dep;
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/screen/splash_screen.dart';

void main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await dep.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get.find<PopularProductController>().getPopularProductList();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          scaffoldBackgroundColor: Colors.white, primarySwatch: Colors.grey),
      home: SplashScreen(),
      // routes: {
      //   "/": (context) => FoodPageBody(),
      //   // "/": (context) => MainFoodPage(),
      //   // "/": (context) => HomePage(),
      //   "cartPage": (context) => CartPage(),
      //   "itemPage": (context) => ItemPage()
      // },
    );
  }
} 

// hayolohh
//dilihat lihat makin pusing 😒