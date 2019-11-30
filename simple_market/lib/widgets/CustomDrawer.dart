import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:simple_market/Models/UserModel.dart';
import 'package:simple_market/Tiles/DrawerTile.dart';
import 'package:simple_market/UI/HomeMarket.dart';
import 'package:simple_market/UI/Login.dart';
import 'package:simple_market/UI/Register.dart';
class CustomDrawer extends StatelessWidget {

  final PageController pageController;

  CustomDrawer(this.pageController);

  @override
  Widget build(BuildContext context) {
    Widget buildDrawerBack() => Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Color.fromARGB(255, 203, 236, 241), Colors.white],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter)));

    return Drawer(
        child: Stack(children: <Widget>[
      buildDrawerBack(),
      ListView(
          padding: EdgeInsets.only(left: 32.0, top: 10.0),
          children: <Widget>[
            Container(
                margin: EdgeInsets.only(bottom: 8.0),
                padding: EdgeInsets.fromLTRB(0.0, 16.0, 16.0, 0.0),
                height: 170.0,
                child: Stack(children: <Widget>[
                  Positioned(
                      child: Text("Market Place",
                          style: TextStyle(
                              fontSize: 32.0,fontStyle: FontStyle.italic)),
                      top: 36.0,
                      left: 0.0),
                  Positioned(
                      left: 0.0,
                      bottom: 0.0,
                      child:ScopedModelDescendant<UserModel>(builder: (context,child,model){

                        return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Hello, ${!model.isLoggedIn() ? "" : model.userData["name"]}",
                                  style: TextStyle(
                                      fontSize: 16.0,
                                      fontWeight: FontWeight.bold)),
                              GestureDetector(
                                  onTap: (){
                                    if(model.isLoggedIn()==false)
                                      Navigator.of(context).push(MaterialPageRoute(builder: (context)=>Login()));
                                    else
                                      model.signOut();
                                  },
                                  child: Text(
                                    !model.isLoggedIn() ?
                                    "Sign in or register >" : "Logout",
                                    style: TextStyle(
                                        fontSize: 16.0,
                                        fontWeight: FontWeight.bold,
                                        color: Theme.of(context).primaryColor),
                                  ))
                            ]);
                      }))
                ])),

            DrawerTile(Icons.home,"Home",pageController,0),
            DrawerTile(Icons.search,"Roupas",pageController,1),
            DrawerTile(Icons.history,"Compras Recentes",pageController,2),
            DrawerTile(Icons.shopping_cart,"Carrinho",pageController,3)
          ])
    ]));
  }
}
