import 'package:flutter/material.dart';
import 'package:simple_market/Data/Product_data.dart';
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

  String _size;

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
              autoplay: false),
        ),
        Container(
            margin: EdgeInsets.only(left: 10.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  SizedBox(height: 14.0),
                  Container(
                    child: Text(
                      "Tamanhos:",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                  SizedBox(
                      height: 34.0,
                      child: GridView(
                          scrollDirection: Axis.horizontal,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 1,
                                  childAspectRatio: 0.5,
                                  mainAxisSpacing: 8.0),
                          padding: EdgeInsets.symmetric(vertical: 4.0),
                          children: product.sizes.map((size) {
                            return InkWell(
                                onTap: () {
                                  setState(() {
                                    if (_size == size) {
                                      _size = null;
                                      return;
                                    }
                                    _size = size;
                                  });
                                },
                                child: Container(
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            width: 2.0,
                                            style: BorderStyle.solid,
                                            color: _size == size
                                                ? primaryColor
                                                : Colors.grey[400]),
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(4.0))),
                                    child: Text(
                                      size,
                                      style: TextStyle(color: Colors.black),
                                    ),
                                    width: 50.0,
                                    alignment: Alignment.center));
                          }).toList())),
                  SizedBox(height: 16.0),
                  Text(
                    "Descrição:\n",
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
                  ),
                  Text(product.description),
                  SizedBox(height: 16.0),

                ])),
        Container(
            margin: EdgeInsets.only(right: 10.0,left: 10.0),
            child: SizedBox(
                height: 44.0,
                child: RaisedButton(
                  color: primaryColor,
                  onPressed: _size != null ? () {} : null,
                  child: Text("Adicionar ao carrinho",
                      style: TextStyle(color: Colors.white)),
                  shape: RoundedRectangleBorder(
                      borderRadius: new BorderRadius.circular(18.0),
                      side: BorderSide(color: Colors.transparent)),
                ))),
        SizedBox(height: 20.0)
      ]),
    );
  }
}
