import 'package:flutter/material.dart';
import 'package:simple_market/UI/Cart_screen.dart';

class Cart_Button extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      child: Icon(Icons.shopping_cart,color: Colors.white,),
      onPressed: (){
        Navigator.of(context).push(
          MaterialPageRoute(builder: (context)=>CartScreen())
        );
      },
      backgroundColor: Theme.of(context).primaryColor,
    );
  }
}
