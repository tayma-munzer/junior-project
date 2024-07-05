import 'package:flutter/material.dart';
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
  List<String> countries = ['دمشق', 'حلب', 'حمص', 'حماة', 'ادلب', 'اللاذقية'];

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
                      Text(
                        'المحافظة',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(height: 8),
                      Container(
                        width: 350,
                        child: DropdownButton(
                          value: _selectedCountry,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedCountry = newValue!;
                              _country = newValue;
                            });
                          },
                          items: countries.map((String country) {
                            return DropdownMenuItem(
                              value: country,
                              child: Align(
                                alignment: Alignment.centerRight,
                                child: Text(country),
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
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpAccountPage()),
                          );
                          print('firstname: $_firstName');
                          print('lastname: $_lastName');
                          print('age: $_age');
                          print('country: $_country');
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
