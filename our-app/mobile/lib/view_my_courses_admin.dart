import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/readcourse.dart';
import 'dart:convert';

import 'appbar.dart';
import 'bottombar.dart';
import 'constant/links.dart';
import 'controller/authManager.dart';
import 'drawer.dart';
import 'editCourse.dart';
import 'listCourses.dart';

class ViewCourses extends StatefulWidget {
  @override
  _ViewCoursesState createState() => _ViewCoursesState();
}

class _ViewCoursesState extends State<ViewCourses> {
  List<dynamic> courses = [];

  @override
  void initState() {
    super.initState();
    fetchCourses();
  }

  void fetchCourses() async {
    var url = 'http://10.0.2.2:8000/api/get_my_courses';
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    dynamic data = json.decode(res.body);
    print(data); // Print the API response
    if (data['services'] is List) {
      setState(() {
        courses = data['services'];
      });
    } else {
      print('Invalid API response');
    }
    print(courses);
  }
  Future<void> deleteCourse(int courseId) async {
    var url = delete_course;
    var response = await http.post(Uri.parse(url), body: {
      "c_id": courseId.toString(),
    });

    if (response.statusCode == 200) {
      // Course deleted successfully
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListCourses()),
      );
    } else {
      print("Delete request failed with status: ${response.statusCode}");
    }
  }

  Future<void> confirmDeleteCourse(int courseId) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text("تأكيد عملية الحذف"),
            content: Text("هل أنت متأكد أنك تريد حذف هذه الدورة التعليمية؟"),
            actions: [
              TextButton(
                child: Text("إلغاء"),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
              TextButton(
                child: Text("تأكيد"),
                onPressed: () {
                  deleteCourse(courseId); // Pass the courseId to deleteCourse
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
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
                  subtitle: Text(
                    course['c_desc'],
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    EditCourse(course['c_id'])),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          confirmDeleteCourse(course['c_id']); // Pass the courseId to confirmDeleteCourse
                        },
                      ),
                    ],
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
