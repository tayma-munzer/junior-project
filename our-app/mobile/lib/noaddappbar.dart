import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';

class NoAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appbarColor,
      actions: [
        IconButton(
          onPressed: () {},
          icon: Icon(Icons.notifications_active),
        ),
      ],
    );
  }
}
