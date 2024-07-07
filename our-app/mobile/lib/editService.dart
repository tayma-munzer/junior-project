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

class EditService extends StatefulWidget {
  final int s_id;

  const EditService(this.s_id, {Key? key}) : super(key: key);

  @override
  State createState() => _EditServiceState();
}

class _EditServiceState extends State<EditService> {
  Map<String, dynamic>? serviceDetails = {};

  bool isLoading = true;
  late String _currentImage = '';
  late File _selectedImage = File('');
  final _formKey = GlobalKey<FormState>();
  TextEditingController _titleController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _priceController = TextEditingController();
  TextEditingController _durationController = TextEditingController();

  TextEditingController _imageController = TextEditingController();

  void fetchService() async {
    var url = get_service;
    var res =
    await http.post(Uri.parse(url), body: {'s_id': widget.s_id.toString()});
    var responseData = json.decode(res.body);
    print(res.body);
    serviceDetails = json.decode(res.body);
    setState(() {
      _titleController.text = serviceDetails!['s_name'].toString();
      _descController.text = serviceDetails!['s_desc'].toString();
      _priceController.text = serviceDetails!['s_price'].toString();
      _imageController.text = serviceDetails!['s_img'].toString();
      _durationController.text = serviceDetails!['s_duration'].toString();

      _currentImage = serviceDetails!['image'].toString();
      print(serviceDetails!['image'].toString());
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
        serviceDetails!['s_img'] = pickedImage.name;
      });
    } else {
      setState(() {
        // No new image selected, keep the existing image
        _selectedImage = File('');
        _currentImage = serviceDetails!['image'].toString();
      });
    }
  }



  @override
  void initState() {
    super.initState();
    fetchService();

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
                _buildItem('عنوان الدورة التعليمية', 's_name', _titleController,
                        (value) {
                      serviceDetails!['s_name'] = value;
                    }),
                _buildItem('نوصيف الدورة', 's_desc', _descController, (value) {
                  serviceDetails!['s_desc'] = value;
                }),
                _buildItem('السعر', 's_price', _priceController, (value) {
                  serviceDetails!['s_price'] = value;
                }, isInteger: true),
                _buildItem('المدة', 's_duration', _durationController, (value) {
                  serviceDetails!['s_duration'] = value;
                }),

                SizedBox(height: 10),

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
        if (serviceDetails != null) {
          serviceDetails!['image'] = base64Image;
        }
      });
    } else {
      if (serviceDetails != null) {
        _currentImage = serviceDetails!['image'];
      }
    }

    _updateField('s_name', _titleController.text);
    _updateField('s_desc', _descController.text);
    _updateField('s_price', _priceController.text);
    _updateField('s_duration', _durationController.text);


    if (serviceDetails != null) {
      print("Updated : ");
      print(serviceDetails!['image']);
      AuthCont.editService(
        serviceDetails!['s_id'].toString(),
        serviceDetails!['s_name'],
        serviceDetails!['s_desc'],
        serviceDetails!['s_price'].toString(),
        serviceDetails!['s_duration'].toString(),
        serviceDetails!['s_img'],
        serviceDetails!['image'].toString(),
      ).then((value) {
        print('object save');
        print(serviceDetails!['image']);
        if (value.statusCode == 200) {
          print('edited successfully');
          print(serviceDetails);
        } else {
          print('something went wrong');
          print(value.body);
          print(serviceDetails);
        }
      });
    }
  }

  void _updateField(String key, String value) {
    if (serviceDetails != null) {
      setState(() {
        serviceDetails![key] = value;
      });
      print(key);
      print("Updated serviceDetails: ");
      print(serviceDetails![key]);
      // print("Keys in userDetails: ${userDetails!.keys.toList()}");
      // print("values in userDetails: ${userDetails!.values.toList()}");
    }
  }
}
