import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editCourse.dart';
import 'package:mobile/fatora.dart';
import 'package:mobile/listCourses.dart';
import 'package:mobile/rating.dart';
import 'package:mobile/videoWidget.dart';
import 'package:mobile/videoplayer.dart';
import 'package:mobile/view_media_new.dart';
import 'package:webview_flutter/webview_flutter.dart';

import 'CourseComplaints.dart';
import 'RatingStars.dart';
import 'controller/authManager.dart';

class CourseDetailsPage extends StatefulWidget {
  final int c_id;

  const CourseDetailsPage(this.c_id, {Key? key}) : super(key: key);

  @override
  _CourseDetailsPageState createState() => _CourseDetailsPageState();
}

class _CourseDetailsPageState extends State<CourseDetailsPage> {
  Map<String, dynamic> courseData = {};
  Map<String, dynamic>? videoData;
  bool isLoading = true;

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

  Future<void> fetchCourseData() async {
    var url = get_course_detils; // Replace with your API URL
    var response = await http.post(Uri.parse(url), body: {
      "c_id": widget.c_id.toString(),
    });

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      setState(() {
        courseData = {
          "c_id": decodedData["c_id"].toString(),
          "c_name": decodedData["c_name"],
          "c_desc": decodedData["c_desc"],
          "c_price": decodedData["c_price"].toString(),
          "image": decodedData["image"],
          "c_duration": decodedData["c_duration"].toString(),
          "pre_requisite": decodedData["pre_requisite"],
          "num_of_free_videos": decodedData["num_of_free_videos"].toString(),
          "rate": decodedData["rate"].toString(),
        };
      });
      print("hello rate");
      print(courseData["rate"]);
      fetchVideoData();
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  Future<void> fetchVideoData() async {
    var url = get_all_media;
    var response = await http.post(Uri.parse(url), body: {
      "c_id": courseData["c_id"].toString(),
    });

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is List<dynamic>) {
        setState(() {
          videoData = {
            for (var video in decodedData)
              video["m_id"].toString(): video["m_name"]
          };
          isLoading = false;
        });
      } else {
        print("Invalid response format: $decodedData");
      }
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
  }

