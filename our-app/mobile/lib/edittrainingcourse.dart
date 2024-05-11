import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class edittrainingcourse extends StatefulWidget {
  final int t_id;
  const edittrainingcourse(this.t_id, {Key? key}) : super(key: key);
  @override
  State<edittrainingcourse> createState() => _edittrainingcourseState();
}

class _edittrainingcourseState extends State<edittrainingcourse> {
  void fetch() async {
    var url = get_training_course;
    var res =
        await http.post(Uri.parse(url), body: {'t_id': widget.t_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    print(data);
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
