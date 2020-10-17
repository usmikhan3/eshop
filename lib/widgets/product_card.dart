import 'package:flutter/material.dart';
import 'package:tvacecom/screens/product_page.dart';

import '../constants.dart';

class ProductCard extends StatelessWidget {

  final Function onPressed;
  final String imageUrl;
  final String title;
  final String price;
  final String productId;

  ProductCard({this.onPressed, this.imageUrl, this.price, this.title, this.productId});


  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>ProductScreen(productId: productId,)));
      },
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
        ),
        height: 350.0,
        margin: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        child: Stack(
          children: [
            Container(
              height: 350.0,
              child: ClipRRect(

                borderRadius: BorderRadius.circular(16.0),
                child: Image.network(
                "$imageUrl",
                  fit: BoxFit.cover,

                ),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Container(
                  height: 50,
                  decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.5),
                    borderRadius: BorderRadius.circular(12.0),

                  ),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        title , style: Constants.regularHeading,),
                      Text("\R\s$price",
                        style: TextStyle(
                            fontSize: 16.0,
                            fontWeight: FontWeight.w600,
                            color: Theme.of(context).accentColor

                        ),)
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
