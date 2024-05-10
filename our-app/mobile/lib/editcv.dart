import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';

class editcv extends StatefulWidget {
  const editcv({Key? key}) : super(key: key);

  @override
  State<editcv> createState() => _editcvState();
}

class _editcvState extends State<editcv> {
  Map<String, dynamic> mainInfo = {};
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController careerObjController = TextEditingController();

  void fetch() async {
    String? token = await AuthManager.getToken();
    print('object');
    var url = get_all_cv;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    mainInfo = data['cv'];
    emailController.text = mainInfo['email'] ?? '';
    phoneController.text = mainInfo['phone'] ?? '';
    addressController.text = mainInfo['address'] ?? '';
    careerObjController.text = mainInfo['career_obj'] ?? '';
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
                'Main Info',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              SizedBox(height: 10),
              buildTextField('Email', emailController),
              buildTextField('Phone', phoneController),
              buildTextField('Address', addressController),
              buildTextField('Career Objective', careerObjController),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add save functionality here
                  // You can use the text controllers to get the updated values
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

  Widget buildTextField(String label, TextEditingController controller) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextField(
        controller: controller,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }
}
