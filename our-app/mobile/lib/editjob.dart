import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';

class EditJob extends StatefulWidget {
  final int j_id;
  const EditJob({required this.j_id, Key? key}) : super(key: key);

  @override
  State<EditJob> createState() => _EditJobState();
}

Map<String, dynamic>? jobdetails;

class _EditJobState extends State<EditJob> {
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
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(height: 50),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '${jobdetails!['j_name']} : اسم الوظيفة',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '${jobdetails!['j_desc']} : وصف الوظيفة',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: 'SAR ${jobdetails!['j_sal']} : الراتب',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Row(
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 10),
                      TextField(
                        decoration: InputDecoration(
                          hintText: '${jobdetails!['j_req']} : متطلبات الوظيفة',
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
