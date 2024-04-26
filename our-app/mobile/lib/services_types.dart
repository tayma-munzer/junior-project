// ignore_for_file: unused_import

import 'dart:convert';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:string_2_icon/string_2_icon.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class services_types extends StatefulWidget {
  const services_types({Key? key}) : super(key: key);

  @override
  State<services_types> createState() => _services_typesState();
}

class _services_typesState extends State<services_types> {
  List data = [];
  void fetch() async {
    var url = services_first_type;
    var res = await http.post(Uri.parse(url));
    setState(() {
      data = json.decode(res.body);
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: ListView.separated(
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data.isEmpty) {
            return Center(
              child: Text('List is empty'),
            );
          }
          return ListTile(
            title: Text(data[index]['type'].toString()),
            tileColor: const Color.fromARGB(255, 182, 157, 125),
            onTap: () {},
            trailing:
                Icon(String2Icon.getIconDataFromString(data[index]["t_icon"])),
          );
        },
        separatorBuilder: (BuildContext context, int index) => const Divider(),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
