import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/firstpage.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/homepage.dart';
import 'package:mobile/signup.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String userEmail = '';
  String userPassword = '';

  String emailError = '';
  String passwordError = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                SizedBox(height: 90),
                inputFile(
                  label: 'البريد الالكتروني',
                  controller: emailController,
                  error: emailError,
                ),
                inputFile(
                  label: 'كلمة المرور',
                  obscureText: true,
                  controller: passwordController,
                  error: passwordError,
                ),
                SizedBox(height: 20),
                Center(
                  child: RichText(
                    text: TextSpan(
                      text: "لا تملك حسابا؟ ",
                      style: TextStyle(color: Colors.grey),
                      children: [
                        TextSpan(
                          text: 'انشء واحدا',
                          style: TextStyle(
                            color: Colors.blue,
                            fontWeight: FontWeight.bold,
                          ),
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => SignUpPage()),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (userEmail.isEmpty) {
                        setState(() {
                          emailError = 'يجب ان لا يكون البريد الالكتروني فراغا';
                        });
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(userEmail)) {
                        setState(() {
                          emailError = 'هذه ليست الصيغة الصحيحة لليمبل';
                        });
                      } else {
                        emailError = '';
                      }

                      if (userPassword.isEmpty) {
                        setState(() {
                          passwordError = 'يجب ان لا تكون كلمة السر فارغة';
                        });
                      } else {
                        passwordError = '';
                      }

                      if (emailError.isEmpty && passwordError.isEmpty) {
                        AuthCont.loginAuth(userEmail, userPassword)
                            .then((value) {
                          if (value.statusCode == 200) {
                            final Map<String, dynamic> responseMap =
                                json.decode(value.body);
                            AuthManager.saveToken(responseMap['token']);
                            print(responseMap['token']);
                            print(responseMap['roles']);
                            List roles = responseMap['roles'];
                            AuthManager.saveRoles(roles);
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => MainHomePage()),
                            );
                          } else if (value.statusCode == 402) {
                            setState(() {
                              emailError = 'هذا ليس البريد الالكتروني الصحيح';
                            });
                          } else if (value.statusCode == 422) {
                            setState(() {
                              passwordError =
                                  'تأكد من البريد الالكتروني او كلمة المرور';
                            });
                          } else {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) {
                                return AlertDialog(
                                  title: Text('خطأ'),
                                  content: Text('حدث خطأ غير متوقع'),
                                  actions: [
                                    ElevatedButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      child: Text('حسنا'),
                                    ),
                                  ],
                                );
                              },
                            );
                          }
                        });
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      minimumSize: Size(double.infinity, 50),
                    ),
                    child: Text('تسجيل دخول',
                        style: TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 0,
            child: Image.asset('assets/browncorner.png', width: 100),
          ),
        ],
      ),
    );
  }

  Widget inputFile({label, obscureText = false, controller, error}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          label,
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          textAlign: TextAlign.right,
          onChanged: (value) {
            if (label == 'البريد الالكتروني') {
              setState(() {
                userEmail = value;
              });
            } else if (label == 'كلمة المرور') {
              setState(() {
                userPassword = value;
              });
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
            errorText: error,
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
