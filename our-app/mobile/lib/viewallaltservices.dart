import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/addalternativeservice.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editaltservice.dart';
import 'package:mobile/viewaltservice.dart';

class viewallaltservices extends StatefulWidget {
  final int s_id;
  const viewallaltservices(this.s_id, {super.key});

  @override
  State<viewallaltservices> createState() => _viewallaltservicesState();
}

class _viewallaltservicesState extends State<viewallaltservices> {
  List? alt_service;

  void fetchallalt_service() async {
    var url = get_all_alt_services;
    var res =
        await http.post(Uri.parse(url), body: {"s_id": widget.s_id.toString()});
    if (res.statusCode == 200) {
      setState(() {
        alt_service = json.decode(res.body);
        print(alt_service);
      });
    } else {
      print("Failed to fetch data");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchallalt_service();
    alt_service = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Image.asset(
                'assets/viewaltservice.png',
                width: double.infinity,
                height: 200,
                fit: BoxFit.cover,
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemCount: alt_service == null ? 0 : alt_service!.length,
              itemBuilder: (context, index) {
                Color backgroundColor = index % 2 == 0
                    ? const Color.fromARGB(255, 154, 210, 255)
                    : Colors.white;

                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => viewaltservice(
                          alt_service![index]['a_id'],
                        ),
                      ),
                    );
                  },
                  child: Container(
                    color: backgroundColor,
                    child: ListTile(
                      leading: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () async {
                              var url = delete_alt_service;
                              var res = await http.post(Uri.parse(url), body: {
                                'a_id': alt_service![index]['a_id'].toString()
                              });
                              if (res.statusCode == 200) {
                                print('deleted successfully');
                                alt_service!.removeAt(index);
                              } else {
                                print(res.body);
                                print('something went wrong');
                              }
                            },
                          ),
                          IconButton(
                            icon: Icon(Icons.edit),
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => Editaltservice(
                                        alt_service![index]['a_id'])),
                              );
                            },
                          ),
                        ],
                      ),
                      title: Text(
                        alt_service![index]['a_name'],
                        textAlign: TextAlign.right,
                      ),
                    ),
                  ),
                );
              },
            ),
            alt_service == null || alt_service!.isEmpty
                ? Center(
                    child: Text("لا يوجد خدمات لاحقة لعرضها"),
                  )
                : SizedBox(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddAltService(widget.s_id),
            ),
          );
        },
        child: Icon(Icons.add),
        backgroundColor: Colors.blue,
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
