import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikum_mobile/models/reservasi.dart';
import 'package:tikum_mobile/models/user.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:http/http.dart' as http;
import 'package:tikum_mobile/screen/HomePage/homepage.dart';
import 'package:tikum_mobile/services/api_connect.dart';
import 'package:tikum_mobile/services/api_services.dart';

class MenungguKonfirmasi extends StatefulWidget {
  const MenungguKonfirmasi({super.key});

  @override
  State<MenungguKonfirmasi> createState() => _MenungguKonfirmasiState();
}

class _MenungguKonfirmasiState extends State<MenungguKonfirmasi> {
  ApiServices apiServices = ApiServices();
  late Future<List<Reservasi>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getreservasi("Menunggu Konfirmasi");
    getUser();
  }

  showCancelDialog(BuildContext context, String id) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk cancel reservasi yang telah dipesan',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        cancel(id);
      },
      btnCancelOnPress: () {
        Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (route) => false);
      },
      btnCancelIcon: Icons.highlight_off_rounded,
      btnOkIcon: Icons.task_alt_rounded,
    ).show();
  }

  final authServices = ApiServices();
  User? user;
  Future<void> getUser() async {
    final auth = await authServices.me();
    if (auth != null) {
      setState(() {
        user = auth;
      });
    }
  }

  Future cancel(String idmeja) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var res = await http.post(Uri.parse(ApiConnect.cancel),
          body: {"id_meja": idmeja},
          headers: {"Authorization": "Bearer $token"});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "success") {
          Fluttertoast.showToast(
              msg: "Berhasil membatalkan pesanan reservasi",
              backgroundColor: Colors.green);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Reservasi>>(
      future: listdata,
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          List<Reservasi>? data = snapshot.data;
          return Expanded(
              child: RefreshIndicator(
            onRefresh: () async {
              listdata = apiServices.getreservasi("Menunggu Konfirmasi");
            },
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 150,
                  width: MediaQuery.of(context).size.width,
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(5),
                    color: white,
                  ),
                  child: Column(
                    children: [
                      ListTile(
                        leading: Container(
                          height: 50,
                          width: 50,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                              color: TikumColor.withOpacity(0.3)),
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  data[index].meja!.noMeja!.toString(),
                                  style: MyFont.poppins(
                                      fontSize: 20,
                                      color: TikumColor,
                                      fontWeight: FontWeight.bold),
                                )
                              ]),
                        ),
                        title: Text(
                          data[index].user!.nama!,
                          style: MyFont.poppins(
                              fontSize: 13,
                              color: black,
                              fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(
                          data[index].tanggal!,
                          style: MyFont.poppins(
                              fontSize: 13,
                              color: black,
                              fontWeight: FontWeight.normal),
                        ),
                        trailing: Container(
                          height: 30,
                          width: 120,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: Colors.grey.withOpacity(0.2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[index].status.toString(),
                                style: MyFont.poppins(
                                    fontSize: 10,
                                    color: black,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      ),
                      Container(
                          margin: EdgeInsets.only(top: 20),
                          height: 48,
                          width: MediaQuery.of(context).size.width,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: TikumColor,
                                shadowColor: Colors.transparent,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                )),
                            onPressed: () {
                              // showLogoutDialog(context);
                              showCancelDialog(
                                  context, data[index].idMeja.toString());
                            },
                            child: Text('Cancel',
                                style:
                                    MyFont.poppins(fontSize: 14, color: white)),
                          )),
                    ],
                  ),
                );
              },
            ),
          ));
        } else if (snapshot.hasError) {
          return Center(
              child: Text(
            "Error Your Connection",
            style: MyFont.poppins(fontSize: 12, color: black),
          ));
        }
        return Center(
          child: CircularProgressIndicator(
            color: TikumColor,
          ),
        );
      },
    );
  }
}
