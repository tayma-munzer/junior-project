import 'package:flutter/material.dart';
import 'package:get/get.dart';
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
  List skills = [];

  void fetch() async {
    String? token = await AuthManager.getToken();
    var url = get_all_cv;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    mainInfo = data['cv'];
    // if (data['skills'] != null && data['skills'] is List) {
    skills = data['skills'];
    // }

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
                      ],
                    ),
                  ),
                ],
              ),
              Text(
                'Skills',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  if (skills.isEmpty)
                    Text('No skills to be displayed')
                  else
                    for (var skill in skills)
                      Text(
                          '${skill['s_name']}  : اسم المهارة\n ${skill['years_of_exp']} :عدد سنين الخبرة  \n${skill['s_level']} : مستوى المهارة   '),
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
