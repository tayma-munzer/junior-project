// Place the necessary input parameters between the sync and return statement

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile/appbar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/bottombar.dart';
import 'dart:async';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
  static Future<http.Response> addService(
    String name,
    String price,
    String mainCategory,
    String subCategory,
    String description,
    String duration,
  ) async {
    return await http.post(
      Uri.parse('add_service'),
      body: {
        'name': name,
        'price': price,
        'mainCategory': mainCategory,
        'subCategory': subCategory,
        'description': description,
        'duration': duration,
      },
    );
  }
}

class _AddServiceState extends State<AddService> {
  String selectedMainCategory = 'Category 1';
  String selectedSecondaryCategory = 'Subcategory 1';
  String selectedDuration = '1 hour';
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
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

  Future<void> _saveImagesToFolder() async {
    for (XFile image in images) {
      String newPath = 'path/to/image/folder/' + image.path.split('/').last;
      File(image.path).copy(newPath);
    }
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
                Text('اسم الخدمة', textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اجعل الاسم مختصر و واضح',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الخدمة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('سعر الخدمة', textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'على سعر الخدمة 50000 كحد ادنى',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال سعر الخدمة';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 50000) {
                      return 'الرجاء إدخال قيمة صحيحة أكبر من 50000';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('التصنيف الرئيسي', textAlign: TextAlign.right),
                DropdownButton<String>(
                  value: selectedMainCategory,
                  items: <String>['Category 1', 'Category 2', 'Category 3']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedMainCategory = value!;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('التصنيف الفرعي', textAlign: TextAlign.right),
                DropdownButton<String>(
                  value: selectedSecondaryCategory,
                  items: <String>[
                    'Subcategory 1',
                    'Subcategory 2',
                    'Subcategory 3',
                    'Subcategory 4'
                  ].map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSecondaryCategory = value!;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('الوصف', textAlign: TextAlign.right),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ادخل وصفا عن خدمتك',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال وصف للخدمة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('المدة', textAlign: TextAlign.right),
                DropdownButton<String>(
                  value: selectedDuration,
                  items: <String>['1 hour', '2 hours', '3 hours', '4 hours']
                      .map((String value) {
                    return DropdownMenuItem<String>(
                      value: value,
                      child: Text(value, textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedDuration = value!;
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('قواعد للمشتريين', textAlign: TextAlign.right),
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
                        child: Image.network(image.path, height: 100),
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
                        child: Text('اضف صورة او فيديو'),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            await _saveImagesToFolder();
                            http.Response response =
                                await AddService.addService(
                              // Add input parameters here
                              'name',
                              'price',
                              'mainCategory',
                              'subCategory',
                              'description',
                              'duration',
                            );
                            if (response.statusCode == 200) {
                              // Successful response
                              print('Service added successfully');
                            } else {
                              // Error response
                              print(
                                  'Failed to add service. Error: ${response.body}');
                            }
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
                        child: Text('   اضف خدمة    '),
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
