import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editcv.dart';

class viewcv extends StatefulWidget {
  const viewcv({Key? key}) : super(key: key);

  @override
  State createState() => _viewcvState();
}

class _viewcvState extends State {
  Map mainInfo = {};
  List skills = [];
  List training_courses = [];
  List experience = [];
  List projects = [];

  void fetch() async {
    String? token = await AuthManager.getToken();
    print('object');
    var url = get_all_cv;
    var res = await http.post(Uri.parse(url), body: {'token': token});
    Map<String, dynamic> data = json.decode(res.body);
    List skills = data['skills'];
    Map<String, dynamic> main_info = data['cv'];
    List training_courses = data['training_courses'];
    List experience = data['experience'];
    List projects = data['projects'];
    List education = data['education'];
    List languages = data['languages'];
    print(main_info);
    print(skills);
    print(training_courses);
    print(experience);
    print(projects);
    print(education);
    print(languages);
    setState(() {});
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
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.only(right: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(right: 8.0),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => EditCv()),
                                );
                              },
                            ),
                            Text(
                              ' المعلومات الاساسية',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 20,
                              ),
                              textAlign: TextAlign.right,
                            ),
                          ],
                        ),
                        Text(
                          'بريد الكتروني : ${mainInfo['email']}',
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          'رقم الهاتف : ${mainInfo['phone']}',
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          'العنوان : ${mainInfo['address']}',
                          textAlign: TextAlign.right,
                        ),
                        Text(
                          'الهدف الوظيفي : ${mainInfo['career_obj']}',
                          textAlign: TextAlign.right,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 20,
              ),
              Text(
                'المهارات',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  if (skills.isEmpty)
                    Text('No skills to be displayed')
                  else
                    for (int i = 0; i < skills.length; i++)
                      Container(
                        color: i % 2 == 0
                            ? const Color.fromARGB(255, 168, 216, 255)
                            : Colors.white,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(right: 200.0),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => EditSkill()),
                                // );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ' اسم المهارة : ${skills[i]['s_name']} \n عدد سنين الخبرة : ${skills[i]['years_of_exp']} \n مستوى المهارة :${skills[i]['s_level']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                ],
              ),
              Text(
                'الدورات التدريبية ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  if (training_courses.isEmpty)
                    Text('No courses to be displayed')
                  else
                    for (int i = 0; i < training_courses.length; i++)
                      Container(
                        color: i % 2 == 0
                            ? const Color.fromARGB(255, 168, 216, 255)
                            : Colors.white,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(right: 200.0),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => EditSkill()),
                                // );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ' اسم الدورة : ${training_courses[i]['course_name']} \n اسم مركز التدريب: ${training_courses[i]['training_center']} \n  تاريخ انهاء الدورة :${training_courses[i]['completion_date']}',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                ],
              ),
              Text(
                ' الخبرة ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  if (experience.isEmpty)
                    Text('No exp to be displayed')
                  else
                    for (int i = 0; i < experience.length; i++)
                      Container(
                        color: i % 2 == 0
                            ? const Color.fromARGB(255, 168, 216, 255)
                            : Colors.white,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(right: 200.0),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => EditSkill()),
                                // );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  ' اسم الشركة او مكان العمل : ${experience[i]['company']} \n   المسمى الوظيفي : ${experience[i]['position']} \n  تاريخ البدء في العمل :${experience[i]['start_date']} \n تاريخ انهاءالعمل :${experience[i]['end_name']} \n  المسؤوليات في العمل: ${experience[i]['responsibilities']} ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                ],
              ),
              Text(
                ' المشاريع ',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 10,
                  ),
                  if (projects.isEmpty)
                    Text('No projects to be displayed')
                  else
                    for (int i = 0; i < projects.length; i++)
                      Container(
                        color: i % 2 == 0
                            ? const Color.fromARGB(255, 168, 216, 255)
                            : Colors.white,
                        padding: EdgeInsets.all(10),
                        width: double.infinity,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                              padding: EdgeInsets.only(right: 200.0),
                              icon: Icon(Icons.edit),
                              onPressed: () {
                                // Navigator.push(
                                //   context,
                                //   MaterialPageRoute(
                                //       builder: (context) => EditSkill()),
                                // );
                              },
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Text(
                                  '   عنوان المشروع : ${projects[i]['p_name']} \n  وصف المشروع : ${projects[i]['p_desc']} \n  تاريخ البدء في المشروع :${projects[i]['start_date']} \n تاريخ انهاء العمل :${projects[i]['end_name']} \n  المسؤوليات في المشروع: ${projects[i]['responsibilities']} ',
                                  style: TextStyle(
                                    color: Colors.black,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                ],
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
