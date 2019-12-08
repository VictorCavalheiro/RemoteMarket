import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Models/CartModel.dart';
import 'package:simple_market/Models/UserModel.dart';
import 'package:simple_market/UI/HomeMarket.dart';
import 'package:simple_market/UI/Login.dart';
import 'package:simple_market/UI/Register.dart';
import 'package:flutter/widgets.dart';

void main() {
  return runApp(new Home());
}

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return ScopedModel<UserModel>(
        model: UserModel(),
        child:
        ScopedModelDescendant<UserModel>(builder: (context,child,model){
          return ScopedModel<CartModel> (
              model: CartModel(model),
              child: MaterialApp(
                  home: HomeMarket(), debugShowCheckedModeBanner: false));
        }
        )


    );
  }
}
