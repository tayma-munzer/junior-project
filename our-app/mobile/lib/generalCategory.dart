import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/CategoriesDetails.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/buildCatItem.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';

class Categories extends StatefulWidget {
  final int st_id;

  const Categories(this.st_id);

  @override
  State<Categories> createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  List<Map<String, dynamic>> data = [];
  Future<void> fetchData() async {
    var url = get_secondry_type_services;
    var response = await http
        .post(Uri.parse(url), body: {"st_id": widget.st_id.toString()});

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is Map<String, dynamic>) {
        setState(() {
          data = decodedData.values.toList().map((item) {
            return {
              "s_id": item["s_id"],
              "s_name": item["s_name"],
              "s_desc": item["s_desc"],
              "s_img": item["s_img"],
              "s_price": item["s_price"].toString(),
              "discount": item["discount"].toString(),
              "status": item["status"],
            };
          }).toList();
        });
      } else {
        print("Invalid response format: $decodedData");
      }
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: AppColors.appiconColor,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(33.0),
          child: CustomAppBar(),
        ),
        drawer: CustomDrawer(),
        body: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: data.length,
                itemBuilder: (BuildContext context, int index) {
                  return Padding(
                    padding: EdgeInsets.all(20.0),
                    child: _buildItemWidget(data[index]),
                  );
                },
              ),
            ],
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }

  Widget _buildItemWidget(dynamic item) {
    return GestureDetector(
      onTap: () {
        Navigator.pop(context); // Close the drawer
        final int id = int.parse(item["s_id"].toString());
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoriesDetails(id),
          ),
        );
      },
      child: BuildItem(
        item["s_name"],
        item["s_desc"],
        item["s_img"],
        item["s_price"],
        item["discount"],
        item["status"],
      ),
    );
  }
}
