import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/icon_circles.dart';
import 'package:mobile/secondaryCategory.dart';

class services_types extends StatefulWidget {
  const services_types({Key? key}) : super(key: key);

  @override
  State<services_types> createState() => _services_typesState();
}

class _services_typesState extends State<services_types> {
  bool isLoading = true;
  bool hasError = false;
  List data = [];

  void fetch() async {
    try {
      var url = services_first_type;
      var res = await http.get(
        Uri.parse(url),
      );
      setState(() {
        data = json.decode(res.body);
        isLoading = false;
      });
    } catch (error) {
      setState(() {
        hasError = true;
        isLoading = false;
      });
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('تنبيه'),
            content: Text('حصل خطأ ما حاول لاحقا'),
            actions: [
              TextButton(
                child: Text('تم'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

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
            SizedBox(height: 30),
            GridView.builder(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / 1.8),
              ),
              itemCount: data.length,
              itemBuilder: (BuildContext context, int index) {
                if (data.isEmpty) {
                  return Center(
                    child: Text('No items to show'),
                  );
                }
                return buildCircleItem(context, index);
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  CircleItem buildCircleItem(BuildContext context, int index) {
    return CircleItem(
      data: data[index],
      onTap: () {
        Navigator.pop(context); // Close the drawer
        final int id = int.parse(data[index]["t_id"].toString());
        final String title = data[index]["type"].toString();
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => SecondaryCategories(id, title),
          ),
        );
      },
      iconKey: "t_icon",
      title: data[index]["type"],

    );
  }
}
