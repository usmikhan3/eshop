import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tvacecom/screens/landing_page.dart';


Future<void> main() async{

  runApp(MyApp());
}
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Ecommerce',
      theme: ThemeData(
        textTheme: GoogleFonts.poppinsTextTheme(
          Theme.of(context).textTheme
        ),
        accentColor: Color(0xFFFF1E00)
      ),

      home: LandingPage()
    );
  }
}
