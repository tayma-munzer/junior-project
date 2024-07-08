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
import 'package:mobile/serviceComplaint.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/services_types.dart';
import 'package:mobile/viewallaltservices.dart';
import 'package:mobile/viewworkgallery.dart';
import 'controller/authManager.dart';
import 'editService.dart';

class CategoriesDetails extends StatefulWidget {
  final int s_id;

  const CategoriesDetails(this.s_id, {Key? key}) : super(key: key);

  @override
  State<CategoriesDetails> createState() => _CategoriesDetailsState();
}

class _CategoriesDetailsState extends State<CategoriesDetails> {
  List<Map<String, dynamic>> data = [];
  String? token;
  Future<void> fetchData() async {
    token = await AuthManager.getToken();
    var url = get_service;
    var response = await http.post(Uri.parse(url), body: {
      "s_id": widget.s_id.toString(),
    });
    print("object");
    print(response.body);
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

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
              "rate": decodedData["rate"].toString(),
            }
          ];
        });
      } else {
        print("Invalid response format: $decodedData");
      }
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  String? user;
  String? job;
  String? service;

  Future<void> fetchRoles() async {
    String? userRole = await AuthManager.isUser();
    String? jobRole = await AuthManager.isjobOwner();
    String? serviceRole = await AuthManager.isserviceOwner();
    setState(() {
      this.user = userRole;
      this.job = jobRole;
      this.service = serviceRole;
    });
  }

  bool isEnrolled = false;

  Future<void> fetchIsEnrolled() async {
    var url =
        'http://10.0.2.2:8000/api/is_user_service_enrolled'; // Replace with your API URL
    String? token = await AuthManager.getToken();

    var response = await http.post(
      Uri.parse(url),
      body: {'token': token, 's_id': widget.s_id.toString()},
    );

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      var enrolledValue = decodedData["enrolled"];
      isEnrolled = enrolledValue == "true";
      setState(() {}); // Notify the widget to rebuild with the updated value
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  String isOwner = "";

  Future<void> fetchIsOwner() async {
    String? token = await AuthManager.getToken();
    var url = is_service_owner;


    var response = await http.post(Uri.parse(url), body: {
      's_id': widget.s_id.toString(), // Convert the integer to a string
      'token': token!,
    });

    print(response.body);
    setState(() {
      isOwner = response.body; // Assign the value to isOwner
    });
    print("object");
    print(isOwner);
  }

  Future<void> deleteService(dynamic service) async {
    var url = delete_service;
    var response = await http.post(Uri.parse(url), body: {
      "s_id": service['s_id'].toString(), // Convert s_id to a string
    });

    if (response.statusCode == 200) {
      // Service deleted successfully
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => services_types()),
      );
    } else {
      print("Delete request failed with status: ${response.statusCode}");
    }
  }

  Future<void> confirmDeleteService(dynamic service) async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text("تأكيد عملية الحذف"),
            content: Text("هل أنت متأكد أنك تريد حذف هذه الخدمة؟"),
            actions: [
              TextButton(
                child: Text("إلغاء"),
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
              ),
              TextButton(
                child: Text("تأكيد"),
                onPressed: () {
                  deleteService(service);
                  Navigator.pop(context); // Close the dialog
                },
              ),
            ],
          ),
        );
      },
    );
  }

  @override
  void initState() {
    super.initState();
    fetchIsEnrolled();
    fetchIsOwner();
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
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            ' هل تريد رؤية اعمال تابعة لهذه الخدمة؟',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    print("work");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => viewworkgallery(widget.s_id),
                      ),
                    );
                  },
                  child: Text(
                    ' اعرض معرض الاعمال',
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
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            '   هل تريد رؤية اعمال تابعة لهذه الخدمة؟',
            style: TextStyle(fontSize: 16),
          ),
          SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: TextButton(
                  onPressed: () {
                    print("altservices");
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => viewallaltservices(widget.s_id),
                      ),
                    );
                  },
                  child: Text(
                    ' الخدمات اللاحقة',
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
                      EdgeInsets.symmetric(horizontal: 40.0, vertical: 10.0),
                    ),
                  ),
                ),
              ),
            ],
          ),
          SizedBox(
            height: 16,
          ),
          TextButton(
            onPressed: () {
              AuthCont.service_enrollment(widget.s_id.toString()).then((value) {
                if (value.statusCode == 200) {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Directionality(
                        textDirection: TextDirection.rtl,
                        child: AlertDialog(
                          title: Text('نجاح'),
                          content: Text('تمت العملية بنجاح'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                Navigator.of(context).pop();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(builder: (context) => CategoriesDetails(widget.s_id)), // Replace `YourPage` with the actual page you want to reload
                                );
                              },
                              child: Text('موافق'),
                            ),
                          ],
                        ),
                      );
                    },
                  );
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
              backgroundColor: MaterialStateProperty.all<Color>(Colors.blue),
              padding: MaterialStateProperty.all<EdgeInsets>(
                EdgeInsets.symmetric(horizontal: 160.0, vertical: 10.0),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Visibility(
            visible: isEnrolled, // Show the button only if isEnrolled is true
            child: TextButton(
              onPressed: () async {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    String review = ''; // Variable to store the review text

                    return AlertDialog(
                      title: Directionality(
                        textDirection: TextDirection.rtl,
                        child: Text('أضف'),
                      ),
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
                              decoration: InputDecoration(
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
                          onPressed: () async {

                            double rating = RatingWidget2.getRating();
                            String ratingAsString = rating.toString();
                            // Prepare the request body
                            Map<String, dynamic> requestBody = {
                              'token': token,
                              'rate': ratingAsString,
                              'review': review,
                              'service_id': widget.s_id.toString(),
                            };

                            // Make the HTTP POST request
                            var response = await http.post(
                              Uri.parse('http://10.0.2.2:8000/api/add_service_rating'),
                              body: requestBody,
                            );

                            if (response.statusCode == 200) {
                              // Rating added successfully
                              print('Rating added successfully');
                            } else if (response.statusCode == 402) {
                              // Validation failed, handle the errors
                              var errors = response.body;
                              print('Validation errors: $errors');
                            } else {
                              // Handle other error cases
                              print('Error: ${response.statusCode}');
                            }

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
                  EdgeInsets.symmetric(horizontal: 140.0, vertical: 10.0),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 16,
          ),
          Visibility(
            visible: isEnrolled,
            child: TextButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ComplaintPage(
                      sId: widget.s_id.toString(),
                    ),
                  ),
                );
              },
              child: Text(
                'أضف شكوى',
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
              style: ButtonStyle(
                backgroundColor: WidgetStateProperty.all<Color>(Colors.blue),
                padding: WidgetStateProperty.all<EdgeInsets>(
                  EdgeInsets.symmetric(horizontal: 140.0, vertical: 10.0),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          // Updated condition
          Visibility(
            visible: isOwner ==
                'true', // Assuming 'true' is the expected value for isOwner
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => EditService(widget.s_id),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    minimumSize: Size(150, 40),
                  ),
                  child: Text(
                    'تعديل ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.red,
                    minimumSize: Size(150, 40),
                  ),
                  child: Text(
                    'حذف ',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
