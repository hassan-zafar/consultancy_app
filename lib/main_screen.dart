import 'package:consultancy_app/Screens/bottom_bar.dart';
import 'package:flutter/material.dart';

class MainScreens extends StatelessWidget {
  static const routeName = '/MainScreen';

  @override
  Widget build(BuildContext context) {
    return PageView(
      children: [
        // HomePage()
        BottomBarScreen(),
      ],
    );
  }
}
