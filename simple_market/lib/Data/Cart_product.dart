import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_market/Data/Product_data.dart';


class Cart_product {

  String cid;
  String size;
  String category;
  ProductData productData;
  String pid;
  int quantity;

  Cart_product();


  Cart_product.fromDocument(DocumentSnapshot snapshot){
    cid = snapshot.documentID;
    category = snapshot.data["category"];
    pid = snapshot.data["pid"];
    quantity = snapshot.data["quantity"];
    size = snapshot.data["size"];
  }


  Map<String,dynamic> toMap(){
    return {
      "category":category,
      "pid":pid,
      "quantity":quantity,
      "size":size,
      //"product":productData.fromResumed()
    };
  }


}