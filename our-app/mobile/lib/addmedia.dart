import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/courses_types.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile/jobsCategories.dart';
import 'package:mobile/listCourses.dart';

class addmedia extends StatefulWidget {
  final int c_id;
  const addmedia(this.c_id, {Key? key}) : super(key: key);

  @override
  State<addmedia> createState() => _addmediaState();
}

class _addmediaState extends State<addmedia> {
  TextEditingController mediaTitleController = TextEditingController();
  TextEditingController mediaDescController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List<Map<String, String>> medias = [];

  Future<http.Response> add_medias(
    String c_id,
    List<dynamic> medias,
  ) async {
    var url = add_media;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'c_id': c_id,
          'medias': medias,
        }));
    return res;
  }

  String? base64video;
  final ImagePicker _picker = ImagePicker();
  File? _videoFile;
  String? video_name;
  Future<void> _pickVideo() async {
    final pickedFile = await _picker.pickVideo(source: ImageSource.gallery);

    if (pickedFile != null) {
      _videoFile = File(pickedFile.path);
      video_name = pickedFile.name;
    }
    if (_videoFile != null) {
      final videoBytes = await _videoFile!.readAsBytes();
      setState(() {
        base64video = base64Encode(videoBytes);
      });
    }
  }

  var socket;

  Future<void> connect(url, medias) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
      socket.add(medias);
      socket.listen(
        (message) {
          print(message);
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket connection closed');
        },
      );
      print('WebSocket connection established.');
    } catch (e) {
      print('WebSocket connection failed: $e');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(height: 16.0),
                Text(' عنوان الفيديو  ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextFormField(
                  controller: mediaTitleController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل  عنوان مناسب للفيديو'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال  عنوان للفيديو';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('وصف للفيديو  ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextFormField(
                  controller: mediaDescController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      InputDecoration(hintText: 'ادخل  وصف بسيط للفيديو'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال  وصف للفيديو ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                // Add Button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: _pickVideo,
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'اضف فيديو',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                // Add Button
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> media = {
                        'm_title': mediaTitleController.text,
                        'm_desc': mediaDescController.text,
                        'm_name': video_name!,
                        'm_data': base64video!,
                      };
                      medias.add(media);
                      print('media added to list');
                      print(medias);
                      setState(() {
                        mediaTitleController.clear();
                        mediaDescController.clear();
                      });
                    }
                  },
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'اضف ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: medias.length,
                    itemBuilder: (context, index) {
                      final media = medias[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "  عنوان الفيديو : ${media['m_title']} ",
                              ),
                              Text(
                                " وصف الفيديو  : ${media['m_desc']}",
                              ),
                              Text(
                                " اسم الفيديو المضاف   : ${media['m_name']}  ",
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),

                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          var data = jsonEncode({
                            'c_id': widget.c_id,
                            'medias': medias,
                          });
                          connect("ws://10.0.2.2:8766", data);
                          // socket.add(data);
                          // AuthCont.add_medias(widget.c_id.toString(), medias)
                          //     .then((value) {
                          //   if (value.statusCode == 200) {
                          //     print('skill added to the CV successfully');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => Course_types(),
                            ),
                          );
                          //   } else {
                          //     // Error response
                          //     print(
                          //         'Failed to add the skill to the CV. Error: ${value.body}');
                          //   }
                          // });
                        },
                        child: Text(
                          'حفظ ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
                        ),
                      ),
                    ),
                  ],
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
