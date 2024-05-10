import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editcv.dart';

class viewcv extends StatefulWidget {
  const viewcv({Key? key}) : super(key: key);

  @override
  State<viewcv> createState() => _viewcvState();
}

class _viewcvState extends State<viewcv> {
  Map<String, dynamic> mainInfo = {};

  void fetch() async {
    String? token = await AuthManager.getToken();
    var url = get_all_cv;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    List skills = data['skills'];
    mainInfo = data['cv'];
    List training_courses = data['training_courses'];
    List exp = data['experience'];
    List projects = data['projects'];
    List education = data['education'];
    List languages = data['languages'];
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
          padding: EdgeInsets.only(right: 10.0),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          width: 20,
                          height: 30,
                        ),
                        Text(
                          'Main Info',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          '${mainInfo['email']} :بريد الكتروني ',
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          ' ${mainInfo['phone']} : رقم الهاتف  ',
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          ' ${mainInfo['address']} : العنوان  ',
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          ' ${mainInfo['career_obj']} : الهدف الوظيفي  ',
                          textAlign: TextAlign.right,
                        ),
                        // Add more details as needed
                      ],
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => editcv()),
                  );
                },
                child: Text('Next Edit'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
