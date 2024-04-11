import 'package:flutter/material.dart';
import 'package:flutter/gestures.dart';
import 'package:mobile/firstpage.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String userEmail = '';
  String userPassword = '';

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
                ),
                inputFile(
                  label: 'كلمة المرور',
                  obscureText: true,
                  controller: passwordController,
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
                                    builder: (context) => FirstPage()),
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
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (context) => FirstPage()),
                      );
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

  Widget inputFile({label, obscureText = false, controller}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: <Widget>[
        Text(
          label,
          // Add your desired text style
        ),
        SizedBox(height: 5),
        TextField(
          controller: controller,
          obscureText: obscureText,
          textAlign: TextAlign.right,
          onChanged: (value) {
            if (label == 'البريد الالكتروني') {
              userEmail = value;
            } else if (label == 'كلمة المرور') {
              userPassword = value;
            }
          },
          decoration: InputDecoration(
            contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 10),
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.grey),
            ),
            border:
                OutlineInputBorder(borderSide: BorderSide(color: Colors.grey)),
          ),
        ),
        SizedBox(height: 10),
      ],
    );
  }
}
