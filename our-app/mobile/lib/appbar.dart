import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_active),
        ),
        IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: Icon(Icons.arrow_forward),
        ),
      ],
    );
  }
}
