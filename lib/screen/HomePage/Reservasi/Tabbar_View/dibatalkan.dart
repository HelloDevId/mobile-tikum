import 'package:flutter/material.dart';
import 'package:tikum_mobile/models/reservasi.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/services/api_services.dart';

class Dibatalkan extends StatefulWidget {
  const Dibatalkan({super.key});

  @override
  State<Dibatalkan> createState() => _DibatalkanState();
}

class _DibatalkanState extends State<Dibatalkan> {
  ApiServices apiServices = ApiServices();
  late Future<List<Reservasi>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getreservasi("Dibatalkan");
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
              listdata = apiServices.getreservasi("Dibatalkan");
            },
            child: ListView.builder(
              shrinkWrap: true,
              scrollDirection: Axis.vertical,
              itemCount: data!.length,
              itemBuilder: (context, index) {
                return Container(
                  height: 120,
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
                              color: Colors.red.withOpacity(0.2)),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                data[index].status.toString(),
                                style: MyFont.poppins(
                                    fontSize: 10,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold),
                              )
                            ],
                          ),
                        ),
                      )
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
