import 'package:flutter/material.dart';
import 'package:simple_market/TABS/category_tab.dart';
import 'package:simple_market/TABS/home_tab.dart';
import 'package:simple_market/widgets/CustomDrawer.dart';

class HomeMarket extends StatelessWidget {
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return PageView(
        controller: _pageController,
        physics: NeverScrollableScrollPhysics(),
        children: <Widget>[
          Scaffold(body: HomeTab(), drawer: CustomDrawer(_pageController)),
          Scaffold(
              appBar: AppBar(title: Text("Categorias"), centerTitle: true),
              drawer: CustomDrawer(_pageController),
              body: CategoryTab()),
          Container(
            color: Colors.green,
          )
        ]);
  }
}
