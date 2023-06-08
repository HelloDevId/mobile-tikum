import 'package:flutter/material.dart';
import 'package:tikum_mobile/models/model.dart';
import 'package:tikum_mobile/models/product.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_headers.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_product.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_title_product.dart';
import 'package:tikum_mobile/services/api_services.dart'; // Import the ApiServices class

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<String> categoryNames = [];
  List<Kategori> categories = [];
  List<Product> filteredProducts = [];
  List<Product> products = [];
  final searchController = TextEditingController();
  ApiServices apiServices = ApiServices();

  @override
  void initState() {
    super.initState();
    loadCategoryNames();
  }

  Future<void> loadCategoryNames() async {
    try {
      categories = await apiServices.getKategori();
      setState(() {
        categoryNames = categories
            .map((kategori) => kategori.nama)
            .whereType<String>()
            .toList();
      });
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: categoryNames.length,
      child: Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "TIKUM",
                style: MyFont.poppins(
                  fontSize: 18,
                  color: TikumColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                "Cookery and Coffee",
                style: MyFont.montserrat(
                  fontSize: 12,
                  color: softgrey,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ],
          ),
          backgroundColor: white,
          shadowColor: Colors.transparent,
        ),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              WidgetHeaders(),
              WidgetTitleProduct(),
              Padding(
                padding: EdgeInsets.all(5),
                child: TabBar(
                  unselectedLabelColor: softgrey,
                  labelColor: TikumColor,
                  labelStyle: MyFont.poppins(
                      fontSize: 12,
                      color: TikumColor,
                      fontWeight: FontWeight.w500),
                  isScrollable: true,
                  indicatorColor: TikumColor,
                  tabs: categoryNames.map((name) => Tab(text: name)).toList(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height + 125,
                  child: TabBarView(
                    children: categoryNames.map((name) {
                      int? categoryId = categories
                          .firstWhere((kategori) => kategori.nama == name)
                          .id;
                      return SizedBox(
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: SizedBox(
                                height: 48,
                                child: TextField(
                                  style: MyFont.poppins(
                                      fontSize: 12, color: black),
                                  controller: searchController,
                                  decoration: InputDecoration(
                                    isDense: true,
                                    hintStyle: MyFont.poppins(
                                        fontSize: 12, color: black),
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
                                  onChanged: (value) {
                                    setState(() {
                                      if (value.isNotEmpty) {
                                        filteredProducts = products
                                            .where((product) => product.nama!
                                                .toLowerCase()
                                                .contains(value.toLowerCase()))
                                            .toList();
                                      } else {
                                        filteredProducts
                                            .clear(); // Clear the filteredProducts list
                                      }
                                    });
                                  },
                                ),
                              ),
                            ),
                            FutureBuilder<List<Product>>(
                              future:
                                  apiServices.getProduct(categoryId.toString()),
                              builder: (context, snapshot) {
                                if (snapshot.hasData) {
                                  products = snapshot.data!;
                                  return WidgetProduct(
                                    products: filteredProducts.isNotEmpty
                                        ? filteredProducts
                                        : products,
                                  ); // Pass the retrieved products to the WidgetProduct widget
                                } else if (snapshot.hasError) {
                                  return const Text(
                                      'Failed to load products'); // Handle the error case
                                }
                                return const Center(
                                  child: CircularProgressIndicator(),
                                ); // Show a loading indicator while data is being fetched
                              },
                            ),
                          ],
                        ),
                      );
                    }).toList(),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
