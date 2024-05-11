import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class editskill extends StatefulWidget {
  final int s_id;
  const editskill(this.s_id, {Key? key}) : super(key: key);
  @override
  State<editskill> createState() => _editskillState();
}

class _editskillState extends State<editskill> {
  void fetch() async {
    var url = get_skill;
    var res =
        await http.post(Uri.parse(url), body: {'s_id': widget.s_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    print(data);
    print(data['s_level']);
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
