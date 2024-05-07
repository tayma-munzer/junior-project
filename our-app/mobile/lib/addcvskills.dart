import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/addcvtrainingcourse.dart';

class AddCVSkills extends StatefulWidget {
  final int cv_id;
  const AddCVSkills(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<AddCVSkills> createState() => _AddCVSkillsState();
}

class _AddCVSkillsState extends State<AddCVSkills> {
  TextEditingController CVSkillNameController = TextEditingController();
  TextEditingController CVSkillLevelController = TextEditingController();
  TextEditingController CVNumYearsController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String s_name = '';
  String s_level = '';
  String years_of_exp = '';
  List<dynamic> skills = [];

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
                Text(': قسم المهارات', textAlign: TextAlign.right),
                SizedBox(height: 16.0),
                Text(' اسم المهارة '),
                TextFormField(
                  controller: CVSkillNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل اسم المهارة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم المهارة';
                    }
                    s_name = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('مستوى الخبرة '),
                TextFormField(
                  controller: CVSkillLevelController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل  مستوى خبرتك'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال مستوى الخدمة ';
                    }
                    s_level = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('عدد سنين الخبرة '),
                TextFormField(
                  controller: CVNumYearsController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل عدد سنين الخبرة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' يرجى ادخال عدد سنين الخبرة  ';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'الرجاء إدخال رقم صحيح موجب';
                    }
                    years_of_exp = value;
                    return null;
                  },
                ),
                // Container(
                //   child: ListView.builder(
                //       itemCount: skills.length,
                //       itemBuilder: (context, index) {
                //         final skill = skills[index];
                //         return ListTile(
                //           title: Text(skill['s_name']),
                //           subtitle: Text(skill['s_level']),
                //           trailing: Text(skill['years_of_exp']),
                //         );
                //       }),
                // ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, dynamic> skill = {
                        's_name': s_name,
                        's_level': s_level,
                        'years_of_exp': years_of_exp
                      };
                      skills.add(skill);
                      print('skill added to list');
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
                                builder: (context) =>
                                    AddCVTrainingCourse(widget.cv_id)),
                          );
                        },
                        child: Text('تخطي '),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          AuthCont.add_skills(widget.cv_id.toString(), skills)
                              .then((value) {
                            if (value.statusCode == 200) {
                              print(
                                  'skill added to the CV sucessfully successfully');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        AddCVTrainingCourse(widget.cv_id)),
                              );
                            } else {
                              // Error response
                              print(
                                  'Failed to add the skill to the CV. Error: ${value.body}');
                            }
                          });
                        },
                        child: Text('التالي '),
                      ),
                    ),
                  ],
                ),

                // Expanded(
                //   child: ListView.builder(
                //       itemCount: skills.length,
                //       itemBuilder: (context, index) {
                //         final skill = skills[index];
                //         return ListTile(
                //           title: Text(skill['s_name']),
                //           subtitle: Text(skill['s_level']),
                //           trailing: Text(skill['years_of_exp']),
                //         );
                //       }),
                // )
                // Column(
                //   children: [
                //     ListView.builder(
                //         itemCount: skills.length,
                //         itemBuilder: (context, index) {
                //           final skill = skills[index];
                //           return ListTile(
                //             title: Text(skill['s_name']),
                //             subtitle: Text(skill['s_level']),
                //             trailing: Text(skill['years_of_exp']),
                //           );
                //         }),
                //   ],
                // )
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
