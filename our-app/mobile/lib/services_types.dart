import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/itCategory.dart';
import 'package:string_2_icon/string_2_icon.dart';

class services_types extends StatefulWidget {
  const services_types({Key? key}) : super(key: key);

  @override
  State<services_types> createState() => _services_typesState();
}

class _services_typesState extends State<services_types> {
  List data = [];

  void fetch() async {
    var url = services_first_type;
    var res = await http.get(Uri.parse(url));
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
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: MediaQuery.of(context).size.width /
              (MediaQuery.of(context).size.height / 2),
        ),
        itemCount: data.length,
        itemBuilder: (BuildContext context, int index) {
          if (data.isEmpty) {
            return Center(
              child: Text('List is empty'),
            );
          }
          return Padding(
            padding: EdgeInsets.all(8.0),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ITCategoryPage()),
                  );
                },
                splashColor: Colors.white.withOpacity(0.3),
                borderRadius: BorderRadius.circular(20),
                child: Container(
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: AppColors.appColor,
                  ),
                  child: Icon(
                    String2Icon.getIconDataFromString(data[index]["t_icon"]),
                    color: Colors.white,
                    size: MediaQuery.of(context).size.width / 6,
                  ),
                ),
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
