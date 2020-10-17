import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tvacecom/constants.dart';

class CustomInput extends StatelessWidget {

  final String hintText;
  final Function(String) onChanged;
  final Function(String) onSubmitted;
  final FocusNode focusNode;
  final TextInputAction textInputAction;
  final bool isObscureText;

  CustomInput({this.hintText, this.onChanged, this.onSubmitted, this.focusNode, this.textInputAction, this.isObscureText});
  @override
  Widget build(BuildContext context) {

    bool _isObscureText = isObscureText ?? false;
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: 24.0,
        vertical: 8.0
      ),
      decoration: BoxDecoration(
        border: Border.all(
          color: Color(0xFFF2F2F2)
        ),
        borderRadius: BorderRadius.circular(12.0)
      ),
      child: TextField(
        focusNode: focusNode,
        onChanged: onChanged,
        onSubmitted: onSubmitted,
        textInputAction: textInputAction,
        obscureText: _isObscureText,
        decoration: InputDecoration(
          hintText: hintText ?? 'hint text',
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(
            horizontal: 24.0,
            vertical: 18.0
          )
        ),
        style: Constants.regularDarkText,
      ),
    );
  }
}
