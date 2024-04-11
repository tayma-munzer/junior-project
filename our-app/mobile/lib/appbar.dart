import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Color.fromARGB(255, 252, 226, 188),
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_active),
        ),
        IconButton(
          onPressed: () {
            Scaffold.of(context).openDrawer();
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
