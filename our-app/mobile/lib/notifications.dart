import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/services/PusherServices.dart';
import 'package:shared_preferences/shared_preferences.dart';

class notifications extends StatefulWidget {
  const notifications({super.key});

  @override
  State<notifications> createState() => _notificationsState();
}

class _notificationsState extends State<notifications> {
  List<Map<String, dynamic>> notifications = [];
  @override
  void initState() {

    super.initState();
    getNotifications();
  }
Future<void> getNotifications() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  String jsonString = prefs.getString('notifications') ?? '[]';
  print(jsonString);
  notifications = List<Map<String, dynamic>>.from(jsonDecode(jsonString));
  setState(() {

  });
}
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Container(
        margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 10.0),
        child: ListView.separated(
          itemCount: notifications.length,
          itemBuilder: (context, index) {
            return InkWell(
                splashColor: Colors.blue,
                borderRadius: BorderRadius.circular(25),
                onTap: () {
                  // Handle tile tap event
                },
                child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.blue, // Set your desired border color here
                        width: 1.5, // Set the border width
                      ),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: ListTile(
                      leading: Icon(
                        Icons.notifications,
                        color: Colors.blue,
                      ),
                      title: Text(
                        notifications[index]["title"]!,
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      subtitle: Text(
                        notifications[index]["body"]!,
                      ),
                    )));
          },
          separatorBuilder: (BuildContext context, int index) {
            return SizedBox(
                height: 10); // Adjust the height as per your requirement
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
