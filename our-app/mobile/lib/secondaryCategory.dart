import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/generalCategory.dart';

class SecondaryCategories extends StatefulWidget {
  final int t_id;
  final String sec_type;

  SecondaryCategories(this.t_id, this.sec_type);

  @override
  State<SecondaryCategories> createState() => _SecondaryCategoriesState();
}

class _SecondaryCategoriesState extends State<SecondaryCategories> {
  List data = [];

  void fetch() async {
    var url = services_second_type;
    var res =
        await http.post(Uri.parse(url), body: {"t_id": widget.t_id.toString()});
    setState(() {
      List<dynamic> fetchedData = json.decode(res.body);
      data = fetchedData.map((item) {
        return {
          "st_id": item["st_id"],
          "sec_type": item["sec_type"],
        };
      }).toList();
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Container(
      color: AppColors.appiconColor,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(33.0),
          child: CustomAppBar(),
        ),
        drawer: CustomDrawer(),
        body: Padding(
          padding: EdgeInsets.all(40.0),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount:
                  screenWidth ~/ 300, // Adjust the width based on screen size
              crossAxisSpacing: 20,
              mainAxisSpacing: 20,
              childAspectRatio: screenWidth /
                  (300 *
                      0.4), // Calculate the aspect ratio based on screen width and desired height
            ),
            itemCount: data.length,
            itemBuilder: (BuildContext context, int index) {
              if (data.isEmpty) {
                return Center(
                  child: Text('No items to show'),
                );
              }
              return _buildCategoryWidget(data[index]);
            },
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }

  Widget _buildCategoryWidget(dynamic category) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the drawer
        final int id = int.parse(category["st_id"].toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Categories(id),
          ),
        );
      },
      child: Container(
        padding: EdgeInsets.all(15.0),
        decoration: BoxDecoration(
          color: AppColors.appColor,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Text(
                category["sec_type"],
                style: TextStyle(
                  color: AppColors.appiconColor,
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
