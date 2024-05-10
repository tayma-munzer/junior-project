import 'dart:convert';

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

class viewjob extends StatefulWidget {
  final int j_id;
  const viewjob(this.j_id, {Key? key}) : super(key: key);

  @override
  State<viewjob> createState() => _viewjobState();
}

Map<String, dynamic>? jobdetails;

class _viewjobState extends State<viewjob> {
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
            SizedBox(height: 20),
            Image.asset('assets/workingbag.png', width: 200),
            SizedBox(height: 50),
            Text('${jobdetails!['j_name']} : اسم الوظيفة',
                style: TextStyle(fontSize: 20)),
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
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditJob(widget.j_id)),
                          );
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                          minimumSize: MaterialStateProperty.all(Size(300, 40)),
                        ),
                        child:
                            Text('Edit', style: TextStyle(color: Colors.white)),
                      ),
                      SizedBox(height: 5),
                      ElevatedButton(
                        onPressed: () async {
                          var url = delete_job;
                          var res = await http.post(Uri.parse(url),
                              body: {'j_id': jobdetails!['j_id'].toString()});
                          if (res.statusCode == 200) {
                            print('deleted seccessfully');
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => FirstPage()),
                            );
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.red),
                          minimumSize: MaterialStateProperty.all(Size(300, 40)),
                        ),
                        child: Text('Delete',
                            style: TextStyle(color: Colors.white)),
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
