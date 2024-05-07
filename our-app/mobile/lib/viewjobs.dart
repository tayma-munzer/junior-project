import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/buildCatItem.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/viewjob.dart';

class viewjobs extends StatefulWidget {
  const viewjobs({super.key});

  @override
  State<viewjobs> createState() => _viewjobsState();
}

List<dynamic> jobs = [];

class _viewjobsState extends State<viewjobs> {
  void fetchjobs() async {
    var url = get_all_jobs;
    var res = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print('object');
      print(jobs);
      //selectedSecondaryCategory = sec_type[0]['sec_type'];
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchjobs();
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
            return ListTile(
              title: Text(job['j_name']),
              subtitle: Text(job['j_desc']),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => viewjob(job['j_id'])),
                );
              },
            );
          }),
      // Container(
      //   child: Text("heloooooooooooooooo"),
      // ),
    );
  }
}
