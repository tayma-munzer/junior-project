import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class projectedit extends StatefulWidget {
  final int p_id;
  const projectedit(this.p_id, {Key? key}) : super(key: key);

  @override
  State<projectedit> createState() => _projecteditState();
}

class _projecteditState extends State<projectedit> {
  void fetch() async {
    var url = get_project;
    var res =
        await http.post(Uri.parse(url), body: {'p_id': widget.p_id.toString()});
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
