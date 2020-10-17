import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tvacecom/constants.dart';
import 'package:tvacecom/services/firebase_services.dart';
import 'package:tvacecom/tabs/home_tab.dart';
import 'package:tvacecom/tabs/saved_tab.dart';
import 'package:tvacecom/tabs/search_tab.dart';
import 'package:tvacecom/widgets/bottom_tabs.dart';


class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  FirebaseServices _firebaseServices = FirebaseServices();

  PageController _tabsPageController;
  int _selectedTab = 0;

  @override
  void initState() {
    print("userId: ${_firebaseServices.getUserId()}");
    _tabsPageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    _tabsPageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment:MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
           child: PageView(
             controller: _tabsPageController,
             onPageChanged: (num){
               setState(() {
                 _selectedTab = num;
               });
             },
             children: [
                HomeTab(),
                SearchTab(),
                SavedTab(),

             ],
           ),
          ),

          BottomTabs(
            selectedTab: _selectedTab ,
            tabPressed: (num){
              _tabsPageController.animateToPage(
                  num,
                  duration: Duration(milliseconds: 300),
                  curve: Curves.easeOutCubic
              );
            },
          )

        ],
      )
    );
  }
}
