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

class viewallJobs extends StatefulWidget {
  const viewallJobs({Key? key});

  @override
  State<viewallJobs> createState() => _viewallJobsState();
}

List<dynamic> jobs = [];

class _viewallJobsState extends State<viewallJobs> {
  void fetchJobs() async {
    var url = get_all_jobs;
    var res = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print('object');
      print(jobs);
    });
  }

  @override
  void initState() {
    super.initState();
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
      body: ListView.builder(
          itemCount: jobs.length,
          itemBuilder: (context, index) {
            final job = jobs[index];
            Color backgroundColor = index % 2 == 0
                ? Color.fromARGB(255, 146, 206, 255)
                : Colors.white;
            return ListTile(
              title: Text(job['j_name']),
              subtitle: Text(job['j_desc']),
              tileColor: backgroundColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => viewjob(job['j_id'])),
                );
              },
            );
          }),
    );
  }
}
