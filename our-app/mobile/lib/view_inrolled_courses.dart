import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/readcourse.dart';
import 'dart:convert';

import 'appbar.dart';
import 'bottombar.dart';
import 'controller/authManager.dart';
import 'drawer.dart';

class ViewCourses2 extends StatefulWidget {
  @override
  _ViewCourses2State createState() => _ViewCourses2State();
}

class _ViewCourses2State extends State<ViewCourses2> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  void fetchCourses() async {
    var url = 'http://10.0.2.2:8000/api/get_my_courses_enrollments';
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    dynamic data = json.decode(res.body);
    print(data); // Print the API response

    if (data is List) {
      // Handle response as a list of courses
      setState(() {
        courses = data;
      });
    } else if (data is Map && data.containsKey('courses')) {
      // Handle response as a map with a 'courses' field
      setState(() {
        courses = data['courses'];
      });
    } else {
      print('Invalid API response');
    }

    print(courses);
    print(res.body);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: courses.length,
          itemBuilder: (BuildContext context, int index) {
            var course = courses[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailsPage( course['c_id']),
                  ),
                );
              },
              child: Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(
                    course['c_name'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
