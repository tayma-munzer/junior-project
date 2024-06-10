import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/courses_types.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/readcourse.dart';

class ListCourses extends StatefulWidget {
  const ListCourses({Key? key}) : super(key: key);

  @override
  State<ListCourses> createState() => _ListCoursesState();
}

List<dynamic> Courses = [];

class _ListCoursesState extends State<ListCourses> {
  void fetchCourses() async {
    var url = get_course_for_user;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      Courses = data.map((item) => item).toList();
      print('courses');
      print(Courses);
    });
  }

  String? user;
  String? job;
  String? service;
  String? course;

  Future<void> fetchRoles() async {
    String? userRole = await AuthManager.isUser();
    String? jobRole = await AuthManager.isjobOwner();
    String? serviceRole = await AuthManager.isserviceOwner();

    setState(() {
      this.user = userRole;
      this.job = jobRole;
      this.service = serviceRole;
    });
  }

  void deleteCourses(int c_id) async {
    var url = delete_course;
    var res = await http.post(Uri.parse(url), body: {'c_id': c_id});

    fetchCourses();
  }

  @override
  void initState() {
    super.initState();
    fetchCourses();
    fetchRoles();
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
            itemCount: Courses.length,
            itemBuilder: (context, index) {
              final Course = Courses[index];
              Color backgroundColor = index % 2 == 0
                  ? Color.fromARGB(255, 146, 206, 255)
                  : Colors.white;
              return ListTile(
                title: Text(Course['c_name']),
                subtitle: Text(Course['c_desc']),
                tileColor: backgroundColor,
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
                                  CourseDetailsPage(Course['c_id'])),
                        );
                      },
                    ),
                    IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () async {
                        var url = delete_course;
                        var res = await http.post(Uri.parse(url),
                            body: {'c_id': Course['c_id'].toString()});
                        if (res.statusCode == 200) {
                          fetchCourses();
                          print('deleted seccessfully');
                        }
                      },
                    ),
                  ],
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => Course_types()),
                  );
                },
              );
            }),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
