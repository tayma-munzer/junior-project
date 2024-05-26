import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';

class viewjobtobuy extends StatefulWidget {
  final int j_id;
  const viewjobtobuy(this.j_id, {Key? key}) : super(key: key);

  @override
  State<viewjobtobuy> createState() => _viewjobtobuyState();
}

Map<String, dynamic>? jobdetails;

class _viewjobtobuyState extends State<viewjobtobuy> {
  void fetchjobdetails() async {
    var url = get_job;
    var res =
        await http.post(Uri.parse(url), body: {"j_id": widget.j_id.toString()});
    setState(() {
      jobdetails = json.decode(res.body);
      print(jobdetails);
    });
  }

  String? enable;

  List<dynamic> jobs = [];
  void fetchJobs() async {
    var url = get_user_jobs;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print(jobs);
      for (var job in jobs) {
        if (job['j_id'] == jobdetails!['j_id']) {
          enable = 'true';
        }
      }
    });
  }

  @override
  void initState() {
    super.initState();
    fetchjobdetails();
    fetchJobs();
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
            Image.asset('assets/getjob.png', width: 350),
            SizedBox(height: 25),
            Text(
              '${jobdetails!['j_name']} : اسم الوظيفة',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 10),
            Text(' ${jobdetails!['j_desc']} : التوصيف الوظيفة',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text('${jobdetails!['j_sal']} :الراتب(بالليرة السورية)  ',
                style: TextStyle(fontSize: 20)),
            SizedBox(height: 10),
            Text(' ${jobdetails!['j_req']} : متطلبات الوظيفة',
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
