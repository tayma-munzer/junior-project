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
import 'package:mobile/viewservice.dart';

class ViewUserServices extends StatefulWidget {
  const ViewUserServices({Key? key});

  @override
  State<ViewUserServices> createState() => _ViewUserServicesState();
}

List<dynamic> services = [];

class _ViewUserServicesState extends State<ViewUserServices> {
  void fetchServices() async {
    var url = get_user_services;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      services = data.map((item) => item).toList();
      print(services);
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

  void deleteService(int s_id) async {
    var url = delete_servicee;
    var res = await http.post(Uri.parse(url), body: {'s_id': s_id});
    fetchServices();
  }

  @override
  void initState() {
    super.initState();
    fetchServices();
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
      body: ListView.builder(
          itemCount: services.length,
          itemBuilder: (context, index) {
            final service = services[index];
            Color backgroundColor = index % 2 == 0
                ? Color.fromARGB(255, 146, 206, 255)
                : Colors.white;
            return ListTile(
              title: Text(service['s_name']),
              subtitle: Text(service['s_desc']),
              tileColor: backgroundColor,
              trailing: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      // Navigator.push(
                      //   context,
                      //   MaterialPageRoute(
                      //       builder: (context) => (job['j_id'])),
                      // );
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete),
                    onPressed: () async {
                      var url = delete_service;
                      var res = await http.post(Uri.parse(url),
                          body: {'s_id': service['s_id'].toString()});
                      if (res.statusCode == 200) {
                        fetchServices();
                        print('deleted seccessfully');
                      }
                    },
                  ),
                ],
              ),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => viewservice(service['s_id'])),
                );
              },
            );
          }),
    );
  }
}
