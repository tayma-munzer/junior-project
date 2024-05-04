import 'package:flutter/material.dart';
import 'package:mobile/addcvskills.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';

class AddCVMain extends StatefulWidget {
  const AddCVMain({Key? key}) : super(key: key);

  @override
  State<AddCVMain> createState() => _AddCVMainState();
}

class _AddCVMainState extends State<AddCVMain> {
  TextEditingController CVcareerObjController = TextEditingController();
  TextEditingController CVPhoneController = TextEditingController();
  TextEditingController CVAdressController = TextEditingController();
  TextEditingController CVEmailController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String career_obj = '';
  String phone = '';
  String address = '';
  String email = '';

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
                Text(':اضف معلومات اساسية للسيرة الذاتية',
                    textAlign: TextAlign.right),
                SizedBox(height: 16.0),
                Text('الهدف الوظيفي '),
                TextFormField(
                  controller: CVcareerObjController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل الهدف الوظيفي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال الهدف الوظيفي';
                    }
                    career_obj = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('العنوان '),
                TextFormField(
                  controller: CVAdressController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل  عنوانك'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال عنوانك السكني ';
                    }
                    address = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('البريد الالكتروني'),
                TextFormField(
                  controller: CVEmailController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل بريدك الالكتروني'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp('[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+[.][a-zA-Z]{2,}')
                            .hasMatch(value)) {
                      return 'ادخل الصيغة الصحيحة للبريد الالكتروني ';
                    }
                    email = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('رقم الهاتف'),
                TextFormField(
                  controller: CVPhoneController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل رقم هاتفك'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى إدخال رقم هاتف';
                    }
                    if (value.length < 10) {
                      return 'الرجاء إدخال رقم هاتف يتكون من 10 أرقام على الأقل';
                    }
                    if (!RegExp(r'^09\d{8}$').hasMatch(value)) {
                      return 'الرجاء إدخال رقم هاتف صالح يبدأ بـ 09 ويتكون من 10 أرقام';
                    }
                    phone = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      AuthCont.add_cv(career_obj, phone, address, email)
                          .then((value) {
                        if (value.statusCode == 200) {
                          print('main information of CV added successfully');
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCVSkills()),
                          );
                        } else {
                          // Error response
                          print(
                              'Failed to add the main information of the CV. Error: ${value.body}');
                        }
                      });
                    }
                  },
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'التالي ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
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
}
