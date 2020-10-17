import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvacecom/widgets/customButton.dart';
import 'package:tvacecom/widgets/customFields.dart';

import '../constants.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {

  Future<void> _alertDialogBuilder(String error) async{
    return showDialog(
         barrierDismissible: false,
        context: context,
        builder: (context){
          return AlertDialog(
            title: Text("Error"),
            content: Container(
              child: Text(error),
            ),
            actions: [
              FlatButton(
                child: Text("close"),
                onPressed:(){Navigator.pop(context);} ,
              )
            ],
          );
        }
    );
  }


  Future<String> _createAccount() async{
    try{
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _registerEmail,
          password: _registerPassword);
      return null;
    }on FirebaseAuthException catch(e){
      if (e.code == 'weak-password') {
        return 'The password provided is too weak.';
      } else if (e.code == 'email-already-in-use') {
        return 'The account already exists for that email.';
      }
      return e.message;
    }catch(e){
     return e;
    }
  }

  void _submitForm() async{
    setState(() {
      _isRegisterFormLoading = true;
    });
    String _createAccountFeedback = await _createAccount();
    if(_createAccountFeedback != null){
      _alertDialogBuilder(_createAccountFeedback);
      setState(() {
        _isRegisterFormLoading = false;
      });
    }else{
      Navigator.pop(context);
    }

  }

  bool _isRegisterFormLoading = false;

  String _registerEmail = "";
  String _registerPassword = "";

  FocusNode _passwordFocusNode;

  @override
  void initState() {
    _passwordFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    _passwordFocusNode.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 24.0),
                child: Text('   Create A New Account',
                  textAlign: TextAlign.center,
                  style: Constants.boldheading,),
              ),
              Column(
                children: [
                  CustomInput(
                    hintText: 'Email',
                    onChanged: (value){
                      _registerEmail = value;
                    },
                    onSubmitted: (value){
                      _passwordFocusNode.requestFocus();
                    },
                    textInputAction: TextInputAction.next,
                  ),
                  CustomInput(
                    hintText: 'Password',
                    onChanged: (value){
                      _registerPassword = value;  },
                    focusNode: _passwordFocusNode,
                    isObscureText: true,
                    onSubmitted: (value){
                      _submitForm();
                    },
                  ),

                  CustomBtn(
                    text: "Register",
                    onPressed: (){
                     _submitForm();
                      },
                    isLoading: _isRegisterFormLoading,
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: "Back to Login",
                  onPressed: (){
                    Navigator.pop(context);
                  },
                  outlineBtn: true,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
