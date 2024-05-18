import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:mobile/appbar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/bottombar.dart';
import 'dart:async';

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  String selectedMainCategory = 'Category 1';
  String selectedSecondaryCategory = 'Subcategory 1';
  String selectedDuration = '1 hour';
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
  List<XFile> videos = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages);
      });
    }
  }

  Future<void> _getVideoFromGallery() async {
    try {
      XFile? pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
      if (pickedVideo != null) {
        setState(() {
          videos.add(pickedVideo);
        });
      }
    } catch (e) {
      print('Error picking video: $e');
    }
  }

  Future<void> _saveImagesToFolder() async {
    for (XFile image in images) {
      final File newImage =
          File('path/to/images/folder/${image.path.split('/').last}');
      await newImage.writeAsBytes(await image.readAsBytes());
    }
//هون بنخط اللوجيك تيع الفيديو video
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(child: Image.asset('assets/course.png', width: 150)),
                Text('اسم الكورس', textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اجعل الاسم مختصر و واضح',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الكورس';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('سعر الكورس', textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'على سعر الكورس 50000 كحد ادنى',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال سعر الكورس';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 50000) {
                      return 'الرجاء إدخال قيمة صحيحة أكبر من 50000';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('ادخل وصفا عن الكورس', textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ادخل وصفا عن خدمتك',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال وصف عن الكورس';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text(' ادخل المدة التي سيستغرقها الكورس',
                    textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ادخل مدة الكورس (بالأرقام فقط)',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.timelapse),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال مدة الكورس';
                    }
                    if (int.tryParse(value) == null || int.parse(value) < 3) {
                      return 'الرجاء إدخال قيمة صحيحة على الأقل 3';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('ما يجب ان بمتلكه المشترك قبل التسجيل بالكورس ',
                    textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: ' ',
                    contentPadding: EdgeInsets.only(top: 50),
                    prefixIcon: Icon(Icons.rule),
                  ),
                ),
                SizedBox(height: 20),
                Text('الصور', textAlign: TextAlign.right),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: images.map((image) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Image.file(File(image.path), height: 100),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _getImageFromGallery,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 50)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('اضف صورة  '),
                      ),
                    ],
                  ),
                ),
                Text('الفيديوهات', textAlign: TextAlign.right),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: videos.map((video) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: VideoPlayer(
                            VideoPlayerController.file(File(video.path))),
                      );
                    }).toList(),
                  ),
                ),
                SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (!kIsWeb) {
                            _getVideoFromGallery();
                          } else {
                            //الايرورز
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 50)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('اضف فيديو'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            _saveImagesToFolder();
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 50)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text('   اضف الكورس    '),
                      ),
                    ],
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
