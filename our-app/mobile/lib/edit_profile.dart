import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/veiwProfile.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key}) : super(key: key);

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;

  Map<String, dynamic>? userDetails = {};
  final _formKey = GlobalKey<FormState>();
  late String _currentImage = '';
  late File _selectedImage = File(''); // Initialize with an empty file path
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _fNameController = TextEditingController();
  TextEditingController _lNameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _userimageController = TextEditingController();

  Future<void> fetch() async {
    String? token = await AuthManager.getToken();
    var url = get_profile;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    print(res.body);
    Map<String, dynamic> data = json.decode(res.body);
    print(res.body);
    userDetails = data;
    setState(() {
      _ageController.text = userDetails!['age'].toString();
      _descController.text = userDetails!['u_desc'].toString();
      _currentImage = userDetails!['image'].toString();
      _userimageController.text = userDetails!['u_img'].toString();
      _fNameController.text = userDetails!['f_name'].toString();
      _lNameController.text = userDetails!['l_name'].toString();
      _emailController.text = userDetails!['email'].toString();
      _passwordController.text = userDetails!['password'].toString();
      _usernameController.text = userDetails!['username'].toString();
      print('object');
      print(userDetails!['u_img'].toString());
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
        userDetails!['u_img'] = pickedImage.name;
      });
    } else {
      setState(() {
        // No new image selected, keep the existing image
        _selectedImage = File('');
        _currentImage = userDetails!['image'].toString();
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetch();
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
        padding: EdgeInsets.only(top: 30, bottom: 16, left: 16, right: 16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    Container(
                      child: _selectedImage != null &&
                              _selectedImage.path.isNotEmpty
                          ? ClipOval(
                              child: Image.file(
                                _selectedImage,
                                height: 200.0,
                                width: 200.0,
                                fit: BoxFit.cover,
                              ),
                            )
                          : _currentImage.isNotEmpty
                              ? ClipOval(
                                  child: Image.memory(
                                  base64Decode(_currentImage),
                                  height: 200.0,
                                  width: 200.0,
                                  fit: BoxFit.cover,
                                ))
                              : ClipOval(
                                  child: Container(
                                    height: 200,
                                    width: 200.0,
                                    color: Colors.grey,
                                  ),
                                ),
                    ),
                    SizedBox(height: 10),
                    IconButton(
                      onPressed: _selectImage,
                      icon: Icon(Icons.edit),
                      tooltip: 'اختر صورة',
                    ),
                    SizedBox(height: 50),
                    _buildItem(
                      'العمر',
                      'age',
                      _ageController,
                      (value) {
                        _updateField('age', value);
                      },
                      isInteger: true,
                    ),
                    _buildItem(
                      'الوصف',
                      'u_desc',
                      _descController,
                      (value) {
                        _updateField('u_desc', value);
                      },
                    ),
                    _buildItem(
                      'الاسم الأول',
                      'f_name',
                      _fNameController,
                      (value) {
                        _updateField('f_name', value);
                      },
                    ),
                    _buildItem(
                      'الاسم الأخير',
                      'l_name',
                      _lNameController,
                      (value) {
                        _updateField('l_name', value);
                      },
                    ),
                    _buildItem(
                      'البريد الإلكتروني',
                      'email',
                      _emailController,
                      (value) {
                        _updateField('email', value);
                      },
                    ),
                    _buildItem(
                      'كلمة المرور',
                      'password',
                      _passwordController,
                      (value) {
                        _updateField('password', value);
                      },
                    ),
                    _buildItem(
                      'اسم المستخدم',
                      'username',
                      _usernameController,
                      (value) {
                        _updateField('username', value);
                      },
                    ),
                    SizedBox(
                      height: 40,
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
                        'حفظ التغيرات',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ],
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

  bool _validateEmail(String email) {
    if (email.isEmpty ||
        email.length > 35 ||
        !email.contains('@') ||
        !email.contains('.')) {
      return false;
    }
    return true;
  }

  Future<void> _saveDetails() async {
    final bool isNewImageSelected = _selectedImage.path.isNotEmpty;
    if (isNewImageSelected) {
      // Read the bytes from the selected image file
      List<int> imageBytes = _selectedImage.readAsBytesSync();
      // Convert the image bytes to base64 encoding
      String base64Image = base64Encode(imageBytes);
      // Update the 'image' field in the userDetails map with the new image
      setState(() {
        if (userDetails != null) {
          userDetails!['image'] = base64Image;
        }
      });
    } else {
      if (userDetails != null) {
        // Retrieve the current image from userDetails if it exists
        _currentImage = userDetails!['image'];
      }
    }

    _updateField('age', _ageController.text);
    _updateField('u_desc', _descController.text);
    _updateField('f_name', _fNameController.text);
    _updateField('l_name', _lNameController.text);
    _updateField('email', _emailController.text);
    _updateField('password', _passwordController.text);
    _updateField('username', _usernameController.text);

    if (!_validateEmail(_emailController.text)) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('خطأ في البريد الالكتروني '),
              content: Text('الرجاء ادخال بريد الكتروني صحيح'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('تم'),
                ),
              ],
            ),
          );
        },
      );
      return;
    }
    if (_passwordController.text.length < 4 ||
        _passwordController.text.length > 20) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return Directionality(
            textDirection: TextDirection.rtl,
            child: AlertDialog(
              title: Text('خطأ في كلمة المرور'),
              content: Text('يجب أن تكون كلمة المرور بين 4 و 20 حرفًا'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('تم'),
                ),
              ],
            ),
          );
        },
      );
      return;
    }

    if (userDetails != null) {
      print("Updated : ");
      print(userDetails!['image']);
      print("Updated : ");
      print(userDetails!['u_img']);
      AuthCont.editProfile(
        userDetails!['age']
            .toString(), // Convert 'age' to a string before passing it
        userDetails!['u_desc'],
        userDetails!['image'],
        userDetails!['u_img'],
        userDetails!['f_name'],
        userDetails!['l_name'],
        userDetails!['email'],
        userDetails!['password'],
        userDetails!['username'],
      ).then((value) {
        print('object save');
        print(userDetails!['image']);
        if (value.statusCode == 200) {
          print('edited successfully');
          print(userDetails);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => ViewProfile()));
        } else {
          print(value.statusCode);
          print(value.body);
          print('something went wrong');
          print(userDetails);
        }
      });
    }
  }

  void _updateField(String key, String value) {
    if (userDetails != null) {
      setState(() {
        userDetails![key] = value;
      });
      print(key);
      print("Updated userDetails: ");
      print(userDetails![key]);
    }
  }
}
