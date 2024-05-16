import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/addcvprojects.dart';
import 'package:mobile/viewCV.dart';

class AddTrainingCourse extends StatefulWidget {
  final int cv_id;
  const AddTrainingCourse(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<AddTrainingCourse> createState() => _AddTrainingCourseState();
}

class _AddTrainingCourseState extends State<AddTrainingCourse> {
  TextEditingController CVCourseNameController = TextEditingController();
  TextEditingController CVTrainingCenterController = TextEditingController();
  TextEditingController CVCompletionDateController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String course_name = '';
  String training_center = '';
  String completion_date = '';
  List<Map<String, String>> courses = [];

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
                Text(
                  ':قسم الدورات التدريبية',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 16.0),
                Text(' اسم الدورة ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                Text('اسم المركز التدريبي',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
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
                Text(' تاريخ انتهاء الدورة ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                TextFormField(
                  controller: CVCompletionDateController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل تاريخ انتهاء الدورة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخل تاريخ انتهاء الدورة  ';
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
                      Map<String, String> course = {
                        'course_name': course_name,
                        'training_center': training_center,
                        'completion_date': completion_date
                      };
                      courses.add(course);
                      print('course added to the list');
                      setState(() {
                        CVCourseNameController.clear();
                        CVTrainingCenterController.clear();
                        CVCompletionDateController.clear();
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
                            fontWeight: FontWeight.bold,
                            fontSize: 16),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: courses.length,
                    itemBuilder: (context, index) {
                      final course = courses[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "اسم الدورة : ${course['course_name']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " اسم مركز التدريب  : ${course['training_center']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " تاريخ انهاء الدورة : ${course['completion_date']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          AuthCont.add_training_courses(
                                  widget.cv_id.toString(), courses)
                              .then((value) {
                            if (value.statusCode == 200) {
                              print(
                                  'training course added to the CV sucessfully successfully');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => viewcv()),
                              );
                            } else {
                              // Error response
                              print(
                                  'Failed to add the training course to the CV. Error: ${value.body}');
                            }
                          });
                        },
                        child: Text(
                          ' التالي',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 16),
                        ),
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
