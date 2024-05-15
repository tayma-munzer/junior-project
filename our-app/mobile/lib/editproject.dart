import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class projectedit extends StatefulWidget {
  final int p_id;
  const projectedit(this.p_id, {Key? key}) : super(key: key);

  @override
  State<projectedit> createState() => _projecteditState();
}

class _projecteditState extends State<projectedit> {
  Map<String, dynamic> Projects = {};

  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController responsibilitiesController = TextEditingController();

  void fetch() async {
    var url = get_project;
    var res =
        await http.post(Uri.parse(url), body: {'p_id': widget.p_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    Projects = data;
    nameController.text = Projects['p_name'] ?? '';
    descriptionController.text = Projects['p_desc'] ?? '';
    startController.text = Projects['start_date'] ?? '';
    endController.text = Projects['end_date'] ?? '';
    responsibilitiesController.text = Projects['responsibilities'] ?? '';

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
                'المشاريع',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              buildTextField('اسم المشروع', nameController, (value) {
                if (value.isEmpty) {
                  return 'project name cant be empty';
                }
                return null;
              }),
              buildTextField(' وصف المشروع', descriptionController, (value) {
                if (value.isEmpty) {
                  return ' project description cant be empty';
                }
                return null;
              }),
              buildTextField('تاريخ البدء بالمشروع ', startController, (value) {
                if (value.isEmpty) {
                  return 'start date of project cant be empty';
                }
                return null;
              }),
              buildTextField('تاريخ انهاء المشروع ', endController, (value) {
                if (value.isEmpty) {
                  return 'end date of project cant be empty';
                }
                return null;
              }),
              buildTextField('مسؤوليات', responsibilitiesController, (value) {
                if (value.isEmpty) {
                  return 'responsabilities of project cant be empty';
                }
                return null;
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      descriptionController.text.isNotEmpty &&
                      startController.text.isNotEmpty &&
                      endController.text.isNotEmpty &&
                      responsibilitiesController.text.isNotEmpty) {
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
    String name = nameController.text;
    String desc = descriptionController.text;
    String startdate = startController.text;
    String enddate = endController.text;
    String resbonsabilities = responsibilitiesController.text;

    print('name: $name');
    print('desc: $desc');
    print('start date: $startdate');
    print('end date: $enddate');
    print('resbonsabilities :$resbonsabilities');
    print('project id: ${Projects['p_id']}');

    AuthCont.editproject(Projects['p_id'].toString(), name, desc, startdate,
            enddate, resbonsabilities)
        .then((value) {
      if (value.statusCode == 200) {
        print('edit successfully');
      } else {
        print('something went wrong');
      }
    });
  }
}
