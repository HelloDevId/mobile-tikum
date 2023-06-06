import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tikum_mobile/screen/HomePage/homepage.dart';
import 'package:tikum_mobile/resource/MyTextField.dart';
import 'package:tikum_mobile/resource/MyTextField_Pengajuan.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/register_screen.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tikum_mobile/services/api_connect.dart';
import 'package:http/http.dart' as http;

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool showpass = true;
  var email = TextEditingController();
  var pw = TextEditingController();
  bool isLoading = false;

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
              height: 350,
              width: MediaQuery.of(context).size.width,
              color: TikumColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome",
                    style: MyFont.montserrat(
                        fontSize: 30,
                        color: white,
                        fontWeight: FontWeight.bold),
                  ),
                  Text(
                    "Sign in to continue",
                    style: MyFont.montserrat(
                        fontSize: 14,
                        color: white,
                        fontWeight: FontWeight.normal),
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
                    isLoading ? null : verifylogin();
                  },
                  child: isLoading
                      ? CircularProgressIndicator(
                          color: white,
                        )
                      : Text('Sign In',
                          style: MyFont.poppins(fontSize: 14, color: white)),
                )),
            const SizedBox(
              height: 15,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Dont have already account ? ",
                  style: MyFont.poppins(fontSize: 11, color: grey),
                ),
                InkWell(
                  child: Text("Sign Up",
                      style: MyFont.poppins(
                          fontSize: 12,
                          color: TikumColor,
                          fontWeight: FontWeight.bold)),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const RegisterPage()));
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void verifylogin() {
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
    } else {
      login();
    }
  }

  Future login() async {
    setState(() {
      isLoading = true;
    });
    try {
      var res = await http.post(Uri.parse(ApiConnect.login),
          body: {"email": email.text, "password": pw.text});
      final data = jsonDecode(res.body);
      if (res.statusCode == 200) {
        if (data['message'] == "login successfull") {
          Fluttertoast.showToast(
              msg: "Berhasil Login", backgroundColor: Colors.green);
          final prefs = await SharedPreferences.getInstance();
          prefs.setString('token', data['token']);
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(
              builder: (context) => const HomePage(),
            ),
            (Route<dynamic> route) => false,
          );
        }
      } else {
        if (data['message'] == "incorrect password") {
          Fluttertoast.showToast(
              msg: "Password Salah", backgroundColor: Colors.red);
        } else if (data['message'] == "incorrect email") {
          Fluttertoast.showToast(
              msg: "Email belum terdaftar", backgroundColor: Colors.red);
        }
      }
    } catch (e) {
      print(e.toString());
    }
    setState(() {
      isLoading = false;
    });
  }
}
