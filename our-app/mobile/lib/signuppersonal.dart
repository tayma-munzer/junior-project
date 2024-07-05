import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/settings_.dart';
import 'package:mobile/Signuproles.dart';

class SignUpPersonalPage extends StatefulWidget {
  const SignUpPersonalPage({Key? key}) : super(key: key);

  @override
  _SignUpPersonalPageState createState() => _SignUpPersonalPageState();
}

class _SignUpPersonalPageState extends State<SignUpPersonalPage> {
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _userbioController = TextEditingController();
  late File _selectedImage = File('');

  String _username = '';
  String _userbio = '';
  bool _isError = false;

  Future<void> _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      final pickedImageBytes = await pickedImage.readAsBytes();
      String base64Image = base64Encode(pickedImageBytes);
      setState(() {
        _selectedImage = File(pickedImage.path);
      });
    }
  }

  bool _validateInput(String value, String fieldName) {
    if (value.isEmpty) {
      showErrorMessage('$fieldName يجب ان لا يكون فارغ');
      return false;
    } else {
      _username = value;
      _userbio = value;
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

  Future<void> _chooseAccountPicture() async {
    _selectImage();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 40,
                  ),
                  Text(
                    "   دع الاخرين يتعرفون عليك\n انشئ حسابك التعريفي ",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: const Color.fromARGB(255, 0, 0, 0),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  GestureDetector(
                    onTap: _chooseAccountPicture,
                    child: Container(
                      width: 100,
                      height: 100,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: _selectedImage != null
                            ? DecorationImage(
                                image: FileImage(_selectedImage),
                                fit: BoxFit.cover,
                              )
                            : null,
                      ),
                      child: _selectedImage != null
                          ? null
                          : Icon(Icons.add_a_photo,
                              size: 100, color: Colors.blue),
                    ),
                  ),
                  TextButton(
                    onPressed: _chooseAccountPicture,
                    child: Text('اضغط هنا لتضيف صورة'),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        'اسم المستخدم ',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _usernameController,
                        decoration: InputDecoration(
                          hintText: ' اسم المستخدم',
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
                        ' تعريف بسيط عن نفسك',
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 18),
                      ),
                      SizedBox(height: 8),
                      TextField(
                        controller: _userbioController,
                        keyboardType: TextInputType.multiline,
                        decoration: InputDecoration(
                          hintText: 'تعريف بسيط عن نفسك',
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (_validateInput(
                                  _usernameController.text, ' اسم المستخدم') &&
                              _validateInput(_userbioController.text,
                                  'تعريف بسيط عن نفسك')) {
                            setState(() {
                              _username = _usernameController.text;
                              _userbio = _userbioController.text;
                              _isError = false;
                            });
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => SignUpRolesPage(),
                              ),
                            );
                            print('username: $_username');
                            print('bio: $_userbio');
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          foregroundColor: Colors.white,
                          minimumSize: Size(350, 50),
                        ),
                        child: Text(
                          'التالي',
                          style: TextStyle(
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/toppinkcorner.png', width: 250),
          ),
        ],
      ),
    );
  }
}
