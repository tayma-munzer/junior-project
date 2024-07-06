import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/ItemDetails.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/buy.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/rating.dart';

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

      if (decodedData is Map<String, dynamic>) {
        setState(() {
          data = [
            {
              "s_id": decodedData["s_id"],
              "s_name": decodedData["s_name"],
              "s_desc": decodedData["s_desc"],
              "s_price": decodedData["s_price"].toString(),
              "num_of_buyers": decodedData["num_of_buyers"].toString(),
              "s_duration": decodedData["s_duration"],
              "discount": decodedData["discount"].toString(),
              "status": decodedData["status"],
              "image": decodedData["image"],
              "rate":decodedData["rate"].toString(),
            }
          ];
        });
        print (data[0]["rate"]);
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
      rate: item["rate"],

    );
  }

  Widget _buildBuyButton() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 20.0),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    print("chatting");
                    // Navigator.push(
                    //   context,
                    //   MaterialPageRoute(
                    //     builder: (context) => BuyPage(widget.s_id),
                    //   ),
                    // );
                  },
                  child: Text(
                    'تواصل',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    AuthCont.service_enrollment(widget.s_id.toString())
                        .then((value) {
                      if (value.statusCode == 200) {
                        print("enroll request have been sent");
                      } else {
                        print("error");
                      }
                    });
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
                    backgroundColor:
                        WidgetStateProperty.all<Color>(Colors.blue),
                    padding: WidgetStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 15.0),
                    ),
                  ),
                ),
              ),
              SizedBox(width: 5,),
    Expanded(
    child: TextButton(
    onPressed: () {
    showDialog(
    context: context,
    builder: (BuildContext context) {
    String review = ''; // Variable to store the review text

    return AlertDialog(
    title: Directionality(textDirection: TextDirection.rtl,
    child: Text('أضف')),
    content: Column(
    mainAxisSize: MainAxisSize.min,
    children: [
    RatingWidget2(),
    SizedBox(height: 16.0),
    Directionality(
      textDirection: TextDirection.rtl,
      child: TextField(
      onChanged: (value) {
      review = value; // Update the review text
      },
      decoration:
      InputDecoration(
      labelText: 'شاركنا رأيك',
      border: OutlineInputBorder(),
      ),
      textAlign: TextAlign.right, // Set the text alignment to right-to-left
      ),
    ),
    ],
    ),
    actions: [
    TextButton(
    onPressed: () {
    print('Rating: ${RatingWidget2.getRating()}');
    print('Review: $review');
    Navigator.of(context).pop();
    },
    child: Text('تم'),
    ),
    TextButton(
    onPressed: () {
    Navigator.of(context).pop();
    },
    child: Text('إلغاء'),
    ),
    ],
    );
    },
    );
    },
    child: Text(
    'أضف تقييمك',
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
    ),
            ],
          ),
        ],
      ),
    );
  }
}
