import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BottomBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return CurvedNavigationBar(
      height: 47.0,
      backgroundColor: Color.fromARGB(255, 255, 255, 255),
      color: Color.fromARGB(255, 255, 224, 176),
      animationDuration: Duration(milliseconds: 300),
      items: const [
        Icon(Icons.home),
        Icon(Icons.add),
        Icon(Icons.search),
        Icon(Icons.person),
      ],
    );
  }
}
