import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/BuidCourseItem.dart';
import 'package:mobile/addcourse.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/readcourse.dart';

import 'bottombar.dart';

class SecondaryCoursesPage extends StatefulWidget {
  final int ct_id;

  const SecondaryCoursesPage(this.ct_id);

  @override
  _SecondaryCoursesPageState createState() => _SecondaryCoursesPageState();
}

class _SecondaryCoursesPageState extends State<SecondaryCoursesPage> {
  List<Map<String, dynamic>> data = [];
  Future<void> fetchData() async {
    var url = get_courses_for_type;
    var response = await http
        .post(Uri.parse(url), body: {"ct_id": widget.ct_id.toString()});

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is List<dynamic>) {
        setState(() {
          data.addAll(decodedData.map((item) {
            return {
              "c_id": item["c_id"],
              "c_name": item["c_name"],
              "c_desc": item["c_desc"],
              "c_price":item["c_price"].toString(),
              "image": item["image"],
              "pre_requisite": item["pre_requisite"],
            };
          }).toList());
          print(data);
        });

      } else {
        print("Invalid response format: $decodedData");
        print(response.body);
      }
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  String? user;
  String? job;
  String? service;

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

  @override
  void initState() {
    super.initState();
    fetchData();
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
      body: SingleChildScrollView( // Wrap the Column with SingleChildScrollView
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Padding(
            padding: const EdgeInsets.all(25.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [

               // Image.asset('assets/book.webp', width:10 ),

                /*Text(
                  'الدورات التعليمية',
                  style: TextStyle(fontSize: 40),
                ),*/


                ListView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: EdgeInsets.all(20.0),
                      child: _buildItemWidget(data[index]),
                    );
                  },
                ),
                SizedBox(height: 30),
                service == 'true'
                    ? Container(
                  padding: EdgeInsets.symmetric(horizontal: 50),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AddCourse(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.all(10),
                      backgroundColor: Colors.blue,
                    ),
                    child: Text(
                      'أضف',
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    ),
                  ),
                )
                    : Container(),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget _buildItemWidget(dynamic item) {
    final String imageUrl = item["image"] ?? ""; // Use an empty string as the default value if image is null

    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the drawer
        final int id = int.parse(item["c_id"].toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailsPage(id),
          ),
        );
      },
      child: BuildCourseItem(
        item["c_name"],
        item["c_desc"],
        item["c_price"],
        imageUrl,
        item['pre_requisite'],

      ),
    );
  }
}
