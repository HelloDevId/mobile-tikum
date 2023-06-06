import 'package:flutter/material.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/Reservasi/Tabbar_View/dibatalkan.dart';
import 'package:tikum_mobile/screen/HomePage/Reservasi/Tabbar_View/konfirmasi.dart';
import 'package:tikum_mobile/screen/HomePage/Reservasi/Tabbar_View/menunggu_konfirmasi.dart';
import 'package:tikum_mobile/screen/HomePage/Reservasi/Tabbar_View/selesai.dart';
import 'package:tikum_mobile/screen/HomePage/Reservasi/add_reservasi.dart';

class Reservasi extends StatefulWidget {
  const Reservasi({super.key});

  @override
  State<Reservasi> createState() => _ReservasiState();
}

class _ReservasiState extends State<Reservasi> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: TikumColor,
          shadowColor: Colors.transparent,
          centerTitle: true,
          automaticallyImplyLeading: false,
          title: Text(
            "Reservasi",
            style: MyFont.poppins(
                fontSize: 16, color: white, fontWeight: FontWeight.bold),
          ),
        ),
        body: Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ListTile(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddReservasi(),
                        ));
                  },
                  leading: Container(
                    height: 50,
                    width: 50,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(100),
                        color: TikumColor.withOpacity(0.3)),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.table_bar,
                            color: TikumColor,
                          )
                        ]),
                  ),
                  title: Text(
                    "Reservasi",
                    style: MyFont.poppins(
                        fontSize: 14,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    "Booking tempat terlebih dahulu",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.normal),
                  ),
                  trailing: Icon(
                    Icons.keyboard_arrow_right,
                    color: TikumColor,
                  ),
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.only(top: 15),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.shade300,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(3),
                    child: TabBar(
                        unselectedLabelColor: Colors.black,
                        labelColor: Colors.white,
                        labelStyle: MyFont.poppins(fontSize: 12, color: black),
                        isScrollable: true,
                        indicator: BoxDecoration(
                          color: TikumColor,
                          borderRadius: BorderRadius.circular(7),
                        ),
                        tabs: const [
                          Tab(text: "Menunggu Konfirmasi"),
                          Tab(text: "Konfirmasi"),
                          Tab(text: "Selesai"),
                          Tab(text: "Dibatalkan"),
                        ]),
                  ),
                ),
                Expanded(
                    child: TabBarView(children: [
                  SizedBox(
                    child: Column(
                      children: [MenungguKonfirmasi()],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [Konfirmasi()],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [Selesai()],
                    ),
                  ),
                  SizedBox(
                    child: Column(
                      children: [Dibatalkan()],
                    ),
                  ),
                ]))
              ],
            )),
      ),
    );
  }
}
