import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
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

  void fetchCourse() async {
    var url = get_course_detils;
    var res =
        await http.post(Uri.parse(url), body: {'c_id': widget.c_id.toString()});
    var responseData = json.decode(res.body);
    print(res.body);
    setState(() {
      courseDetails = json.decode(res.body);
      _titleController.text = courseDetails!['c_name'].toString();
      _descController.text = courseDetails!['c_desc'].toString();
      _priceController.text = courseDetails!['c_price'].toString();
      _durationController.text = courseDetails!['c_duration'].toString();
      _prerequisiteController.text =
          courseDetails!['c_prerequisite'].toString();
      _currentImage = responseData['c_img'];
    });
  }

  late String _selectedImagePath = ''; // Selected image path

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
      });
    }
  }

  void fetchVideos() async {
    var url = get_media;
    var res =
        await http.post(Uri.parse(url), body: {"c_id": widget.c_id.toString});
    print(res.body);
    if (res.statusCode == 200) {
      var decodedData = json.decode(res.body);

      if (decodedData is Map<String, dynamic>) {
        setState(() {
          videoData = decodedData;
          isLoading = false;
        });
      } else {
        print("Invalid response format: $decodedData");
      }
    } else {
      print("Request failed with status: ${res.statusCode}");
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchCourse();
    fetchVideos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              InkWell(
                onTap: _selectImage,
                child: _selectedImage != null && _selectedImage.path.isNotEmpty
                    ? Image.file(
                        _selectedImage,
                        height: 300.0,
                        width: double.infinity,
                        fit: BoxFit.cover,
                      )
                    : _currentImage.isNotEmpty
                        ? Image.memory(
                            base64Decode(_currentImage),
                            height: 300.0,
                            width: double.infinity,
                            fit: BoxFit.cover,
                          )
                        : Container(),
              ),
              SizedBox(height: 10),
              IconButton(
                onPressed: _selectImage,
                icon: Icon(Icons.image),
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
              Padding(
                padding: EdgeInsets.all(16),
                child: isLoading
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
                                if (res.statusCode == 200) {
                                  print('deleted seccessfully');
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => ListCourses()),
                                  );
                                }
                              });

                          return videoWidget; // Replace videoWidget(videoId, videoName) with videoWidget
                        },
                      ),
              ),
              ElevatedButton(
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    _saveDetails();
                  }
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                  minimumSize: MaterialStateProperty.all(Size(200, 50)),
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

  void _saveDetails() {
    courseDetails!['c_img'] = _selectedImagePath ?? _currentImage;
    print(courseDetails);
    AuthCont.editCourse(
            courseDetails!['c_id'].toString(),
            courseDetails!['c_name'],
            courseDetails!['c_desc'],
            courseDetails!['c_price'].toString(),
            courseDetails!['c_img'],
            courseDetails!['c_duration'],
            courseDetails!['prerequisite'])
        .then((value) {
      if (value.statusCode == 200) {
        print('edited successfully');
      } else {
        print('something went wrong');
      }
    });
  }
}
