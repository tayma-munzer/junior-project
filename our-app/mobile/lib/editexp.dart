import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class editexp extends StatefulWidget {
  final int exp_id;
  const editexp(this.exp_id, {Key? key}) : super(key: key);

  @override
  State<editexp> createState() => _editexpState();
}

class _editexpState extends State<editexp> {
  Map<String, dynamic> experience = {};

  TextEditingController companyController = TextEditingController();
  TextEditingController positionController = TextEditingController();
  TextEditingController startController = TextEditingController();
  TextEditingController endController = TextEditingController();
  TextEditingController responsibilitiesController = TextEditingController();

  void fetch() async {
    var url = get_exp;
    var res = await http
        .post(Uri.parse(url), body: {'exp_id': widget.exp_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    experience = data;
    companyController.text = experience['company'] ?? '';
    positionController.text = experience['position'] ?? '';
    startController.text = experience['start_date'] ?? '';
    endController.text = experience['end_date'] ?? '';
    responsibilitiesController.text = experience['responsibilities'] ?? '';
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
                'الخبرات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              buildTextField('اسم الشركة', companyController, (value) {
                if (value.isEmpty) {
                  return 'company name cant be empty';
                }
                return null;
              }),
              buildTextField('المسمى الوظيفي ', positionController, (value) {
                if (value.isEmpty) {
                  return 'position  cant be empty';
                }
                return null;
              }),
              buildTextField('  تاريخ البدء في العمل', startController,
                  (value) {
                if (value.isEmpty) {
                  return ' start date cant be empty';
                }
                return null;
              }),
              buildTextField('  تاريخ انهاء العمل', endController, (value) {
                if (value.isEmpty) {
                  return ' end date cant be empty';
                }
                return null;
              }),
              buildTextField('مسؤوليات العمل', responsibilitiesController,
                  (value) {
                if (value.isEmpty) {
                  return '  responsibilities cant be empty';
                }
                return null;
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  if (companyController.text.isNotEmpty &&
                      positionController.text.isNotEmpty &&
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
    String company = companyController.text;
    String position = positionController.text;
    String startdate = startController.text;
    String enddate = endController.text;
    String responsibilites = responsibilitiesController.text;

    print('company: $company');
    print('position: $position');
    print('startdate: $startdate');
    print('end date: $enddate');
    print('responsibilities: $responsibilites');
    print('exp id: ${experience['exp_id']}');

    AuthCont.editexp(experience['exp_id'].toString(), company, position,
            startdate, enddate, responsibilites)
        .then((value) {
      if (value.statusCode == 200) {
        print('edit successfully');
      } else {
        print('something went wrong');
      }
    });
  }
}
