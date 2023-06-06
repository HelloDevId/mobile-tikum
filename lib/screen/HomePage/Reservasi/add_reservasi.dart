import 'dart:convert';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikum_mobile/models/reservasi.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/homepage.dart';
import 'package:tikum_mobile/services/api_connect.dart';
import 'package:tikum_mobile/services/api_services.dart';
import 'package:intl/intl.dart';
import 'package:http/http.dart' as http;

class AddReservasi extends StatefulWidget {
  const AddReservasi({Key? key}) : super(key: key);

  @override
  State<AddReservasi> createState() => _AddReservasiState();
}

class _AddReservasiState extends State<AddReservasi> {
  ApiServices apiServices = ApiServices();
  late Future<List<Meja>> listdata;
  TextEditingController _textFieldController = TextEditingController();
  TextEditingController _dateController = TextEditingController();
  Meja? selectedMeja;
  String? _selectedDate;

  @override
  void initState() {
    super.initState();
    listdata = apiServices.getTable();
  }

  Future pesan(String tanggal, id_meja) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token');
      var res = await http.post(Uri.parse(ApiConnect.addreservasi),
          body: {'id_meja': id_meja, 'tanggal': tanggal},
          headers: {"Authorization": "Bearer $token"});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "success") {
          Fluttertoast.showToast(
              msg: "Berhasil melakukan pesanan reservasi",
              backgroundColor: Colors.green);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        if (data['message'] ==
            "Tidak dapat menambah reservasi. Masih ada reservasi sebelumnya masih belum dikonfirmasi") {
          Fluttertoast.showToast(
              msg:
                  "Tidak dapat menambah reservasi. Masih ada reservasi sebelumnya masih belum dikonfirmasi",
              backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  showCancelDialog(BuildContext context, String tanggal, String idmeja) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk memesan',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        pesan(tanggal, idmeja);
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

  void _showDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return FutureBuilder<List<Meja>>(
          future: listdata,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              List<Meja> mejaList = snapshot.data!;
              return AlertDialog(
                title: Text(
                  'Pilih No Meja',
                  style: MyFont.poppins(
                      fontSize: 16, color: black, fontWeight: FontWeight.bold),
                ),
                content: SizedBox(
                  width: double.maxFinite,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: mejaList.length,
                    itemBuilder: (BuildContext context, int index) {
                      Meja meja = mejaList[index];
                      return ListTile(
                        title: Text(
                          meja.noMeja.toString(),
                          style: MyFont.poppins(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.normal,
                          ),
                        ),
                        onTap: () {
                          setState(() {
                            selectedMeja = meja;
                            _textFieldController.text = meja.noMeja.toString();
                          });
                          Navigator.pop(context);
                        },
                      );
                    },
                  ),
                ),
              );
            } else {
              return Text('No data available');
            }
          },
        );
      },
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (picked != null) {
      final formattedDate = DateFormat('dd MMMM yyyy').format(picked);
      final selectedDate = DateFormat('yyyy-MM-dd').format(picked);

      setState(() {
        _dateController.text = formattedDate;
        _selectedDate = selectedDate;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: TikumColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Pesan Sekarang",
          style: MyFont.poppins(
            fontSize: 16,
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const SizedBox(
              height: 20,
            ),
            Text(
              "Silahkan lengkapi data berikut terlebih dahulu",
              style: MyFont.poppins(fontSize: 12, color: black),
            ),
            const SizedBox(
              height: 20,
            ),
            GestureDetector(
              onTap: () {
                _showDialog();
              },
              child: AbsorbPointer(
                child: TextField(
                  style: MyFont.poppins(fontSize: 12, color: black),
                  controller: _textFieldController,
                  decoration: InputDecoration(
                    labelText: 'No Meja',
                    labelStyle: MyFont.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 15),
            GestureDetector(
              onTap: () {
                _selectDate(context);
              },
              child: AbsorbPointer(
                child: TextField(
                  style: MyFont.poppins(fontSize: 12, color: black),
                  controller: _dateController,
                  decoration: InputDecoration(
                    labelText: 'Tanggal Reservasi',
                    labelStyle: MyFont.poppins(
                      fontSize: 12,
                      color: Colors.black,
                      fontWeight: FontWeight.normal,
                    ),
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: black,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(10.0),
                    ),
                  ),
                ),
              ),
            ),
            Container(
                margin: EdgeInsets.only(top: 100),
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
                        context, _selectedDate!, selectedMeja!.id.toString());
                  },
                  child: Text('Pesan Sekarang',
                      style: MyFont.poppins(fontSize: 14, color: white)),
                )),
          ],
        ),
      ),
    );
  }
}
