import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/addcvtrainingcourse.dart';
import 'package:mobile/viewCV.dart';

class AddSkill extends StatefulWidget {
  final int cv_id;
  const AddSkill(this.cv_id, {Key? key}) : super(key: key);

  @override
  _AddSkillState createState() => _AddSkillState();
}

class _AddSkillState extends State<AddSkill> {
  TextEditingController CVSkillNameController = TextEditingController();
  TextEditingController CVSkillLevelController = TextEditingController();
  TextEditingController CVNumYearsController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, String>> skills = [];

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
                Text(
                  ' اسم المهارة ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextFormField(
                  controller: CVSkillNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل اسم المهارة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم المهارة';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('مستوى الخبرة ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextFormField(
                  controller: CVSkillLevelController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل مستوى خبرتك'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال مستوى الخدمة ';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('عدد سنين الخبرة ',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 20)),
                TextFormField(
                  controller: CVNumYearsController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل عدد سنين الخبرة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' يرجى ادخال عدد سنين الخبرة ';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'الرجاء إدخال رقم صحيح موجب';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      Map<String, String> skill = {
                        's_name': CVSkillNameController.text,
                        's_level': CVSkillLevelController.text,
                        'years_of_exp': CVNumYearsController.text
                      };
                      skills.add(skill);
                      print('skill added to list');
                      setState(() {
                        CVSkillNameController.clear();
                        CVSkillLevelController.clear();
                        CVNumYearsController.clear();
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
                            fontSize: 20),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " اسم المهارة : ${skill['s_name']} ",
                              ),
                              Text(
                                " مستوى الخبرة : ${skill['s_level']}",
                              ),
                              Text(
                                " عدد سنين الخدمة : ${skill['years_of_exp']}  ",
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
                              MaterialStateProperty.all(Colors.blue),
                        ),
                        onPressed: () {
                          AuthCont.add_skills(widget.cv_id.toString(), skills)
                              .then((value) {
                            if (value.statusCode == 200) {
                              print('skill added to the CV successfully');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => viewcv(),
                                ),
                              );
                            } else {
                              print(
                                  'Failed to add the skill to the CV. Error: ${value.body}');
                            }
                          });
                        },
                        child: Text(
                          'حفظ ',
                          style: TextStyle(
                              color: Color.fromARGB(255, 255, 255, 255),
                              fontWeight: FontWeight.bold,
                              fontSize: 20),
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
