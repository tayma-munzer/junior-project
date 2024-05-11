import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class editskill extends StatefulWidget {
  final int s_id;
  const editskill(this.s_id, {Key? key}) : super(key: key);
  @override
  State<editskill> createState() => _editskillState();
}

class _editskillState extends State<editskill> {
  Map<String, dynamic> skillDetails = {};
  TextEditingController nameController = TextEditingController();
  TextEditingController yearsController = TextEditingController();
  TextEditingController levelController = TextEditingController();

  void fetch() async {
    var url = get_skill;
    var res =
        await http.post(Uri.parse(url), body: {'s_id': widget.s_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    skillDetails = data;
    nameController.text = skillDetails['s_name'] ?? '';
    levelController.text = skillDetails['s_level'] ?? '';
    yearsController.text = skillDetails['years_of_exp'].toString() ?? '';
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
                'مهارات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              buildTextField('اسم المهارة', nameController, (value) {
                if (value.isEmpty) {
                  return 'Invalid email';
                }
                return null;
              }),
              buildTextField('مستوى المهارة', levelController, (value) {
                if (value.isEmpty) {
                  return 'Invalid phone number';
                }
                return null;
              }),
              buildTextField('عدد سنين الخبرة', yearsController, (value) {
                if (value.isEmpty) {
                  return 'Address cannot be empty';
                }
                return null;
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (nameController.text.isNotEmpty &&
                      levelController.text.isNotEmpty &&
                      yearsController.text.isNotEmpty) {
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
    String level = levelController.text;
    String yearsofexp = yearsController.text;

    print('name: $name');
    print('level: $level');
    print('yearsofexp: $yearsofexp');
    print('Skill id: ${skillDetails['s_id']}');
  }
}
