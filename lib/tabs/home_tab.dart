
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvacecom/constants.dart';
import 'package:tvacecom/screens/product_page.dart';
import 'package:tvacecom/widgets/custom_action_bar.dart';
import 'package:tvacecom/widgets/product_card.dart';

class HomeTab extends StatelessWidget {

  final CollectionReference _productsRef = FirebaseFirestore.instance.collection("Products");

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          FutureBuilder<QuerySnapshot>(
            future: _productsRef.get(),
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                return Scaffold(
                  body: Center(
                    child: Text("Error: ${snapshot.error}"),
                  ),
                );
              }
              //collection data ready to display
              if(snapshot.connectionState == ConnectionState.done){
                //display the data inside the listView
                return ListView(
                  padding: EdgeInsets.only(
                    top: 108.0,
                    bottom: 12.0

                  ),
                  children: snapshot.data.docs.map((document)  {
                    return ProductCard(
                      title: document.data()['name'],
                      imageUrl: document.data()['images'][0],
                      price: "${document.data()['price']}",
                      productId: document.id,
                    );
                  }).toList()


                );

              }


              return Scaffold(
                body: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          ),
          CustomActionBar(
            title: "Home",
            hasBackArrow: false,
          )
        ],
      ),
    );
  }
}