  String? token;
  bool isEnrolled = false;
  Future<void> fetch_is_student() async {
    var url = is_user_course_enrolled;
    token = await AuthManager.getToken();
    print('object');
    print(token);
    print(widget.c_id);
    var response = await http.post(Uri.parse(url),
        body: {'token': token, 'c_id': widget.c_id.toString()});
    print("This is the response:");
    print(response.body);
    print(response.statusCode);
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);
      var enrolledValue = decodedData["enrolled"];
      isEnrolled = enrolledValue == "true";
    } else {
      print("Request failed with status: ${response.statusCode}");
    }
    print(isEnrolled);
  }

  String isOwner = "";

  Future<void> fetchIsOwner() async {
    String? token = await AuthManager.getToken();
    var url = is_course_owner;
    print("help me");
    print(widget.c_id);

    var response = await http.post(Uri.parse(url), body: {
      'c_id': widget.c_id.toString(), // Convert the integer to a string
      'token': token!,
    });

    print(response.body);
    setState(() {
      isOwner = response.body; // Assign the value to isOwner
    });
    print("object");
    print(isOwner);
  }

  Future<void> deleteCourse() async {
    var url = delete_course;
    var response = await http.post(Uri.parse(url), body: {
      "c_id": courseData["c_id"].toString(),
    });

    if (response.statusCode == 200) {
      // Course deleted successfully
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ListCourses()),
      );
    } else {
      print("Delete request failed with status: ${response.statusCode}");
    }
  }

  Future<void> confirmDeleteCourse() async {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text("تأكيد عملية الحذف"),
            content: Text("هل أنت متأكد أنك تريد حذف هذه الدورة التعليمية؟"),
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
                  deleteCourse();
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
    fetchCourseData();
    fetchRoles();
    fetch_is_student();
    fetchIsOwner();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      backgroundColor: AppColors.appiconColor,
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                SizedBox(
                  height: 8,
                ),
                SizedBox(height: 15),
                AnimatedOpacity(
                  opacity: isLoading ? 0.0 : 1.0,
                  duration: Duration(milliseconds: 500),
                  curve: Curves.easeIn,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Image.memory(
                      base64Decode(courseData["image"]),
                      height: 300,
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                SizedBox(height: 16),
                Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.orange.shade300,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Padding(
                        padding: EdgeInsets.all(2),
                        child: Row(
                          children: [
                            Icon(
                              Icons.check_circle_outline,
                              size: 20,
                              color: Colors.white,
                            ),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                courseData != null
                                    ? courseData["pre_requisite"].toString()
                                    : "لا يوجد متطلبات سابقة",
                                style: TextStyle(fontSize: 18),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  courseData != null
                                      ? courseData["c_name"].toString()
                                      : "",
                                  style: TextStyle(
                                    fontSize: 25,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                RatingStars(rate: courseData["rate"]),
                              ],
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.description,
                                  size: 20,
                                  color: Colors.blue,
                                ),
                                SizedBox(width: 8),
                                Expanded(
                                  child: Text(
                                    courseData != null
                                        ? courseData["c_desc"].toString()
                                        : "",
                                    style: TextStyle(fontSize: 18),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: 8),
                    Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                      child: Container(
                        padding: EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'التفاصيل:',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Row(
                              children: [
                                Icon(
                                  Icons.attach_money,
                                  size: 20,
                                  color: Colors.green,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'السعر:',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  courseData != null
                                      ? courseData["c_price"].toString()
                                      : "",
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'ل.س',
                                  style: TextStyle(
                                    fontSize: 18,
                                  ),
                                )
                              ],
                            ),
                            SizedBox(height: 16),
                            Row(
                              children: [
                                Icon(
                                  Icons.schedule,
                                  size: 20,
                                  color: Colors.orange,
                                ),
                                SizedBox(width: 8),
                                Text(
                                  'المدة:',
                                  style: TextStyle(fontSize: 18),
                                ),
                                SizedBox(width: 8),
                                Text(
                                  courseData != null
                                      ? courseData["c_duration"].toString()
                                      : "",
                                  style: TextStyle(fontSize: 18),
                                ),
                              ],
                            ),
                            SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 10),
                Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Container(
                    padding: EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          'محتوى الدورة',
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 16),
                        isLoading
                            ? Center(child: CircularProgressIndicator())
                            : videoData != null && videoData!.isNotEmpty
                                ? isLoading
                                    ? SizedBox(
                                        width: 24,
                                        height: 24,
                                        child: CircularProgressIndicator(),
                                      )
                                    : ListView.builder(
                                        shrinkWrap: true,
                                        physics: NeverScrollableScrollPhysics(),
                                        itemCount: isEnrolled
                                            ? videoData!.length
                                            : int.tryParse(courseData[
                                                        'num_of_free_videos']
                                                    .toString()) ??
                                                0,
                                        itemBuilder: (context, index) {
                                          var videoId =
                                              videoData!.keys.elementAt(index);
                                          var videoName = videoData![videoId];

                                          // Create an instance of the VideoWidget class
                                          VideoWidget videoWidget = VideoWidget(
                                            videoId: videoId,
                                            videoName: videoName,
                                            canEdit: false,
                                            onPressedDelete: () {
                                              // Handle onPressedDelete callback
                                            },
                                          );

                                          return GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                  builder: (context) =>
                                                      view_media_new(
                                                    videoId: videoId,
                                                    videoName: videoName,
                                                  ),
                                                ),
                                              );
                                            },
                                            child: videoWidget,
                                          );
                                        },
                                      )
                                : Text(
                                    'لا يوجد محتوى متاح حاليًا',
                                    style: TextStyle(fontSize: 18),
                                  ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Visibility(
                    visible: isOwner == "true",
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      EditCourse(widget.c_id)),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            minimumSize: Size(150, 40),
                          ),
                          child: Text('تعديل الدورة',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        ElevatedButton(
                          onPressed: () {
                            confirmDeleteCourse();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.red,
                            minimumSize: Size(150, 40),
                          ),
                          child: Text('حذف الدورة',
                              style:
                                  TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                      ],
                    )),
                SizedBox(
                  height: 20,
                ),
                user == 'true'
                    ? ElevatedButton(
                        onPressed: () async {
                          AuthCont.fatora().then((value) {
                            print(value.body);
                            final data = jsonDecode(value.body);
                            print(data['Data']['url']);
                            final url = data['Data']['url'];
                            final WebViewController controller =
                                WebViewController()
                                  ..setJavaScriptMode(
                                      JavaScriptMode.unrestricted)
                                  ..loadRequest(Uri.parse(url));
                            print("kokoko");
                            Navigator.push(
                              context,
                              MaterialPageRoute(builder: (context) => fatora()),
                            );
                          });

                          AuthCont.course_enrollment(widget.c_id.toString())
                              .then((value) {
                            final responseBody = jsonDecode(value.body);
                            if (responseBody['message'] ==
                                'added successfully') {
                              // showDialog(
                              //   context: context,
                              //   builder: (BuildContext context) {
                              //     return Directionality(
                              //       textDirection: TextDirection.rtl,
                              //       child: AlertDialog(
                              //         title: Text('تم التسجيل بنجاح'),
                              //         content:
                              //             Text('أنت الآن مسجل في هذا الكورس'),
                              //         actions: [
                              //           ElevatedButton(
                              //             onPressed: () {
                              //               Navigator.of(context).pop();
                              //               Navigator.pushReplacement(
                              //                 context,
                              //                 MaterialPageRoute(
                              //                     builder: (context) =>
                              //                         CourseDetailsPage(widget
                              //                             .c_id)), // Replace `YourPage` with the actual page you want to reload
                              //               );
                              //             },
                              //             child: Text('تم'),
                              //           ),
                              //         ],
                              //       ),
                              //     );
                              //   },
                              // );
                            } else {
                              print("error");
                              print(value.body);
                            }
                          });
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue,
                          minimumSize: Size(150, 40),
                        ),
                        child: Text(
                          'اشتري',
                          style: TextStyle(color: Colors.white, fontSize: 16),
                        ),
                      )
                    : Container(),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible:
                      isEnrolled, // Show the button only if isEnrolled is true
                  child: TextButton(
                    onPressed: () async {
                      showDialog(
                        context: context,
                        builder: (BuildContext context) {
                          String review =
                              ''; // Variable to store the review text

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
                                    textAlign: TextAlign
                                        .right, // Set the text alignment to right-to-left
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
                                    'service_id': widget.c_id.toString(),
                                  };

                                  // Make the HTTP POST request
                                  var response = await http.post(
                                    Uri.parse(
                                        'http://10.0.2.2:8000/api/add_course_rating'),
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
                        fontSize: 16.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    style: ButtonStyle(
                      backgroundColor:
                          MaterialStateProperty.all<Color>(Colors.blue),
                      padding: MaterialStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 140.0, vertical: 10.0),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Visibility(
                  visible: isEnrolled,
                  child: TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ComplaintCoursePage(
                            cId: widget.c_id.toString(),
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
                      backgroundColor:
                          WidgetStateProperty.all<Color>(Colors.blue),
                      padding: WidgetStateProperty.all<EdgeInsets>(
                        EdgeInsets.symmetric(horizontal: 40.0, vertical: 7.0),
                      ),
                    ),
                  ),
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
