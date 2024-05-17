import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class edittrainingcourse extends StatefulWidget {
  final int t_id;
  const edittrainingcourse(this.t_id, {Key? key}) : super(key: key);

  @override
  State<edittrainingcourse> createState() => _edittrainingcourseState();
}

class _edittrainingcourseState extends State<edittrainingcourse> {
  Map<String, dynamic> training_courses = {};

  TextEditingController nameController = TextEditingController();
  TextEditingController trainingcenterController = TextEditingController();
  TextEditingController dateController = TextEditingController();

  void fetch() async {
    var url = get_training_course;
    var res =
        await http.post(Uri.parse(url), body: {'t_id': widget.t_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    training_courses = data;
    nameController.text = training_courses['course_name'] ?? '';
    trainingcenterController.text = training_courses['training_center'] ?? '';
    dateController.text = training_courses['completion_date'] ?? '';

    print(data);
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              Text(
                'الدورات التدريبية',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              buildTextField('اسم الدورة', nameController, (value) {
                if (value.isEmpty) {
                  return 'course name cant be empty';
                }
                return null;
              }),
              buildTextField(' اسم مركز التدريب', trainingcenterController,
                  (value) {
                if (value.isEmpty) {
                  return ' course training center cant be empty';
                }
                return null;
              }),
              buildTextField('تاريخ انهاء الدورة ', dateController, (value) {
                if (value.isEmpty) {
                  return 'completion date of project cant be empty';
                }
                return null;
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      trainingcenterController.text.isNotEmpty &&
                      dateController.text.isNotEmpty) {
                    saveValues();
                  } else {}
                },
                child: Text('Save'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      String? Function(String) validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void saveValues() {
    String course_name = nameController.text;
    String training_center = trainingcenterController.text;
    String completion_date = dateController.text;

    print('course_name: $course_name');
    print('training_center: $training_center');
    print('completion_date: $completion_date');
    print('project id: ${training_courses['t_id']}');

    AuthCont.edittrainingcourse(training_courses['t_id'].toString(),
            course_name, training_center, completion_date)
        .then((value) {
      if (value.statusCode == 200) {
        print('edit successfully');
      } else if (value.statusCode == 402) {
        print('something went wrong');
      } else {
        print('object');
      }
    });
  }
}
