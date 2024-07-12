import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/services_types.dart';
import 'dart:convert';

import 'CategoriesDetails.dart';
import 'appbar.dart';
import 'bottombar.dart';
import 'constant/links.dart';
import 'controller/authManager.dart';
import 'drawer.dart';
import 'editService.dart';

class ViewServices extends StatefulWidget {
  @override
  _ViewServicesState createState() => _ViewServicesState();
}

class _ViewServicesState extends State<ViewServices> {
  List<dynamic> services = [];

  @override
  void initState() {
    super.initState();
    fetchServices();
  }

  void fetchServices() async {
    var url = get_user_services; // Replace with your API URL
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});
    List<dynamic> data = json.decode(res.body);
    setState(() {
      services = data;
    });
    print(res.body);
  }

  Future<void> deleteService(dynamic service) async {
    var url = delete_service;
    var response = await http.post(Uri.parse(url), body: {
      "s_id": service['s_id'].toString(), // Convert s_id to a string
    });
    print(response.body);
    if (response.statusCode == 200) {
      // Service deleted successfully
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ViewServices()),
      );
    } else {
      print("Delete request failed with status: ${response.statusCode}");
    }
  }

  Future<void> confirmDeleteService(dynamic service) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text("تأكيد عملية الحذف"),
            content: Text("هل أنت متأكد أنك تريد حذف هذه الخدمة؟"),
            actions: [
              TextButton(
                child: Text("إلغاء"),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
              TextButton(
                child: Text("تأكيد"),
                onPressed: () {
                  deleteService(service);
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
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
                    builder: (context) => CategoriesDetails(service['s_id']),
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
                  subtitle: Text(
                    service['s_desc'],
                    style: TextStyle(
                      fontSize: 14.0,
                    ),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EditService(
                                service['s_id'],
                              ),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          confirmDeleteService(service);
                        },
                      ),
                    ],
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
