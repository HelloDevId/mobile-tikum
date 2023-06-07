import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:tikum_mobile/models/user.dart';
import 'package:tikum_mobile/screen/HomePage/homepage.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/services/api_services.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getUser();
  }

  showLogoutDialog(BuildContext context) {
    AwesomeDialog(
      context: context,
      animType: AnimType.SCALE,
      dialogType: DialogType.WARNING,
      title: 'Warning!',
      titleTextStyle: MyFont.poppins(
          fontSize: 25, color: lavender, fontWeight: FontWeight.bold),
      desc: 'Apakah anda yakin, untuk Keluar dari aplikasi',
      descTextStyle: MyFont.poppins(fontSize: 12, color: softgrey),
      btnOkOnPress: () {
        authServices.logout(context);
        Fluttertoast.showToast(
            msg: "Berhasil Logout", backgroundColor: Colors.green);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: TikumColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Profile",
          style: MyFont.poppins(
              fontSize: 16, color: white, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
          padding: EdgeInsets.all(20),
          physics: BouncingScrollPhysics(),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  children: [
                    Container(
                      margin: EdgeInsets.only(top: 50),
                      height: 125,
                      width: 125,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(100),
                          color: TikumColor),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user?.nama != null && user!.nama!.length >= 2
                                ? user!.nama!.substring(0, 2).toUpperCase()
                                : "",
                            style: MyFont.poppins(
                                fontSize: 28,
                                color: white,
                                fontWeight: FontWeight.bold),
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      user?.nama ?? "",
                      style: MyFont.poppins(
                          fontSize: 16,
                          color: black,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
                SizedBox(
                  height: 70,
                ),
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
                          Icon(
                            Icons.mail,
                            color: TikumColor,
                          )
                        ]),
                  ),
                  title: Text(
                    "Email",
                    style: MyFont.poppins(
                        fontSize: 13,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user?.email ?? "",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
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
                          Icon(
                            Icons.person,
                            color: TikumColor,
                          )
                        ]),
                  ),
                  title: Text(
                    "Nama",
                    style: MyFont.poppins(
                        fontSize: 13,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user?.nama ?? "",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.normal),
                  ),
                ),
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
                          Icon(
                            Icons.phone,
                            color: TikumColor,
                          )
                        ]),
                  ),
                  title: Text(
                    "No. Telepon",
                    style: MyFont.poppins(
                        fontSize: 13,
                        color: black,
                        fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    user?.noHp ?? "",
                    style: MyFont.poppins(
                        fontSize: 12,
                        color: black,
                        fontWeight: FontWeight.normal),
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
                        showLogoutDialog(context);
                      },
                      child: Text('Log Out',
                          style: MyFont.poppins(fontSize: 14, color: white)),
                    )),
                SizedBox(
                  height: 30,
                ),
                Text(
                  "Tikumitikal\nversion 1.0.1",
                  textAlign: TextAlign.center,
                  style: MyFont.poppins(fontSize: 12, color: softgrey),
                )
              ],
            ),
          )),
    );
  }
}
