import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:mobile/colors.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 47.0,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      color: AppColors.appColor,
      animationDuration: Duration(milliseconds: 300),
      items: const [
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Icons.search),
        Icon(Icons.person),
        Icon(Icons.category)
      ],
    );
  }
}
