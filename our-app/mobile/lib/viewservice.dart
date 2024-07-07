import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editjob.dart';
import 'package:mobile/firstpage.dart';
import 'package:mobile/main.dart';

class viewservice extends StatefulWidget {
  final int s_id;
  const viewservice(this.s_id, {Key? key}) : super(key: key);

  @override
  State<viewservice> createState() => _viewserviceState();
}

Map<String, dynamic>? servicedetails;
String? image;

class _viewserviceState extends State<viewservice> {
  void fetchservice() async {
    var url = get_service;
    var res =
        await http.post(Uri.parse(url), body: {"s_id": widget.s_id.toString()});
    setState(() {
      servicedetails = json.decode(res.body);
      image = servicedetails!['image'];
      print(servicedetails);
      print(image);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchservice();
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
            SizedBox(height: 20),
            Image.memory(
              base64Decode(servicedetails!['image']),
              height: 300,
            ),
            SizedBox(height: 50),
            Text(
              ' اسم الخدمة: ${servicedetails!['s_name']}  ',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text(
              ' التوصيف الخدمة :${servicedetails!['s_desc']} ',
              style: TextStyle(fontSize: 20),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 10),
            Text('${servicedetails!['s_price']} : سعر الخدمة  ',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(' ${servicedetails!['num_of_buyers']} :  عدد المشترين',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('  مدة الخدمة : ${servicedetails!['s_duration']} ',
                style: TextStyle(fontSize: 20)),
            Text(' ${servicedetails!['discount']} :   قيمة الخصم',
                style: TextStyle(fontSize: 20)),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
