import 'package:flutter/material.dart';
import 'package:mobile/signuppersonal.dart';

class SignUpAccountPage extends StatefulWidget {
  const SignUpAccountPage({Key? key}) : super(key: key);

  @override
  _SignUpAccountPageState createState() => _SignUpAccountPageState();
}

class _SignUpAccountPageState extends State<SignUpAccountPage> {
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();
  String _email = '';
  String _password = '';
  String _confirmedPassword = '';
  bool _isError = false;
  bool _emailPasswordVisible = false;
  bool _confirmPasswordVisible = false;

  bool _validateInput(String value, String fieldName) {
    if (value.isEmpty) {
      showErrorMessage('يجب ان لا يكون $fieldName فارغ');
      return false;
    } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      showErrorMessage('هذه ليست الصيغة الصحيحة ل$fieldName');
      return false;
    } else {
      _email = value;
      _password = value;
      return true;
    }
  }

  bool _validatePassword(String value, String fieldName) {
    if (value.isEmpty) {
      showErrorMessage('$fieldName يجب ان لا يكون فارغ');
      return false;
    } else if (value.length < 8) {
      showErrorMessage('$fieldName يجب ان يحتوي على 8 أحرف على الأقل');
      return false;
    } else {
      return true;
    }
  }

  bool _validateConfirmPassword() {
    if (_passwordController.text != _confirmPasswordController.text) {
      showErrorMessage('يجب ان تكون كلمة المرور وتأكيد كلمة المرور متطابقتين');
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
        duration: const Duration(seconds: 2),
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
            padding: const EdgeInsets.only(top: 20),
            child: Padding(
              padding: const EdgeInsets.all(12.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    width: MediaQuery.of(context).size.width,
                    height: MediaQuery.of(context).size.height / 3,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage("assets/accountimage.png"),
                      ),
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'البريد الالكتروني',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      TextField(
                        controller: _emailController,
                        decoration: InputDecoration(
                          hintText: 'البريد الالكتروني',
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
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'كلمة المرور',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            controller: _passwordController,
                            obscureText: !_emailPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'كلمة المرور',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey,
                                ),
                              ),
                              prefixIcon: IconButton(
                                icon: Icon(
                                  _emailPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _emailPasswordVisible =
                                        !_emailPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'تأكيد كلمة المرور',
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 8),
                      Stack(
                        alignment: Alignment.centerRight,
                        children: [
                          TextField(
                            controller: _confirmPasswordController,
                            obscureText: !_confirmPasswordVisible,
                            decoration: InputDecoration(
                              hintText: 'تأكيد كلمة المرور',
                              border: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: _isError ? Colors.red : Colors.grey,
                                ),
                              ),
                              prefixIcon: IconButton(
                                icon: Icon(
                                  _confirmPasswordVisible
                                      ? Icons.visibility
                                      : Icons.visibility_off,
                                ),
                                onPressed: () {
                                  setState(() {
                                    _confirmPasswordVisible =
                                        !_confirmPasswordVisible;
                                  });
                                },
                              ),
                            ),
                            textAlign: TextAlign.right,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: MediaQuery.of(context).size.width,
                    child: ElevatedButton(
                      onPressed: () {
                        if (_validateInput(
                                _emailController.text, 'البريد الالكتروني') &&
                            _validatePassword(
                                _passwordController.text, 'كلمة المرور') &&
                            _validateConfirmPassword()) {
                          setState(() {
                            _email = _emailController.text;
                            _password = _passwordController.text;
                            _confirmedPassword =
                                _confirmPasswordController.text;
                            _isError = false;
                          });
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SignUpPersonalPage()),
                          );
                          print('email: $_email');
                          print('password: $_password');
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text('التالي'),
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
