import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvacecom/constants.dart';
import 'package:tvacecom/screens/home.dart';
import 'package:tvacecom/screens/register.dart';
import 'package:tvacecom/widgets/customButton.dart';
import 'package:tvacecom/widgets/customFields.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {

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

  Future<String> _loginAccount() async{
    try{
      await FirebaseAuth.instance.signInWithEmailAndPassword(email: _loginEmail  , password: _loginPassword);
      return null;
    }on FirebaseAuthException catch(e){
      if (e.code == 'user-not-found') {
        return'No user found for that email.';
      } else if (e.code == 'wrong-password') {
        return'Wrong password provided for that user.';
      }
      return e.message;
    }catch(e){
      return e;
    }
  }


  void _submitForm() async{
    setState(() {
      _loginFormLoading = true;
    });
    String _loginFeedback = await _loginAccount();
    if(_loginFeedback != null){
      _alertDialogBuilder(_loginFeedback);

      setState(() {
        _loginFormLoading = false;
      });
    }

  }

  // Default Form Loading State
  bool _loginFormLoading = false;

  // Form Input Field Values
  String _loginEmail = "";
  String _loginPassword = "";

  // Focus Node for input fields
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
                child: Text('   Welcome User,\nLogin to your Account',
                  textAlign: TextAlign.center,
                style: Constants.boldheading,),
              ),
              Column(
               children: [
                 CustomInput(
                   hintText: 'Email',
                   onChanged: (value){
                     _loginEmail = value;
                   },
                   onSubmitted: (value) {
                     _passwordFocusNode.requestFocus();
                   },
                   textInputAction: TextInputAction.next,
                 ),
                 CustomInput(
                   hintText: 'Password',
                   onChanged: (value){
                     _loginPassword = value;
                   },
                   focusNode: _passwordFocusNode,

                   onSubmitted: (value){
                     _submitForm();
                   },
                 ),
                 CustomBtn(
                   text: "Login",
                   onPressed: (){
                     _submitForm();
                   },
                   isLoading: _loginFormLoading,
                 ),
               ],
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 16.0),
                child: CustomBtn(
                  text: "Create New Account",
                  onPressed: (){
                   Navigator.push(context, MaterialPageRoute(builder: (context)=>RegisterScreen()));
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
