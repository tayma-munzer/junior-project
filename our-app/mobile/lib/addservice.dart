// Place the necessary input parameters between the sync and return statement

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile/appbar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/bottombar.dart';
import 'dart:async';
import 'package:mobile/constant/links.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:file/file.dart';
import 'dart:typed_data';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
  // static Future<http.Response> addService(
  //   String name,
  //   String price,
  //   String mainCategory,
  //   String subCategory,
  //   String description,
  //   String duration,
  // ) async {
  //   return await http.post(
  //     Uri.parse(add_service),
  //     body: {
  //       'service_name': name,
  //       'service_price': price,
  //       //'mainCategory': mainCategory,
  //       'service_sec_type': '3',
  //       'service_desc': description,
  //       'service_duration': duration,
  //       'token':
  //           "80926987e44d7d7d3e7650e0d0f8eb023dee3b3139a7839753f758623bd9ced9",
  //     },
  //   );
  // }
}

class _AddServiceState extends State<AddService> {
  String selectedMainCategory = 'Category 1';
  String selectedSecondaryCategory = 'Subcategory 1';
  String selectedDuration = '1 hour';
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  List<XFile> images = [];
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List first_type = [];
  List sec_type = [];

  void fetch() async {
    var url1 = services_first_type;
    var res = await http.get(Uri.parse(url1));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      first_type = data.map((item) => item).toList();
      selectedMainCategory = first_type[0]['type'];
    });
  }

  void fetchnext() async {
    var url2 = get_all_services_second_types;
    var res2 = await http.get(Uri.parse(url2));
    List<dynamic> data2 = json.decode(res2.body);
    setState(() {
      sec_type = data2.map((item) => item).toList();
      selectedSecondaryCategory = sec_type[0]['sec_type'];
    });
  }

  void fetch_sec_types(type) async {
    String type_id = '';
    for (var item in first_type) {
      if (item['type'] == type) {
        type_id = item['t_id'].toString();
      }
    }
    var url2 = services_second_type;
    var res2 = await http.post(Uri.parse(url2), body: {"t_id": type_id});
    List<dynamic> data = json.decode(res2.body);
    setState(() {
      sec_type = data.map((item) => item).toList();
      selectedSecondaryCategory = sec_type[0]['sec_type'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
    fetchnext();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  late Directory documentDirectory;
  Future<void> _getImageFromGallery() async {
    //Directory documentDirectory = await getApplicationDocumentsDirectory();
    List<XFile>? pickedImages = await _picker.pickMultiImage();
    if (pickedImages != null) {
      setState(() {
        images.addAll(pickedImages);
      });
    }
  }

  Future<void> _saveImagesToFolder() async {
    for (XFile image in images) {
      String image_name = path.basename(image.path);
      String image_path = path.join('lib/images');
      print("path : " + image_path);
      print("name : " + image.name);
      print("start");
      await image.saveTo((await getApplicationDocumentsDirectory()).path);
      print("done");
    }
    String imagePath = "C:/Users/tayma_36c2fp3/Pictures/image2.jpg";

    String imageName = path.basename(imagePath);
    String destinationPath = path.join('lib/images', imageName);

    print("Copying $imageName to $destinationPath");

    try {
      //Uint8List bytes = await imageFile.readAsBytes();
      //await File(path).writeAsBytes(bytes);
      print("$imageName copied successfully!");
      // await imageFile.copy(destinationPath);
      // print("$imageName copied successfully!");
    } catch (e) {
      print("Error copying $imageName: $e");
    }
  }

  String service_name = "";
  String service_price = "";
  String service_desc = "";
  String service_duration = "";
  String service_sec_type = "";
  String service_img = "";

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
                    } else {
                      service_name = value;
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
                    } else {
                      service_price = value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 10),
                Text('التصنيف الرئيسي', textAlign: TextAlign.right),
                DropdownButton<String>(
                  value: selectedMainCategory,
                  items: first_type.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['type'],
                      child: Text(value['type'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMainCategory = value!;
                      fetch_sec_types(value.trim());
                    });
                  },
                ),
                SizedBox(height: 10),
                Text('التصنيف الفرعي', textAlign: TextAlign.right),
                DropdownButton<String>(
                  value: selectedSecondaryCategory,
                  items: sec_type.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['sec_type'],
                      child:
                          Text(value['sec_type'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSecondaryCategory = value!;
                      service_sec_type = value;
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
                    } else {
                      service_desc = value;
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
                      _saveImagesToFolder();
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
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            AuthCont.addService(
                                    service_name,
                                    service_price,
                                    service_sec_type,
                                    service_desc,
                                    selectedDuration,
                                    'img_path')
                                .then((value) {
                              if (value.statusCode == 200) {
                                print('Service added successfully');
                              } else {
                                // Error response
                                print(
                                    'Failed to add service. Error: ${value.body}'); //${value.body}
                              }
                            });
                            //await _saveImagesToFolder();
                            // http.Response response =
                            //     await AddService.addService(
                            //   // Add input parameters here
                            //   'name',
                            //   '700000',
                            //   'mainCategory',
                            //   'subCategory',
                            //   'description',
                            //   'duration',
                            // ).then((value) {
                            // if (value.statusCode == 200) {
                            //   // Successful response
                            //   print('Service added successfully');
                            // } else {
                            //   // Error response
                            //   print(
                            //       'Failed to add service. Error: ${value.body}');
                            // }
                            // });
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
