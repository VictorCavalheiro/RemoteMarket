import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_market/UI/Category_screen.dart';

class CategoryTile extends StatelessWidget {

  final DocumentSnapshot snapshot;

  CategoryTile(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.only(top:10.0,bottom:10.0,left: 10.0),
        leading: CircleAvatar(
            radius: 25.0,
            backgroundColor: Colors.transparent,
            backgroundImage: NetworkImage(snapshot.data["icon"])),
    title: Text(snapshot.data["title"]),
    trailing: Icon(Icons.keyboard_arrow_right),
    onTap: (){
      Navigator.of(context).push(MaterialPageRoute(builder:(context){
        return  CategoryScreen(snapshot);
      }));
    });
  }
}
