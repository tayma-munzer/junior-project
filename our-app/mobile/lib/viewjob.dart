import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';

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

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchjobdetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Job Name: ${jobdetails!['j_name']}'),
          Text('Job Description: ${jobdetails!['j_desc']}'),
          Text('Job Salary: ${jobdetails!['j_sal']} SAR'),
          Text('Job Requirements: ${jobdetails!['j_req']}'),
        ],
      ),
    );
  }
}
