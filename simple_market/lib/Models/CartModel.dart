import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Data/Cart_product.dart';
import 'package:simple_market/Models/UserModel.dart';

class CartModel extends Model{

  UserModel currentUserModel;

  CartModel(this.currentUserModel);

  bool isLoading = false;



  List<Cart_product> products = [];

  static CartModel of(BuildContext context) =>
      ScopedModel.of<CartModel>(context);

  void addCartItem(Cart_product product){


    Firestore.instance.collection("users").document(currentUserModel.firebaseUser.uid).collection("cart")
    .add(product.toMap()).then((doc){
      product.cid=doc.documentID;
    });
    products.add(product);
    notifyListeners();
  }

  void removeCartProduct(Cart_product product){


    Firestore.instance.collection("users").document(currentUserModel.firebaseUser.uid).collection("cart")
        .document(product.cid).delete();

    products.remove(product);

  }
}