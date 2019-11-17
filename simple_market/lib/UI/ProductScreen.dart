import 'package:flutter/material.dart';
import 'package:simple_market/Models/ProductData.dart';
import 'package:carousel_pro/carousel_pro.dart';

class ProductScreen extends StatefulWidget {
  final ProductData product;

  ProductScreen(this.product);

  @override
  _ProductScreenState createState() => _ProductScreenState(this.product);
}

class _ProductScreenState extends State<ProductScreen> {
  final ProductData product;

  _ProductScreenState(this.product);

  @override
  Widget build(BuildContext context) {

    final Color primaryColor = Theme.of(context).primaryColor;

    return Scaffold(
      appBar: AppBar(
          centerTitle: true,
          title: Text(product.title, style: TextStyle(color: Colors.white))),
      body: ListView(children: <Widget>[
        AspectRatio(
            aspectRatio: 0.9,
            child: Carousel(
              images: product.images.map((url) {
                return NetworkImage(url);
              }).toList(),
              dotSize: 4.0,
              dotBgColor: Colors.transparent,
              autoplay: false
            ),
        ),

      ]),
    );
  }
}
