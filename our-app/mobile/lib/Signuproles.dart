import 'package:flutter/material.dart';
import 'package:mobile/homepage.dart';

class SignUpRolesPage extends StatefulWidget {
  const SignUpRolesPage({Key? key}) : super(key: key);

  @override
  State<SignUpRolesPage> createState() => _SignUpRolesPageState();
}

class _SignUpRolesPageState extends State<SignUpRolesPage> {
  List<String> selectedRoles = [];

  void _selectRole(String role) {
    setState(() {
      if (selectedRoles.contains(role)) {
        selectedRoles.remove(role);
      } else {
        selectedRoles.add(role);
      }
    });
  }

  void _confirmRoles() {
    if (selectedRoles.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('يجب ان تختار واحدة من الصلاحيات على الاقل')));
    } else {
      print(selectedRoles);
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => MainHomePage()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'اختر صلاحياتك',
                  style: TextStyle(fontSize: 25),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _selectRole('صاحب خدمة'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (selectedRoles.contains('صاحب خدمة')) {
                        return Color.fromARGB(255, 243, 176, 145);
                      }
                      return const Color.fromARGB(255, 152, 209, 255);
                    }),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 60)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'صاحب خدمة',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectRole('مستفيد'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (selectedRoles.contains('مستفيد')) {
                        return Color.fromARGB(255, 243, 176, 145);
                      }
                      return const Color.fromARGB(255, 152, 209, 255);
                    }),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 60)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.shopping_cart, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'مستفيد',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () => _selectRole('باحث عن عمل'),
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.resolveWith<Color>(
                        (Set<MaterialState> states) {
                      if (selectedRoles.contains('باحث عن عمل')) {
                        return Color.fromARGB(255, 243, 176, 145);
                      }
                      return const Color.fromARGB(255, 152, 209, 255);
                    }),
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 60)),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.work, color: Colors.white),
                      SizedBox(width: 10),
                      Text(
                        'باحث عن عمل',
                        style: TextStyle(
                          fontSize: 22,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: _confirmRoles,
                  style: ButtonStyle(
                    minimumSize:
                        MaterialStateProperty.all(Size(double.infinity, 60)),
                  ),
                  child: Text('تأكيد'),
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/toppinkcorner.png', width: 300),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/bluecorner.png', width: 300),
          ),
        ],
      ),
    );
  }
}
