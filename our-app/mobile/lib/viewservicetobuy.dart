import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/viewservice.dart';

class viewservicetobuy extends StatefulWidget {
  final int s_id;
  const viewservicetobuy(this.s_id, {Key? key}) : super(key: key);

  @override
  State<viewservicetobuy> createState() => _viewservicetobuyState();
}

Map<String, dynamic>? servicedetails;

class _viewservicetobuyState extends State<viewservicetobuy> {
  void fetchservicedetails() async {
    var url = get_service;
    var res =
        await http.post(Uri.parse(url), body: {"s_id": widget.s_id.toString()});
    setState(() {
      servicedetails = json.decode(res.body);
      print(servicedetails);
    });
  }

  String? enable;

  List<dynamic> services = [];
  void fetchservice() async {
    var url = get_user_jobs;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      services = data.map((item) => item).toList();
      print(services);
      for (var service in services) {
        if (service['s_id'] == servicedetails!['s_id']) {
          enable = 'true';
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchservicedetails();
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
            SizedBox(height: 25),
            Image.asset('assets/getservice.png', width: 300),
            SizedBox(height: 25),
            Text(
              '${servicedetails!['s_name']} : اسم الخدمة',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(' ${servicedetails!['s_desc']} : التوصيف الخدمة',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('${servicedetails!['s_price']} : سعر الخدمة ',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(' ${servicedetails!['num_of_buyers']} : عدد المشترين ',
                style: TextStyle(fontSize: 20)),
            enable == 'true' ? SizedBox(height: 20) : Container(),
            enable == 'true'
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          minimumSize: MaterialStateProperty.all(Size(300, 40)),
                        ),
                        child: Text(
                          'شراء',
                          style: TextStyle(color: Colors.white, fontSize: 20),
                        ),
                      ),
                    ],
                  )
                : Container(),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
