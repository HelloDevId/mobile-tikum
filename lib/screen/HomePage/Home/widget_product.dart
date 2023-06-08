import 'package:flutter/material.dart';
import 'package:tikum_mobile/models/product.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_detail_product.dart';
import 'package:tikum_mobile/services/api_connect.dart';
import 'package:tikum_mobile/services/api_services.dart';

class WidgetProduct extends StatefulWidget {
  const WidgetProduct({Key? key}) : super(key: key);

  @override
  State<WidgetProduct> createState() => _WidgetProductState();
}

class _WidgetProductState extends State<WidgetProduct> {
  ApiServices apiServices = ApiServices();
  late Future<List<Product>> listdata;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    listdata = apiServices.getProduct();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  TextEditingController searchController = TextEditingController();
  bool isSearching = false;
  List<Product>? _getFilteredProductList(
      List<Product>? productList, String searchQuery) {
    if (productList == null || productList.isEmpty) {
      return [];
    }
    if (searchQuery.isEmpty) {
      return productList;
    }
    return productList.where((product) {
      final nameLower = product.nama.toString().toLowerCase();
      final searchLower = searchQuery.toLowerCase();
      return nameLower.contains(searchLower);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          TextField(
            controller: searchController,
            onChanged: (value) {
              setState(() {
                isSearching = value.isNotEmpty;
              });
            },
            decoration: InputDecoration(
              hintStyle: MyFont.poppins(fontSize: 12, color: black),
              hintText: 'Search',
              prefixIcon: Icon(
                Icons.search,
                color: TikumColor,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1.0,
                  color: TikumColor,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: BorderSide(
                  width: 1.0,
                  color: TikumColor,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FutureBuilder<List<Product>>(
            future: listdata,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done &&
                  snapshot.hasData) {
                List<Product>? data = snapshot.data;
                return SizedBox(
                  // height: MediaQuery.of(context).size.height * 0.3,
                  child: ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    scrollDirection: Axis.vertical,
                    itemCount: isSearching
                        ? _getFilteredProductList(data, searchController.text)!
                            .length
                        : data!.length,
                    itemBuilder: (context, index) {
                      final productList = isSearching
                          ? _getFilteredProductList(data, searchController.text)
                          : data;
                      final product = productList![index];
                      return InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => WidgetDetailProduct(
                                  product: product,
                                ),
                              ));
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                height: 125,
                                width: 150,
                                decoration: BoxDecoration(
                                    image: DecorationImage(
                                        image: NetworkImage(
                                            ApiConnect.connectimage +
                                                product.image!.trim()),
                                        fit: BoxFit.cover),
                                    borderRadius: BorderRadius.circular(10)),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              SizedBox(
                                width: 120,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      product.nama.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 16,
                                          color: black,
                                          fontWeight: FontWeight.bold),
                                      maxLines: 2,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        for (int i = 1; i <= 5; i++)
                                          Icon(
                                            product.rating! >= i
                                                ? Icons.star
                                                : (product.rating! >= i - 0.5
                                                    ? Icons.star_half
                                                    : Icons.star_border),
                                            color: product.rating! >= i
                                                ? Colors.amber
                                                : Colors.amber,
                                            size: 16,
                                          ),
                                      ],
                                    ),
                                    Text(
                                      "Rp. ${product.harga}",
                                      style: MyFont.poppins(
                                          fontSize: 12,
                                          color: softgrey,
                                          fontWeight: FontWeight.w300),
                                    ),
                                    Text(
                                      product.deskripsi.toString(),
                                      style: MyFont.poppins(
                                          fontSize: 12,
                                          color: black,
                                          fontWeight: FontWeight.w500),
                                      maxLines: 3,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                );
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
          ),
        ],
      ),
    );
  }
}
