import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/readcourse.dart';
import 'dart:convert';

import 'appbar.dart';
import 'bottombar.dart';
import 'controller/authManager.dart';
import 'drawer.dart';

class ViewServices2 extends StatefulWidget {
  @override
  _ViewServices2State createState() => _ViewServices2State();
}

class _ViewServices2State extends State<ViewServices2> {
  List<dynamic> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices2();
  }


  void fetchServices2() async {
    var url = 'http://10.0.2.2:8000/api/get_my_services_enrollments';
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    dynamic data = json.decode(res.body);
    print(data); // Print the API response

    if (data != null) {
      if (data is List) {
        // Handle response as a list of services
        setState(() {
          services = data;
        });
      } else if (data is Map && data.containsKey('services')) {
        // Handle response as a map with a 'services' field
        setState(() {
          services = data['services'];
        });
      } else {
        print('Invalid API response');
      }
    } else {
      print('Empty API response');
    }

    print(services);
    print(res.body);
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: ListView.builder(
          itemCount: services.length,
          itemBuilder: (BuildContext context, int index) {
            var service = services[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => CourseDetailsPage( service['s_id']),
                  ),
                );
              },
              child: Card(
                elevation: 2.0,
                margin: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                child: ListTile(
                  title: Text(
                    service['s_name'],
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

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
