import 'package:flutter/material.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/notifications.dart';
import 'package:pusher_channels_flutter/pusher_channels_flutter.dart';

class CustomAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.appbarColor,
      actions: [
        IconButton(
          onPressed: () {

        Navigator.push(context, MaterialPageRoute(builder: (context)=>const notifications()));
          },
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
