import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/addmedia.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:video_player/video_player.dart';
import 'dart:io';
import 'package:mobile/appbar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/bottombar.dart';
import 'dart:async';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;

class AddCourse extends StatefulWidget {
  const AddCourse({Key? key}) : super(key: key);

  @override
  State<AddCourse> createState() => _AddCourseState();
}

class _AddCourseState extends State<AddCourse> {
  String selectedMainCategory = ' ';
  String selectedSecondaryCategory = 'Subcategory 1';
  String selectedDuration = '1 hour';
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
  List<XFile> videos = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? _imageFile;
  String? image_name;
  String? base64Image;
  String c_name = '';
  String c_desc = '';
  String c_price = '';
  String c_img = '';
  String c_img_data = '';
  String c_duration = '';
  String pre_requisite = '';
  String category = '';
  String num_of_free_videos = '';
  List first_type = ['lolo'];
  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      print('object');
      image_name = image.name;
      images.add(image);
    }
    if (_imageFile != null) {
      print('2');
      final imageBytes = await _imageFile!.readAsBytes();
      setState(() {
        base64Image = base64Encode(imageBytes);
      });
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetch();
  }

  void fetch() async {
    var url1 = get_course_types;
    var res = await http.get(Uri.parse(url1));
    print(res.body);
    List<dynamic> data = json.decode(res.body);
    print('0');
    print(data);
    setState(() {
      first_type = data.map((item) => item).toList();
      selectedMainCategory = first_type[0]['ct_type'];
    });
  }

  // Future<void> _getVideoFromGallery() async {
  //   try {
  //     XFile? pickedVideo = await _picker.pickVideo(source: ImageSource.gallery);
  //     if (pickedVideo != null) {
  //       setState(() {
  //         videos.add(pickedVideo);
  //       });
  //     }
  //   } catch (e) {
  //     print('Error picking video: $e');
  //   }
  // }

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
                    c_name = value;
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'التصنيف الرئيسي',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedMainCategory,
                  items: first_type.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['ct_type'],
                      child: Text(value['ct_type'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMainCategory = value!;
                    });
                  },
                  icon: SizedBox.shrink(),
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
                    c_price = value;
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
                    c_desc = value;
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
                    c_duration = value;
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
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال متطلبات سابقة للكورس';
                    }
                    pre_requisite = value;
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('عدد الفيديوهات المجانية التي ترغب بتوفيرها',
                    textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: " ",
                    contentPadding: EdgeInsets.only(top: 50),
                    prefixIcon: Icon(Icons.money_off),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال عدد الفيديوهات المجانية في الكورس';
                    }
                    if (int.tryParse(value) == null || int.parse(value) <= 0) {
                      return ' الرجاء إدخال قيمة صحيحة اكبر من الصفر';
                    }
                    num_of_free_videos = value;
                    return null;
                  },
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
                SizedBox(height: 10),
                Center(
                  child: Column(
                    children: [
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthCont.addCourse(
                                    c_name,
                                    c_desc,
                                    c_price,
                                    image_name!,
                                    base64Image!,
                                    c_duration,
                                    pre_requisite,
                                    selectedMainCategory,
                                    num_of_free_videos)
                                .then((value) {
                              if (value.statusCode == 200) {
                                print('course added successfully');
                                int c_id = json.decode(value.body)['course_id'];
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => addmedia(c_id)),
                                );
                              } else {
                                // Error response
                                print(
                                    'Failed to add course. Error: ${value.body}'); //${value.body}
                              }
                            });
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
                        child: Text('   انتقال الى اضافة الفيديوهات   '),
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
