import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:simple_market/Data/Product_data.dart';
import 'package:simple_market/Tiles/ProductTile.dart';

class CategoryScreen extends StatelessWidget {
  final DocumentSnapshot snapshot;

  CategoryScreen(this.snapshot);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: 2,
        child: Scaffold(
            appBar: AppBar(
                bottom: TabBar(
                  indicatorColor: Colors.white,
                  tabs: <Widget>[
                    Tab(icon: Icon(Icons.grid_on)),
                    Tab(icon: Icon(Icons.list))
                  ],
                ),
                title: Text(snapshot.data["title"]),
                centerTitle: true),
            body: FutureBuilder<QuerySnapshot>(
              future: Firestore.instance
                  .collection("categories").document("shirts").collection("itens").getDocuments(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(child: CircularProgressIndicator());
                } else {
                  return TabBarView(
                      physics: NeverScrollableScrollPhysics(),
                      children: <Widget>[
                        GridView.builder(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                                    crossAxisCount: 2,
                                    childAspectRatio: 0.65,
                                    crossAxisSpacing: 0.0,
                                    mainAxisSpacing: 0.0),
                            padding: EdgeInsets.all(5.0),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return ProductTile(
                                  "grid",
                                  ProductData.fromDocument(
                                      snapshot.data.documents[index]));
                            }),
                        ListView.builder(
                            padding: EdgeInsets.all(4.0),
                            itemCount: snapshot.data.documents.length,
                            itemBuilder: (context, index) {
                              return ProductTile(
                                  "list",
                                  ProductData.fromDocument(
                                      snapshot.data.documents[index]));
                              return Text("oi",style: TextStyle(color:Colors.black));
                            })
                      ]);
                }
              },
            )));
  }
}
