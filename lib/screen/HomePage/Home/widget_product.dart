import 'package:flutter/material.dart';
import 'package:tikum_mobile/models/product.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/screen/HomePage/Home/widget_detail_product.dart';
import 'package:tikum_mobile/services/api_connect.dart';

class WidgetProduct extends StatelessWidget {
  final List<Product> products;

  const WidgetProduct({Key? key, required this.products}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        itemCount: products.length,
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return InkWell(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WidgetDetailProduct(
                      product: products[index],
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
                            image: NetworkImage(ApiConnect.connectimage +
                                products[index].image!.trim()),
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
                          products[index].nama.toString(),
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
                                products[index].rating! >= i
                                    ? Icons.star
                                    : (products[index].rating! >= i - 0.5
                                        ? Icons.star_half
                                        : Icons.star_border),
                                color: products[index].rating! >= i
                                    ? Colors.amber
                                    : Colors.amber,
                                size: 16,
                              ),
                          ],
                        ),
                        Text(
                          "Rp. ${products[index].harga}",
                          style: MyFont.poppins(
                              fontSize: 12,
                              color: softgrey,
                              fontWeight: FontWeight.w300),
                        ),
                        Text(
                          products[index].deskripsi.toString(),
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
  }
}
