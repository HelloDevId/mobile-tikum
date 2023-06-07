import 'package:flutter/material.dart';
import 'package:tikum_mobile/models/product.dart';
import 'package:tikum_mobile/resource/Mycolor.dart';
import 'package:tikum_mobile/resource/Myfont.dart';
import 'package:tikum_mobile/services/api_connect.dart';

class WidgetDetailProduct extends StatefulWidget {
  final Product product;
  const WidgetDetailProduct({required this.product, Key? key})
      : super(key: key);

  @override
  State<WidgetDetailProduct> createState() => _WidgetDetailProductState();
}

class _WidgetDetailProductState extends State<WidgetDetailProduct> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: white,
      appBar: AppBar(
        backgroundColor: TikumColor,
        shadowColor: Colors.transparent,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: Text(
          "Detail Product",
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
          children: [
            Container(
              height: 200,
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      image: NetworkImage(ApiConnect.connectimage +
                          widget.product.image!.trim()),
                      fit: BoxFit.cover),
                  borderRadius: BorderRadius.circular(10)),
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                for (int i = 1; i <= 5; i++)
                  Icon(
                    widget.product.rating! >= i
                        ? Icons.star
                        : (widget.product.rating! >= i - 0.5
                            ? Icons.star_half
                            : Icons.star_border),
                    color: widget.product.rating! >= i
                        ? Colors.amber
                        : Colors.amber,
                    size: 16,
                  ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.product.nama.toString(),
              style: MyFont.poppins(
                  fontSize: 16, color: black, fontWeight: FontWeight.bold),
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rp. ${widget.product.harga}",
              style: MyFont.poppins(
                  fontSize: 12, color: softgrey, fontWeight: FontWeight.w300),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              widget.product.deskripsi.toString(),
              style: MyFont.poppins(
                  fontSize: 12, color: black, fontWeight: FontWeight.w500),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
