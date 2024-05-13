import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class editexp extends StatefulWidget {
  final int exp_id;
  const editexp(this.exp_id, {Key? key}) : super(key: key);

  @override
  State<editexp> createState() => _editexpState();
}

class _editexpState extends State<editexp> {
  void fetch() async {
    var url = get_exp;
    var res = await http
        .post(Uri.parse(url), body: {'exp_id': widget.exp_id.toString()});
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
