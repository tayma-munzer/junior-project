import 'dart:convert';
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editCourse.dart';
import 'package:mobile/listCourses.dart';
import 'package:mobile/videoWidget.dart';
import 'package:mobile/videoplayer.dart';

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

  Future<void> fetchCourseData() async {
    var url = get_course_detils; // Replace with your API URL
    var response = await http.post(Uri.parse(url), body: {
      "c_id": widget.c_id.toString(),
    });

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      //if (decodedData is Map<String, dynamic>) {
      setState(() {
        courseData = {
          "c_id": decodedData["c_id"].toString(),
          "c_name": decodedData["c_name"],
          "c_desc": decodedData["c_desc"],
          "c_price": decodedData["c_price"].toString(),
          "c_img": decodedData["c_img"],
          "c_duration": decodedData["c_duration"].toString(),
          "pre_recuisite": decodedData["pre_recuisite"],
        };
        print('000');
        print(decodedData["c_name"].toString());
      });
      fetchVideoData(); // Fetch video data after course data is retrieved
    } else {
      print(response.body);
      print("Invalid response format: decodedData");
    }
    //} else {
    //   print("Request failed with status: ${response.statusCode}");
    // }
  }

  Future<void> fetchVideoData() async {
    var url = get_all_media; // Replace with your video API URL
    var response = await http.post(Uri.parse(url), body: {
      "c_id": courseData["c_id"].toString(),
    });

    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is Map<String, dynamic>) {
        setState(() {
          videoData = decodedData;
          isLoading = false;
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
    fetchCourseData();
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
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: EdgeInsets.all(16),
                child: FutureBuilder<Uint8List?>(
                  future: courseData["c_img"] != null
                      ? Future.value(
                          base64Decode(courseData["c_img"] ))
                      : Future.value(null),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator(),
                      );
                    } else if (snapshot.hasError) {
                      return Center(
                        child: Text('Error loading image'),
                      );
                    } else if (snapshot.data != null) {
                      return Image.memory(
                        snapshot.data!,
                        fit: BoxFit.cover,
                        height: 300.0,
                        width: double.infinity,
                      );
                    } else {
                      return Container(); // Return an empty container if image data is null
                    }
                  },
                ),
              ),
              SizedBox(height: 20),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  color: Colors.white,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            'العنوان: ',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            courseData != null
                                ? courseData["c_name"].toString()
                                : "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            Text(
                              'الوصف',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              courseData != null
                                  ? courseData["c_desc"].toString()
                                  : "",
                              style: TextStyle(fontSize: 16),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'مدة الكورس',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            courseData != null
                                ? courseData["c_duration"].toString()
                                : "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                      SizedBox(height: 16),
                      Row(
                        children: [
                          Text(
                            'المتطلبات السابقة',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 8),
                          Text(
                            courseData != null
                                ? courseData["pre_recuisite"].toString()
                                : "",
                            style: TextStyle(fontSize: 16),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(16),
                child: isLoading
                    ? SizedBox(
                        width: 24, // Set the desired width
                        height: 24, // Set the desired height
                        child: CircularProgressIndicator(),
                      )
                    : ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: videoData != null ? videoData!.length : 0,
                        itemBuilder: (context, index) {
                          var videoId = videoData!.keys.elementAt(index);
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

                          return videoWidget; // Replace videoWidget(videoId, videoName) with videoWidget
                        },
                      ),
              ),
              SizedBox(
                height: 40,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => EditCourse(widget.c_id)),
                    );
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(Size(300, 40)),
                  ),
                  child: Text('Edit', style: TextStyle(color: Colors.white)),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 50),
                child: ElevatedButton(
                  onPressed: () async {
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
                      print(
                          "Delete request failed with status: ${response.statusCode}");
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.red),
                    minimumSize: MaterialStateProperty.all(Size(300, 40)),
                  ),
                  child: Text('Delete', style: TextStyle(color: Colors.white)),
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
