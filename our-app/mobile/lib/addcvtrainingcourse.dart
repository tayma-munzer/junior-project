import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';

class AddCVTrainingCourse extends StatefulWidget {
  const AddCVTrainingCourse({Key? key}) : super(key: key);

  @override
  State<AddCVTrainingCourse> createState() => _AddCVTrainingCourseState();
}

class _AddCVTrainingCourseState extends State<AddCVTrainingCourse> {
  TextEditingController CVCourseNameController = TextEditingController();
  TextEditingController CVTrainingCenterController = TextEditingController();
  TextEditingController CVCompletionDateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String course_name = '';
  String training_center = '';
  String completion_date = '';

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
                Text(' قسم الدورات التدريبية', textAlign: TextAlign.right),
                SizedBox(height: 16.0),
                Text(' اسم الدورة '),
                TextFormField(
                  controller: CVCourseNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل اسم الدورة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم الدورة';
                    }
                    course_name = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('اسم المركز التدريبي'),
                TextFormField(
                  controller: CVTrainingCenterController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      InputDecoration(hintText: 'ادخل اسم المركز التدريبي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم المركز التدريبي ';
                    }
                    training_center = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(' تاريخ انتهاء الدورة '),
                TextFormField(
                  controller: CVCompletionDateController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل تاريخ انتهاء الدورة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '  ادخل تاريخ انتهاء الدورة  ';
                    }
                    completion_date = value;
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
                      AuthCont.add_training_courses(
                              course_name, training_center, completion_date)
                          .then((value) {
                        if (value.statusCode == 200) {
                          print(
                              'training course added to the CV sucessfully successfully');
                        } else {
                          // Error response
                          print(
                              'Failed to add the training course to the CV. Error: ${value.body}');
                        }
                      });
                    }
                  },
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'اضف ',
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.grey),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCVTrainingCourse()),
                          );
                        },
                        child: Text(' تخطي'),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCVTrainingCourse()),
                          );
                        },
                        child: Text(' التالي'),
                      ),
                    ),
                  ],
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
