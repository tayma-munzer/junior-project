import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/ItemDetails.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/buy.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';

class CategoriesDetails extends StatefulWidget {
  final int s_id;

  const CategoriesDetails(this.s_id, {Key? key}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  List<Map<String, dynamic>> data = [];

  Future<void> fetchData() async {
    var url = get_service;
    var response = await http.post(Uri.parse(url), body: {
      "s_id": widget.s_id.toString(),
    });

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      print(decodedData);
      // if (decodedData is List<dynamic>) {
      //   setState(() {
      //     data = decodedData.map((item) {
      //       return {
      //         "s_id": item["s_id"],
      //         "s_name": item["s_name"],
      //         "s_desc": item["s_desc"],
      //         "s_price": item["s_price"].toString(),
      //         "num_of_buyers": item["num_of_buyers"].toString(),
      //         "s_duration": item["s_duration"],
      //         "discount": item["discount"].toString(),
      //         "status": item["status"],
      //         "s_img": item["s_img"],
      //       };
      //     }).toList();
      //   });
      // } else {
      //   print("Invalid response format: $decodedData");
      // }
    } else {
      print("Request failed with status: ${response.body}");
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
          child: Padding(
            padding: EdgeInsets.all(20.0),
            child: Column(
              children: [
                ...data.map((item) {
                  return _buildItemWidget(item);
                }).toList(),
                _buildBuyButton(),
              ],
            ),
          ),
        ),
        bottomNavigationBar: BottomBar(),
      ),
    );
  }

  Widget _buildItemWidget(Map<String, dynamic> item) {
    return ItemDetails(
      image: item["image"],
      serviceTitle: item["s_name"],
      description: item["s_desc"],
      price: item["s_price"],
      duration: item["s_duration"],
      numberOfBuyers: item["num_of_buyers"],
      status: item["status"],
      discount: item["discount"],
    );
  }

  Widget _buildBuyButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: TextButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => BuyPage(widget.s_id),
            ),
          );
        },
        child: Text(
          'اشتري',
          style: TextStyle(
            fontSize: 18.0,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
          padding: MaterialStateProperty.all<EdgeInsets>(
            EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
          ),
        ),
      ),
    );
  }
}
