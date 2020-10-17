import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class CustomBtn extends StatelessWidget {
  final String text;
  final Function onPressed;
  final bool outlineBtn;
  final bool isLoading;

  CustomBtn({this.text, this.onPressed, this.outlineBtn, this.isLoading});

  @override
  Widget build(BuildContext context) {

    bool _outlineBtn = outlineBtn ?? false;
    bool _isLoading = isLoading ?? false;

    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60.0,

        decoration: BoxDecoration(
          color: _outlineBtn ? Colors.transparent : Colors.black,
          border: Border.all(
            color: Colors.black,
            width: 2.0
          ),
          borderRadius: BorderRadius.circular(12.0)
        ),
        margin: EdgeInsets.symmetric(
          horizontal: 24.0,
          vertical: 8.0
        ),
        child: Stack(
          children: [
            Visibility(
              visible: _isLoading ? false : true,
              child: Center(
                child: Text(
                text ?? "Text",
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16.0,
                  color: _outlineBtn ?  Colors.black : Colors.white
                ),),
              ),
            ),
            Visibility(
              visible: _isLoading,
              child: Center(
                child: SizedBox(
                  height: 30,
                  width: 30,
                  child: CircularProgressIndicator(

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
