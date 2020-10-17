import 'package:flutter/material.dart';
import 'package:tvacecom/widgets/custom_action_bar.dart';

class SavedTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Center(
            child: Text("SavedTab"),
          ),
          CustomActionBar(
            title: "Saved Item",
            hasBackArrow: false,
          )
        ],
      ),
    );
  }
}
