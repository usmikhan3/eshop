import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvacecom/constants.dart';
import 'package:tvacecom/services/firebase_services.dart';
import 'package:tvacecom/widgets/customFields.dart';
import 'package:tvacecom/widgets/custom_action_bar.dart';
import 'package:tvacecom/widgets/product_card.dart';

class SearchTab extends StatefulWidget {

  @override
  _SearchTabState createState() => _SearchTabState();
}

class _SearchTabState extends State<SearchTab> {
  FirebaseServices _firebaseServices = FirebaseServices();

  String _searchString = "";

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [



          if(_searchString.isEmpty)
            Center(
              child: Container(

                  child: Text("Search Result", style: Constants.regularDarkText,)),
            )
          else
            FutureBuilder<QuerySnapshot>(
              future: _firebaseServices
                  .productsRef
                  .orderBy("search_string")
                  .startAt([_searchString])
                  .endAt(['$_searchString\uf8ff'])
                  .get(),
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
                          top: 120.0,
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
          Padding(
            padding: const EdgeInsets.only(top: 45.0),
            child: CustomInput(
              hintText: "Search here",
              onSubmitted: (value){

                  setState(() {
                    _searchString = value.toLowerCase();
                  });


              },
            ),
          ),
          //Text("search Result", style: Constants.regularDarkText,),
        ],
      )
    );
  }
}
