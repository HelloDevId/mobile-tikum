import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:tikum_mobile/resource/MyTextField.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/login_screen.dart';
import 'package:tikum_mobile/services/api_connect.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  var email = TextEditingController();
  var pw = TextEditingController();
  var name = TextEditingController();
  var nohp = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool showpass = true;
  bool isLoading = false;
  String errorMsg = '';
  void verifyRegister() {
    if (email.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Email tidak boleh kosong", backgroundColor: Colors.red);
    } else if (pw.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Password tidak boleh kosong", backgroundColor: Colors.red);
    } else if (pw.text.length < 8) {
      Fluttertoast.showToast(
          msg: "Password tidak boleh kurang dari 8 karakter",
          backgroundColor: Colors.red);
    } else if (name.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "Nama tidak boleh kosong", backgroundColor: Colors.red);
    } else if (nohp.text.isEmpty) {
      Fluttertoast.showToast(
          msg: "No Telepon tidak boleh kosong", backgroundColor: Colors.red);
    } else if (nohp.text.length < 11) {
      Fluttertoast.showToast(
          msg: "No telepon tidak boleh kurang dari 11 angka",
          backgroundColor: Colors.red);
    } else {
      register();
    }
  }

  Future register() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.post(Uri.parse(ApiConnect.register), body: {
        "email": email.text,
        "no_hp": nohp.text,
        "password": pw.text,
        "nama": name.text
      });
      if (res.statusCode == 200) {
        final data = jsonDecode(res.body);
        if (data["message"] == "Berhasil Register") {
          Fluttertoast.showToast(
              msg: "Registrasi akun berhasil", backgroundColor: Colors.green);
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => LoginPage()));
          setState(() {
            email.clear();
            nohp.clear();
            name.clear();
            pw.clear();
          });
        }
      } else {
        final data = jsonDecode(res.body);
        if (data["message"] == "Email sudah terdaftar") {
          Fluttertoast.showToast(
              msg: "Email sudah terdaftar", backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      // errorMsg = e.toString();
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      body: SingleChildScrollView(
        // padding: const EdgeInsets.all(20),
        physics: const BouncingScrollPhysics(),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.fromLTRB(50, 0, 0, 0),
              height: 300,
              width: MediaQuery.of(context).size.width,
              color: TikumColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Create Your\nAccount",
                    style: MyFont.montserrat(
                        fontSize: 30,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 60,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetTextFieldUser(
                controller: email,
                label: "Email",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                length: 100,
                icon: Icons.mail,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetTextFieldUser(
                controller: name,
                label: "Name",
                keyboardType: TextInputType.text,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                length: 100,
                icon: Icons.person,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: GetTextFieldUser(
                controller: nohp,
                label: "No. Telepon",
                keyboardType: TextInputType.number,
                inputFormatters:
                    FilteringTextInputFormatter.singleLineFormatter,
                length: 100,
                icon: Icons.phone_rounded,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Icon(
                    Icons.lock_rounded,
                    size: 25,
                    color: grey,
                  ),
                  const SizedBox(
                    width: 8,
                  ),
                  Expanded(
                    child: TextFormField(
                      textInputAction: TextInputAction.done,
                      obscureText: showpass,
                      controller: pw,
                      style: MyFont.poppins(fontSize: 13, color: black),
                      keyboardType: TextInputType.name,
                      onSaved: (val) => pw = val as TextEditingController,
                      validator: (value) {
                        if (value == null || value.isEmpty) {
                          return 'Masukan password anda';
                        }
                        return null;
                      },
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.singleLineFormatter,
                        LengthLimitingTextInputFormatter(100)
                      ],
                      decoration: InputDecoration(
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: grey)),
                          labelText: "Password",
                          labelStyle: MyFont.poppins(fontSize: 13, color: grey),
                          suffixIcon: IconButton(
                              onPressed: () {
                                setState(() {
                                  showpass = !showpass;
                                });
                              },
                              icon: showpass
                                  ? Icon(
                                      Icons.visibility_off,
                                      size: 20,
                                      color: grey,
                                    )
                                  : Icon(
                                      Icons.visibility,
                                      color: TikumColor,
                                      size: 20,
                                    ))),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                height: 48,
                width: MediaQuery.of(context).size.width,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: TikumColor,
                      shadowColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                  onPressed: () async {
                    isLoading ? null : verifyRegister();
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: white,
                        )
                      : Text('Sign Up',
                          style: MyFont.poppins(fontSize: 14, color: white)),
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "have already account ? ",
                  style: MyFont.poppins(fontSize: 11, color: grey),
                ),
                InkWell(
                  child: Text("Sign In",
                      style: MyFont.poppins(
                          fontSize: 12,
                          color: TikumColor,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoginPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
