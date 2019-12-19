import 'package:flutter/material.dart';
import 'package:simple_market/TABS/Category_tab.dart';
import 'package:simple_market/TABS/Home_tab.dart';
import 'package:simple_market/widgets/CustomDrawer.dart';
import 'package:simple_market/widgets/cart_button.dart';

class HomeMarket extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(body: HomeTab(), drawer: CustomDrawer(_pageController),floatingActionButton: Cart_Button()),
          Scaffold(
              appBar: AppBar(title: Text("Categorias"), centerTitle: true),
              drawer: CustomDrawer(_pageController),
              body: CategoryTab(),floatingActionButton: Cart_Button()),
          Container(
            color: Colors.green,
          )
        ]);
  }
}
