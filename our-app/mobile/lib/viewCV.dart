import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class viewcv extends StatefulWidget {
  final int cv_id;
  const viewcv(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<viewcv> createState() => _viewcvState();
}

class _viewcvState extends State<viewcv> {
  void fetch() async {
    String? token = await AuthManager.getToken();
    print('object');
    var url = get_all_cv;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    List skills = data['skills'];
    Map<String, dynamic> main_info = data['cv'];
    List training_courses = data['training_courses'];
    List exp = data['experience'];
    List projects = data['projects'];
    List education = data['education'];
    List languages = data['languages'];
    print(main_info);
    print(skills);
    print(training_courses);
    print(exp);
    print(projects);
    print(education);
    print(languages);
    setState(() {});
  }

  @override
  void initState() {
    // TODO: implement initState
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
      body: Container(
          //قواعد و شروط التطبيق
          ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
