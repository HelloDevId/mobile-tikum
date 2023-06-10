import 'package:flutter/material.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/Home/home.dart';
import 'package:tikum_mobile/screen/HomePage/Profile/profile.dart';
import 'package:tikum_mobile/screen/HomePage/Reservasi/reservasi.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int index = 0;
  List<Widget> screen = <Widget>[
    const Home(),
    const Reservasi(),
    const Profile(),
  ];

  List navbutton = [
    {
      "active_icon": Icons.home_rounded,
      "non_active_icon": Icons.home_outlined,
      "label": "Home"
    },
    {
      "active_icon": Icons.assignment,
      "non_active_icon": Icons.assignment_outlined,
      "label": "Reservasi"
    },
    {
      "active_icon": Icons.person,
      "non_active_icon": Icons.person_outline,
      "label": "Profile"
    },
  ];
  void onTap(value) {
    setState(() {
      index = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: screen[index],
      bottomNavigationBar: BottomNavigationBar(
          showSelectedLabels: true,
          unselectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: grey, fontWeight: FontWeight.w300),
          selectedLabelStyle: MyFont.poppins(
              fontSize: 12, color: white, fontWeight: FontWeight.w500),
          selectedFontSize: 12,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          selectedItemColor: TikumColor,
          unselectedItemColor: softgrey,
          currentIndex: index,
          onTap: onTap,
          elevation: 0,
          backgroundColor: Colors.transparent,
          items: List.generate(3, (index) {
            var navBtn = navbutton[index];
            return BottomNavigationBarItem(
                icon: Icon(navBtn["non_active_icon"]),
                activeIcon: Icon(navBtn["active_icon"]),
                label: navBtn["label"]);
          })),
    );
  }
}
