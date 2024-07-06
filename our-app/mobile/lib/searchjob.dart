import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/buildCatItem.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editjob.dart';
import 'package:mobile/viewjob.dart';
import 'package:mobile/editjob.dart';

class SearchJob extends StatefulWidget {
  const SearchJob({Key? key});

  @override
  State<SearchJob> createState() => _SearchJobState();
}

List jobs = [];

class _SearchJobState extends State<SearchJob> {
  void fetchJobs() async {
    var url = get_user_jobs;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print(jobs);
    });
  }

  String? user;
  String? job;
  String? service;

  Future fetchRoles() async {
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
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: GridView.builder(
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 5,
            mainAxisSpacing: 5,
          ),
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                // Navigate to ViewJob with the job details
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => viewjob(jobs[index]['j_id']),
                  ),
                );
              },
              child: CircleAvatar(
                radius: 50,
                backgroundColor: index % 2 == 0
                    ? Color.fromARGB(255, 146, 206, 255)
                    : Colors.white,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(jobs[index]['j_title']),
                    Text(jobs[index]['j_desc']),
                  ],
                ),
              ),
            );
          },
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
