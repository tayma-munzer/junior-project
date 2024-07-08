import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/signupaccount.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController _firstNameController = TextEditingController();
  TextEditingController _lastNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();

  String _firstName = '';
  String _lastName = '';
  String _age = '';
  String _country = '';
  String _selectedCountry = 'دمشق';
  bool _isError = false;
  Map<String, String> api_data = {};
  bool _validateInput(String value, String fieldName) {
    if (value.isEmpty) {
      showErrorMessage('$fieldName يجب ان لا يكون فارغ');
      return false;
    } else if (!RegExp(r'^[a-zA-Z]+$').hasMatch(value)) {
      showErrorMessage('$fieldName يجب ان يحوي حروف فقط');
      return false;
    } else {
      _firstName = value;
      _lastName = value;
      _age = value;
      return true;
    }
  }

  bool _validateAge(String value, String fieldName) {
    if (value.isEmpty) {
      showErrorMessage('$fieldName يجب ان لا يكون فارغ');
      return false;
    } else if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
      showErrorMessage('$fieldName يجب ان يكون رقما فقط');
      return false;
    } else {
      return true;
    }
  }

  void showErrorMessage(String message) {
    setState(() {
      _isError = true;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Align(
          alignment: Alignment.centerRight,
          child: Text(message),
        ),
        duration: Duration(seconds: 2),
      ),
    );
  }

  String selectedMainCategory = '';
  List preservations = [];
  void fetch() async {
    var url1 = get_preservations;
    var res = await http.get(Uri.parse(url1));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      preservations = data.map((item) => item).toList();
      selectedMainCategory = preservations[0]['p_name'];
      print(preservations);
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            padding: EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الاسم الاول',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _firstNameController,
                        decoration: InputDecoration(
                          hintText: 'الاسم الاول',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _isError ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'الاسم الاخير',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _lastNameController,
                        decoration: InputDecoration(
                          hintText: 'الاسم الاخير',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _isError ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'العمر',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _ageController,
                        decoration: InputDecoration(
                          hintText: 'العمر',
                          border: OutlineInputBorder(
                            borderSide: BorderSide(
                              color: _isError ? Colors.red : Colors.grey,
                            ),
                          ),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'المحافظة  ',
                          textAlign: TextAlign.right,
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 60,
                        child: DropdownButton(
                          value: selectedMainCategory,
                          onChanged: (newValue) {
                            setState(() {
                              _selectedCountry = newValue!.toString();
                              _country = newValue.toString();
                              selectedMainCategory = newValue!.toString();
                            });
                          },
                          items: preservations.map((country) {
                            return DropdownMenuItem(
                              value: country['p_name'],
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(country['p_name']),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateInput(
                                _firstNameController.text, 'الاسم الاول') &&
                            _validateInput(
                                _lastNameController.text, 'الاسم الاخير') &&
                            _validateAge(_ageController.text, 'العمر')) {
                          setState(() {
                            _firstName = _firstNameController.text;
                            _lastName = _lastNameController.text;
                            _age = _ageController.text;
                            _isError = false;
                            api_data = {
                              'f_name': _firstName,
                              'l_name': _lastName,
                              'age': _age,
                              'preservation': selectedMainCategory
                            };
                            print(api_data);
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    SignUpAccountPage(api_data)),
                          );
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: Text('التالي'),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
