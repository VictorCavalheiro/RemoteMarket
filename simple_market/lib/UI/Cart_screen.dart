import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Models/CartModel.dart';
import 'package:simple_market/Models/UserModel.dart';
import 'package:simple_market/UI/Login.dart';

class CartScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Carrinho"),
          centerTitle: true,
          actions: <Widget>[
            Container(
              padding: EdgeInsets.all(8.0),
              alignment: Alignment.center,
              child: ScopedModelDescendant<CartModel>(
                  builder: (context, child, model) {
                int p = model.products.length;

                return Text("${p} ${"Itens"}",
                    style: TextStyle(fontSize: 17.0));
              }),
            )
          ],
        ),
        body:
            ScopedModelDescendant<CartModel>(builder: (context, child, model) {
              if(!UserModel.of(context).isLoggedIn()) {
                return Container(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(Icons.remove_shopping_cart,
                            size: 80.0, color: Theme
                                .of(context)
                                .primaryColor),
                        SizedBox(height: 16.0),
                        Text("Faça login para adicionar produto!",
                            style: TextStyle(
                                fontWeight: FontWeight.bold, fontSize: 17.0),textAlign: TextAlign.center,),
                        SizedBox(height: 16.0),
                        RaisedButton(onPressed: () {
                          Navigator.of(context).push(
                              MaterialPageRoute(builder: (context) => Login()));
                        },
                          color: Theme
                              .of(context)
                              .primaryColor,
                          child: Text(
                            "Entre",
                            style: TextStyle(color: Colors.white),
                          ),
                        )
                      ],
                    ));
              }
              else if(model.isLoading && UserModel.of(context).isLoggedIn()){
                return Center(child:CircularProgressIndicator());
              }
              else if(model.products==null || model.products.length==0){
                return Center(child:Text("Sem produto no carrinho",style: TextStyle(fontSize: 22.0,fontWeight: FontWeight.bold)));
              }

        }));
  }
}
