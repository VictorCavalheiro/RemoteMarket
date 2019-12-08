import 'package:flutter/material.dart';
import 'package:simple_market/Data/Product_data.dart';
import 'package:simple_market/UI/ProductScreen.dart';

class ProductTile extends StatelessWidget {
  final String type;
  final ProductData data;

  ProductTile(this.type, this.data);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: (){
          Navigator.of(context).push(MaterialPageRoute(builder: (context){
            return ProductScreen(data);
          }));
      },
        child: Card(
            child: type == "grid"
                ? Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      AspectRatio(
                          aspectRatio: 0.8,
                          child:
                              Image.network(data.images[0], fit: BoxFit.cover)),
                      Expanded(
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(data.description),
                                  Text(data.price.toStringAsPrecision(2))
                                ],
                              )))
                    ],
                  )
                : Row(
                    children: <Widget>[
                      Flexible(
                          flex: 1,
                          child: Image.network(
                            data.images[0],
                            fit: BoxFit.cover,
                            height: 250,
                          )),
                      Flexible(
                          flex: 1,
                          child: Container(
                              padding: EdgeInsets.all(8.0),
                              child: Column(
                                children: <Widget>[
                                  Text(data.description),
                                  Text(data.price.toStringAsPrecision(2))
                                ],
                              )))
                    ],
                  )));
  }
}
