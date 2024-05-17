import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class editeducation extends StatefulWidget {
  final int e_id;
  const editeducation(this.e_id, {Key? key}) : super(key: key);

  @override
  State<editeducation> createState() => _editeducationState();
}

class _editeducationState extends State<editeducation> {
  Map<String, dynamic> education = {};

  TextEditingController uniController = TextEditingController();
  TextEditingController degreeController = TextEditingController();
  TextEditingController fieldController = TextEditingController();
  TextEditingController gradyearController = TextEditingController();
  TextEditingController gbaController = TextEditingController();

  void fetch() async {
    var url = get_education;
    var res =
        await http.post(Uri.parse(url), body: {'e_id': widget.e_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    education = data;
    uniController.text = education['uni'] ?? '';
    degreeController.text = education['degree'] ?? '';
    fieldController.text = education['field_of_study'] ?? '';
    gradyearController.text = education['grad_year'] ?? '';
    gbaController.text = education['gba'] ?? '';

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
                'التعليم',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              buildTextField('اسم الجامعة', uniController, (value) {
                if (value.isEmpty) {
                  return 'project name cant be empty';
                }
                return null;
              }),
              buildTextField('  درجة الشهادة', degreeController, (value) {
                if (value.isEmpty) {
                  return ' project description cant be empty';
                }
                return null;
              }),
              buildTextField('اختصاص الدراسة', fieldController, (value) {
                if (value.isEmpty) {
                  return 'start date of project cant be empty';
                }
                return null;
              }),
              buildTextField('سنة التخرج', gradyearController, (value) {
                if (value.isEmpty) {
                  return 'end date of project cant be empty';
                }
                return null;
              }),
              buildTextField('المعدل التراكمي', gbaController, (value) {
                if (value.isEmpty) {
                  return 'responsabilities of project cant be empty';
                }
                return null;
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (uniController.text.isEmpty &&
                      fieldController.text.isNotEmpty &&
                      gbaController.text.isNotEmpty &&
                      gradyearController.text.isNotEmpty &&
                      degreeController.text.isNotEmpty) {
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
    String uni = uniController.text;
    String degree = degreeController.text;
    String field_of_study = fieldController.text;
    String grad_year = gradyearController.text;
    String gba = gbaController.text;

    print('uni: $uni');
    print('degree: $degree');
    print(' field_of_study: $field_of_study');
    print('grad_year: $grad_year');
    print('gba :$gba');
    print('education id: ${education['e_id']}');

    AuthCont.editeducation(education['e_id'].toString(), uni, degree,
            field_of_study, grad_year, gba)
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
