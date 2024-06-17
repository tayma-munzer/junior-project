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
  bool isLoading = true;
  bool hasError = false;
  List data = [];

  void fetch() async {
    try {
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
        body: Directionality(

          textDirection: TextDirection.rtl,
          child: Padding(
            padding: EdgeInsets.all(40.0),
             child: isLoading
              ? Center(
              child: CircularProgressIndicator(), // Show a loading indicator
                )
            : GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount:
                    screenWidth ~/ 300, // Adjust the width based on screen size
                crossAxisSpacing: 20,
                mainAxisSpacing: 40,
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
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Stack(
          children: [
            Positioned(
              top: 20,
              left: 10, // Updated position to the left side
              child: Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: Colors.blue,
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.arrow_forward,
                  color: Colors.white,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(25.0),
              child: Text(
                category["sec_type"],
                style: TextStyle(
                  color: Colors.blue,
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
