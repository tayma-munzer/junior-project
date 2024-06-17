import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/listCourses.dart';
import 'package:mobile/videoWidget.dart';

class EditCourse extends StatefulWidget {
  final int c_id;

  const EditCourse(this.c_id, {Key? key}) : super(key: key);

  @override
  State createState() => _EditCourseState();
}

class _EditCourseState extends State<EditCourse> {
  Map<String, dynamic>? courseDetails = {};
  Map<String, dynamic>? videoData;
  bool isLoading = true;
  late String _currentImage = '';
  late File _selectedImage = File('');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _durationController = TextEditingController();
  TextEditingController _prerequisiteController = TextEditingController();
  TextEditingController _imageController = TextEditingController();

  void fetchCourse() async {
    var url = get_course_detils;
    var res =
        await http.post(Uri.parse(url), body: {'c_id': widget.c_id.toString()});
    var responseData = json.decode(res.body);
    print(res.body);
    courseDetails = json.decode(res.body);
    setState(() {
      _titleController.text = courseDetails!['c_name'].toString();
      _descController.text = courseDetails!['c_desc'].toString();
      _priceController.text = courseDetails!['c_price'].toString();
      _imageController.text = courseDetails!['c_img'].toString();
      _durationController.text = courseDetails!['c_duration'].toString();
      _prerequisiteController.text =
          courseDetails!['pre_requisite'].toString();
      _currentImage = courseDetails!['image'].toString();
      print(courseDetails!['image'].toString());
      print('object');
      print(_currentImage);
    });
  }

  Future<void> _selectImage() async {
    final pickedImage = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );

    if (pickedImage != null) {
      final pickedImageBytes = await pickedImage.readAsBytes();
      String base64Image = base64Encode(pickedImageBytes);
      setState(() {
        _selectedImage = File(pickedImage.path);
        _currentImage = base64Image;
        courseDetails!['c_img'] = pickedImage.name;
      });
    } else {
      setState(() {
        // No new image selected, keep the existing image
        _selectedImage = File('');
        _currentImage = courseDetails!['image'].toString();
      });
    }
  }

  Future<void> fetchVideoData() async {
    var url = get_all_media; // Replace with your video API URL
    var response = await http.post(Uri.parse(url), body: {
      'c_id': courseDetails!['c_id'].toString(),
    });
    print('video fetch');
    print(courseDetails!['c_id']);
    print(response.body);
    if (response.statusCode == 200) {
      var decodedData = json.decode(response.body);

      if (decodedData is List<dynamic>) {
        // Check if the decoded data is a list
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
      print("hello Request failed with status: ${response.body}");
      print(response.statusCode);
    }
  }

  @override
  void initState() {
    super.initState();
    fetchCourse();
    fetchVideoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Container(
                  child:
                      _selectedImage != null && _selectedImage.path.isNotEmpty
                          ? Image.file(
                              _selectedImage,
                              height: 200.0,
                              width: 200.0,
                              fit: BoxFit.cover,
                            )
                          : _currentImage.isNotEmpty
                              ? Image.memory(
                                  base64Decode(_currentImage),
                                  height: 200.0,
                                  width: 200.0,
                                  fit: BoxFit.cover,
                                )
                              : Container(
                                  height: 200,
                                  width: 200.0,
                                  color: Colors.grey,
                                ),
                ),
                SizedBox(height: 10),
                IconButton(
                  onPressed: _selectImage,
                  icon: Icon(Icons.edit),
                  tooltip: 'اختر صورة',
                ),
                SizedBox(height: 50),
                _buildItem('عنوان الدورة التعليمية', 'c_name', _titleController,
                    (value) {
                  courseDetails!['c_name'] = value;
                }),
                _buildItem('نوصيف الدورة', 'c_desc', _descController, (value) {
                  courseDetails!['c_desc'] = value;
                }),
                _buildItem('السعر', 'c_price', _priceController, (value) {
                  courseDetails!['c_price'] = value;
                }, isInteger: true),
                _buildItem('المدة', 'c_duration', _durationController, (value) {
                  courseDetails!['c_duration'] = value;
                }),
                _buildItem('المتطلبات السابقة ', 'c_prerequisite',
                    _prerequisiteController, (value) {
                  courseDetails!['c_prerequisite'] = value;
                }),
                SizedBox(height: 10),
                isLoading
                    ? CircularProgressIndicator()
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
                              canEdit: true,
                              onPressedDelete: () async {
                                var url = delete_media;
                                var res = await http.post(Uri.parse(url),
                                    body: {
                                      'c_id': videoData!['c_id'].toString()
                                    });
                                print('hello');
                                if (res.statusCode == 200) {
                                  print('deleted seccessfully');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListCourses()),
                                  );
                                }
                              });

                          return videoWidget;
                        },
                      ),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveDetails();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: WidgetStateProperty.all(Colors.blue),
                    minimumSize: WidgetStateProperty.all(Size(200, 50)),
                  ),
                  child: Text(
                    ' حفظ التغيريات',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
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

  Widget _buildItem(String labelText, String key,
      TextEditingController controller, void Function(String) onSave,
      {bool isInteger = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end, // Align children to the end
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment:
                MainAxisAlignment.end, // Align label to the right
            children: [
              Text(
                labelText,
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ],
          ),
          SizedBox(height: 5),
          TextFormField(
            controller: controller,
            decoration: InputDecoration(
              contentPadding:
                  EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            ),
            textAlign: TextAlign.right,
            maxLines: 2,
            validator: (input) {
              if (input == null || input.isEmpty) {
                return 'يرجى ملء الحقل';
              } else if (isInteger && int.tryParse(input) == null) {
                return 'يرجى ادخال رقم موجب صحيح';
              }
              return null;
            },
            onChanged: (newValue) {
              onSave(newValue);
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }

  Future<void> _saveDetails() async {
    final bool isNewImageSelected = _selectedImage.path.isNotEmpty;
    if (isNewImageSelected) {
      List<int> imageBytes = _selectedImage.readAsBytesSync();
      String base64Image = base64Encode(imageBytes);
      setState(() {
        if (courseDetails != null) {
          courseDetails!['image'] = base64Image;
        }
      });
    } else {
      if (courseDetails != null) {
        _currentImage = courseDetails!['image'];
      }
    }


    _updateField('c_name',  _titleController.text);
    _updateField('c_desc', _descController.text);
    _updateField('c_price', _priceController.text);
    _updateField('c_duration', _durationController.text);
    _updateField('prerequisite', _prerequisiteController.text);


    if (courseDetails != null) {
      print("Updated : ");
      print(courseDetails!['image']);
      AuthCont.editCourse(
        courseDetails!['c_id'].toString(),
        courseDetails!['c_name'],
        courseDetails!['c_desc'],
        courseDetails!['c_price'].toString(),
        courseDetails!['c_img'],
        courseDetails!['c_duration'].toString(),
        courseDetails!['pre_requisite'],
        courseDetails!['image'].toString(),
      ).then((value) {
        print('object save');
        print(courseDetails!['image']);
        if (value.statusCode == 200) {
          print('edited successfully');
          print(courseDetails);
        } else {
          print('something went wrong');
          print(value.body);
          print(courseDetails);
        }
      });
    }
  }

    void _updateField(String key, String value) {
      if (courseDetails!= null) {
        setState(() {
          courseDetails![key] = value;
        });
        print(key);
        print("Updated userDetails: ");
        print(courseDetails![key]);
        // print("Keys in userDetails: ${userDetails!.keys.toList()}");
        // print("values in userDetails: ${userDetails!.values.toList()}");
      }
    }
  }

