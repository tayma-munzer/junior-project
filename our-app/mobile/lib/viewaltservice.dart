import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class viewaltservice extends StatefulWidget {
  final int a_id;
  const viewaltservice(this.a_id, {Key? key});

  @override
  State<viewaltservice> createState() => _viewaltserviceState();
}

class _viewaltserviceState extends State<viewaltservice> {
  Map<String, dynamic>? alt_service;
  void fetchalt_service() async {
    var url = get_alt_service;
    var res =
        await http.post(Uri.parse(url), body: {"a_id": widget.a_id.toString()});
    setState(() {
      alt_service = json.decode(res.body);
      print(alt_service);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchalt_service();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 70),
            Image.asset('assets/altserviceview.png', width: 300, height: 200),
            SizedBox(height: 40),
            Text('${alt_service!['a_name']} :  اسم الخدمة اللاحقة  ',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('  سعر الخدمة اللاحقة :${alt_service!['a_price']}  ',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('  المدة المضافة: ${alt_service!['added_duration']} ',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 20),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
