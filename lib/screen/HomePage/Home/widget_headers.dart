import 'package:flutter/material.dart';
import 'package:tikum_mobile/models/product.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/services/api_connect.dart';
import 'package:tikum_mobile/services/api_services.dart';

class WidgetHeaders extends StatefulWidget {
  const WidgetHeaders({Key? key});

  @override
  State<WidgetHeaders> createState() => _WidgetHeadersState();
}

class _WidgetHeadersState extends State<WidgetHeaders> {
  ApiServices apiServices = ApiServices();
  late Future<List<Product>> listdata;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    listdata = fetchProductTop();
  }

  Future<List<Product>> fetchProductTop() async {
    try {
      return await apiServices.getProductTop();
    } catch (e) {
      print('Error fetching product data: $e');
      return [];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          height: 200,
          color: white,
          child: FutureBuilder<List<Product>>(
            future: listdata,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<Product>? data = snapshot.data;
                return PageView.builder(
                  itemCount: data!.length,
                  controller: PageController(viewportFraction: 0.8),
                  onPageChanged: (index) {
                    setState(() {
                      selectedIndex = index;
                    });
                  },
                  itemBuilder: (context, index) {
                    final product = data[index];
                    final isSelected = index == selectedIndex;
                    final scale = isSelected ? 1.0 : 0.8;

                    return TweenAnimationBuilder(
                      tween: Tween<double>(begin: scale, end: scale),
                      duration: Duration(milliseconds: 350),
                      curve: Curves.ease,
                      builder: (BuildContext context, double value, _) {
                        return Transform.scale(
                          scale: value,
                          child: Container(
                            padding: EdgeInsets.all(20),
                            margin: EdgeInsets.symmetric(horizontal: 0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              image: DecorationImage(
                                  image: NetworkImage(ApiConnect.connectimage +
                                      product.image!.trim()),
                                  fit: BoxFit.cover,
                                  colorFilter: ColorFilter.mode(
                                      black.withOpacity(0.5),
                                      BlendMode.darken)),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(product.nama ?? '',
                                    style: MyFont.poppins(
                                        fontSize: 14,
                                        color: white,
                                        fontWeight: FontWeight.bold)),
                                Text("Rp. ${product.harga}",
                                    style: MyFont.poppins(
                                        fontSize: 12,
                                        color: white,
                                        fontWeight: FontWeight.normal)),
                                const SizedBox(
                                  height: 8,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    Icon(
                                      Icons.star,
                                      color: product.rating! >= 1
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: product.rating! >= 2
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: product.rating! >= 3
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: product.rating! >= 4
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: product.rating! >= 5
                                          ? Colors.amber
                                          : Colors.grey,
                                      size: 16,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    "Error Loading Data",
                    style: MyFont.poppins(fontSize: 12, color: black),
                  ),
                );
              }
              return Center(
                child: CircularProgressIndicator(color: TikumColor),
              );
            },
          ),
        ),
      ],
    );
  }
}
