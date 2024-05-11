import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';

class EditCv extends StatefulWidget {
  const EditCv({Key? key}) : super(key: key);

  @override
  State<EditCv> createState() => _EditCvState();
}

class _EditCvState extends State<EditCv> {
  Map<String, dynamic> mainInfo = {};
  TextEditingController emailController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController careerObjController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetch();
  }

  void fetch() async {
    String? token = await AuthManager.getToken();
    var url = get_all_cv;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    mainInfo = data['cv'];
    emailController.text = mainInfo['email'] ?? '';
    phoneController.text = mainInfo['phone'].toString() ?? '';
    addressController.text = mainInfo['address'] ?? '';
    careerObjController.text = mainInfo['career_obj'] ?? '';
    setState(() {});
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
              buildTextField('Email', emailController, (value) {
                if (!isValidEmail(value)) {
                  return 'Invalid email';
                }
                return null;
              }),
              buildTextField('Phone', phoneController, (value) {
                if (!isValidPhone(value)) {
                  return 'Invalid phone number';
                }
                return null;
              }),
              buildTextField('Address', addressController, (value) {
                if (value.isEmpty) {
                  return 'Address cannot be empty';
                }
                return null;
              }),
              buildTextField('Career Objective', careerObjController, (value) {
                if (value.isEmpty) {
                  return 'Career Objective cannot be empty';
                }
                return null;
              }),
              SizedBox(height: 20),
              ElevatedButton(
                onPressed: () {
                  // Add save functionality here
                  if (isValidEmail(emailController.text) &&
                      isValidPhone(phoneController.text) &&
                      addressController.text.isNotEmpty &&
                      careerObjController.text.isNotEmpty) {
                    saveValues();
                  } else {
                    // Show error message or handle invalid input
                  }
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
        // validator: validator,
      ),
    );
  }

  void saveValues() {
    String email = emailController.text;
    String phone = phoneController.text;
    String address = addressController.text;
    String careerObj = careerObjController.text;

    print('Email: $email');
    print('Phone: $phone');
    print('Address: $address');
    print('Career Objective: $careerObj');
    print('CV ID: ${mainInfo['cv_id']}');
  }

  bool isValidEmail(String email) {
    return true;
  }

  bool isValidPhone(String phone) {
    return true;
  }
}
