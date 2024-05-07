import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/secondaryCategory.dart';
import 'package:string_2_icon/string_2_icon.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class services_types extends StatefulWidget {
  const services_types({Key? key}) : super(key: key);

  @override
  State<services_types> createState() => _services_typesState();
}

class _services_typesState extends State<services_types> {
  List data = [];
  final FlutterSecureStorage secureStorage = FlutterSecureStorage();

  void fetch(String token) async {
    var url = services_first_type;
    var res = await http.get(Uri.parse(url), headers: {
      'Authorization': 'Bearer $token',
    });
    setState(
      () {
        data = json.decode(res.body);
      },
    );
  }

  void getTokenAndFetchData() async {
    final String? token = await secureStorage.read(key: 'token');
    if (token != null) {
      print(token); // Print the token value
      fetch(token);
    } else {
      // Handle the case when the token is null
      print("Token is null");
    }
  }

  @override
  void initState() {
    super.initState();
    getTokenAndFetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Container(
        color: AppColors.appiconColor,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.only(top: 10),
            child: Column(
              children: [
                Text(
                  "الاقسام",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 30),
                ),
                SizedBox(height: 20),
                GridView.builder(
                  shrinkWrap: true,
                  physics: NeverScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 2),
                  ),
                  itemCount: data.length,
                  itemBuilder: (BuildContext context, int index) {
                    if (data.isEmpty) {
                      return Center(
                        child: Text('No items to show'),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () {
                            Navigator.pop(context); // Close the drawer
                            final int id =
                                int.parse(data[index]["t_id"].toString());
                            final String title =
                                data[index]["title"].toString();
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    SecondaryCategories(id, title),
                              ),
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
                              String2Icon.getIconDataFromString(
                                  data[index]["t_icon"]),
                              color: AppColors.appiconColor,
                              size: MediaQuery.of(context).size.width / 6,
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
