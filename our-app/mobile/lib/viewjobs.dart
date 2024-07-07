import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/addjob.dart';
import 'package:mobile/buildCatItem.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editjob.dart';
import 'package:mobile/viewjob.dart';

class ViewJobs extends StatefulWidget {
  const ViewJobs({Key? key});

  @override
  State<ViewJobs> createState() => _ViewJobsState();
}

List<dynamic> jobs = [];

class _ViewJobsState extends State<ViewJobs> {
  void fetchJobs() async {
    var url = get_user_jobs;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print(jobs);
    });
  }

  String? user;
  String? job;
  String? service;

  Future<void> fetchRoles() async {
    String? userRole = await AuthManager.isUser();
    String? jobRole = await AuthManager.isjobOwner();
    String? serviceRole = await AuthManager.isserviceOwner();
    setState(() {
      this.user = userRole;
      this.job = jobRole;
      this.service = serviceRole;
    });
  }

  void deleteJob(int j_id) async {
    var url = delete_job;
    var res = await http.post(Uri.parse(url), body: {'j_id': j_id});
    fetchJobs();
  }

  @override
  void initState() {
    super.initState();
    fetchJobs();
    fetchRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: jobs.isEmpty
          ? Center(
              child:
                  Text('لا يوجد اعمال لعرضها', style: TextStyle(fontSize: 20)),
            )
          : ListView.builder(
              itemCount: jobs.length,
              itemBuilder: (context, index) {
                final job = jobs[index];
                Color backgroundColor = index % 2 == 0
                    ? Color.fromARGB(255, 146, 206, 255)
                    : Colors.white;
                return ListTile(
                  leading: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => EditJob(job['j_id'])),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () async {
                          var url = delete_job;
                          var res = await http.post(Uri.parse(url),
                              body: {'j_id': job['j_id'].toString()});
                          if (res.statusCode == 200) {
                            fetchJobs();
                            print('deleted successfully');
                          }
                        },
                      ),
                    ],
                  ),
                  title: Text(
                    job['j_title'],
                    textAlign: TextAlign.right,
                  ),
                  subtitle: Text(
                    job['j_desc'],
                    textAlign: TextAlign.right,
                  ),
                  tileColor: backgroundColor,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewjob(job['j_id'])),
                    );
                  },
                );
              }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddjobPage()),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
