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

  Future<void> fetch() async {
    String? token = await AuthManager.getToken();
    var url = get_profile;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    print(res.body);
    userDetails = data;
    String imageUrl = data['u_img'].replaceAll(r'\/', '/');
    http.Response imageRes = await http.get(Uri.parse(imageUrl));
    String base64Image = base64Encode(imageRes.bodyBytes);
    setState(() {
      _ageController.text = userDetails!['age'].toString();
      _descController.text = userDetails!['u_desc'].toString();
      _currentImage = base64Image;
      _fNameController.text = userDetails!['f_name'].toString();
      _lNameController.text = userDetails!['l_name'].toString();
      _emailController.text = userDetails!['email'].toString();
      _passwordController.text = userDetails!['password'].toString();
      _usernameController.text = userDetails!['username'].toString();
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
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Center(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 50),
                    InkWell(
                      onTap: _selectImage,
                      child: _selectedImage != null &&
                              _selectedImage.path.isNotEmpty
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
                    _buildItem(
                      'السن',
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
                      // style: ButtonStyle(
                      //   backgroundColor: WidgetStateProperty.all(Colors.blue),
                      //   minimumSize: WidgetStateProperty.all(Size(200, 50)),
                      // ),
                      child: Text(
                        'حفظ التغيرات',
                        style: TextStyle(
                          color: Color.fromARGB(255, 255, 255, 255),
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

  Future<void> _saveDetails() async {
    userDetails!['u_img'] = _currentImage;

    print(userDetails);
    AuthCont.editProfile(
      userDetails!['age'].toString(),
      userDetails!['u_desc'],
      userDetails!['f_name'],
      userDetails!['l_name'].toString(),
      userDetails!['u_img'],
      userDetails!['email'],
      userDetails!['password'],
      userDetails!['username'],
    ).then((value) {
      if (value.statusCode == 200) {
        print('edited successfully');
      } else {
        print('something went wrong');
      }
    });
  }

  void _updateField(String key, String value) {
    if (userDetails![key] != value) {
      setState(() {
        userDetails![key] = value;
      });
    }
  }
}
