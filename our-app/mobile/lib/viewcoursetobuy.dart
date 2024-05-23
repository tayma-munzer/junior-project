import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/viewservice.dart';

class viewcoursetotobuy extends StatefulWidget {
  final int c_id;
  const viewcoursetotobuy(this.c_id, {Key? key}) : super(key: key);

  @override
  State<viewcoursetotobuy> createState() => _viewcoursetotobuyState();
}

Map<String, dynamic>? coursedetails;

class _viewcoursetotobuyState extends State<viewcoursetotobuy> {
  void fetchcoursedetails() async {
    var url = get_course;
    var res =
        await http.post(Uri.parse(url), body: {"c_id": widget.c_id.toString()});
    setState(() {
      coursedetails = json.decode(res.body);
      print(coursedetails);
    });
  }

  String? enable;

  List<dynamic> courses = [];
  void fetchcourses() async {
    var url = get_course;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      courses = data.map((item) => item).toList();
      print(courses);
      for (var course in courses) {
        if (course['c_id'] == coursedetails!['c_id']) {
          enable = 'true';
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchcoursedetails();
    fetchcourses();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 25),
            Image.asset('assets/getcourse.png', width: 250),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
