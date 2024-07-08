import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/viewjob.dart';
import 'package:http/http.dart' as http;

class AddjobPage extends StatefulWidget {
  const AddjobPage({Key? key}) : super(key: key);

  @override
  State<AddjobPage> createState() => _AddjobPageState();
}

class _AddjobPageState extends State<AddjobPage> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController jobSalaryMinController = TextEditingController();
  TextEditingController jobSalaryMaxController = TextEditingController();
  TextEditingController jobAgeMinController = TextEditingController();
  TextEditingController jobAgeMaxController = TextEditingController();
  TextEditingController jobRequirementsController = TextEditingController();
  TextEditingController jobEducationController = TextEditingController();
  TextEditingController jobExperinceController = TextEditingController();

  TextEditingController skillNameController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List<Map<String, String>> skills = [];
  String selectedskilloption = '';

  String j_name = '';
  String j_desc = '';
  int j_sal_min = 0;
  int j_sal_max = 0;
  int j_age_min = 0;
  int j_age_max = 0;
  String j_req = '';
  String j_edu = '';
  String j_exp = '';
  List types = [];
  String selectedMainCategory = 'Category 1';

  void fetch() async {
    var url1 = get_job_types;
    var res = await http.get(Uri.parse(url1));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      types = data.map((item) => item).toList();
      selectedMainCategory = types[0]['type'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

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
                Center(
                  child: Image.asset('assets/job.png', width: 200),
                ),
                SizedBox(height: 30.0),
                Text(
                  'اسم الوظيفة',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: jobTitleController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل اسم الوظيفة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم الوظيفة';
                    }
                    j_name = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'التوصيف الوظيفي',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: jobDescriptionController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل التوصيف الوظيفي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال التوصيف الوظيفي';
                    }
                    j_desc = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' المتطلبات الوظيفية',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: jobRequirementsController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration:
                      InputDecoration(hintText: 'ادخل المتطلبات الوظيفية'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال المتطلبات الوظيفية';
                    }
                    j_req = value;
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'التصنيف الرئيسي',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedMainCategory,
                  items: types.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['type'],
                      child: Text(value['type'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMainCategory = value!;
                      print(selectedMainCategory);
                    });
                  },
                  icon: SizedBox.shrink(),
                ),
                SizedBox(height: 16.0),
                Text(
                  'الراتب',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: jobSalaryMinController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: 'الراتب الادنى'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال الراتب الادنى المطلوب';
                          }
                          if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                            return 'الراتب يجب ان يكون رقم صحيح ايجابي';
                          }
                          if (int.parse(value) <= 0) {
                            return 'الراتب \nيجب ان يكون رقم صحيح ايجابي';
                          }
                          if (jobSalaryMaxController.text.isNotEmpty &&
                              double.parse(value!) >=
                                  double.parse(jobSalaryMaxController.text)) {
                            return 'الراتب الادنى يجب ان يكون \n اقل من الراتب الاعلى';
                          }
                          j_sal_min = int.parse(value!);
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: jobSalaryMaxController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: 'الراتب الاعلى'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال الراتب الاعلى المطلوب';
                          }
                          if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                            return 'الراتب يجب ان يكون رقم صحيح \nايجابي';
                          }
                          if (int.parse(value) <= 0) {
                            return 'الراتب يجب ان يكون رقم صحيح \nايجابي';
                          }
                          if (jobSalaryMinController.text.isNotEmpty &&
                              double.parse(value!) <=
                                  double.parse(jobSalaryMinController.text)) {
                            return 'الراتب الاعلى يجب ان يكون \n اعلى من الراتب الادنى';
                          }
                          j_sal_max = int.parse(value!);
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 16.0),
                Text(
                  'العمر المطلوب',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: jobAgeMinController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: 'العمر الادنى'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال العمر الادنى المطلوب';
                          }
                          if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                            return 'العمر يجب ان يكون رقم صحيح \nايجابي';
                          }
                          if (int.parse(value) <= 0) {
                            return 'العمر يجب ان يكون رقم صحيح \nايجابي';
                          }
                          if (jobAgeMaxController.text.isNotEmpty &&
                              double.parse(value!) >=
                                  double.parse(jobAgeMaxController.text)) {
                            return 'العمر الادنى يجب ان يكون \n اقل من العمر الاعلى';
                          }
                          j_age_min = int.parse(value!);
                          return null;
                        },
                      ),
                    ),
                    SizedBox(width: 16.0),
                    Expanded(
                      child: TextFormField(
                        controller: jobAgeMaxController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(hintText: 'العمر الاعلى'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'يرجى ادخال العمر الاقصى المطلوب';
                          }
                          if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                            return 'العمر يجب ان يكون رقم صحيح ايجابي';
                          }
                          if (int.parse(value) <= 0) {
                            return 'العمر يجب ان يكون رقم صحيح ايجابي';
                          }
                          if (jobAgeMinController.text.isNotEmpty &&
                              double.parse(value!) <=
                                  double.parse(jobAgeMinController.text)) {
                            return 'العمر الاعى يجب ان يكون \n اعلى من العمر الادنى';
                          }
                          j_age_max = int.parse(value!);
                          return null;
                        },
                      ),
                    ),
                  ],
                ),
                // Skill Section
                SizedBox(height: 16.0),
                Text('المهارات'),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text(' لا يوجد مهارات مطلوبة'),
                    Radio(
                      value: 'noSkills',
                      groupValue: selectedskilloption,
                      onChanged: (value) {
                        setState(() {
                          selectedskilloption = value.toString();
                          if (selectedskilloption == 'noSkills') {
                            skills = [];
                          }
                        });
                      },
                    ),
                    Text('ادخل مهاراتك'),
                    Radio(
                      value: 'addSkills',
                      groupValue: selectedskilloption,
                      onChanged: (value) {
                        setState(() {
                          selectedskilloption = value.toString();
                        });
                      },
                    ),
                  ],
                ),

                if (selectedskilloption == 'addSkills') ...[
                  Text('ادخل اسم المهارة المطلوبة', textAlign: TextAlign.right),
                  TextFormField(
                    controller: skillNameController,
                    textAlign: TextAlign.right,
                    decoration: InputDecoration(hintText: 'اسم المهارة'),
                  ),
                  SizedBox(height: 16.0),
                  ElevatedButton(
                    style: ButtonStyle(
                      backgroundColor: MaterialStateProperty.all(Colors.blue),
                    ),
                    onPressed: () {
                      Map<String, String> skill = {
                        's_name': skillNameController.text,
                      };
                      skills.add(skill);
                      print('Skill added to list');
                      setState(() {
                        skillNameController.clear();
                      });
                    },
                    child: Container(
                      width: screenWidth - 50,
                      child: Center(
                        child: Text(
                          'اضافة',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ),
                  ),
                  SizedBox(height: 16.0),
                  ListView.builder(
                    shrinkWrap: true,
                    itemCount: skills.length,
                    itemBuilder: (context, index) {
                      final skill = skills[index];
                      return Container(
                        color:
                            index % 2 == 0 ? Colors.blue.shade50 : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(" ${skill['s_name']} : اسم المهارة"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ],
                SizedBox(height: 30.0),
                Text(
                  'درجة التعليم المطلوبة ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: jobEducationController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل  درجة التعليم المطلوبة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال درجة التعليم المطلوبة ';
                    }
                    j_edu = value;
                    return null;
                  },
                ),
                SizedBox(height: 30.0),
                Text(
                  '  عدد سنين الخبرة الموجودة ',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  controller: jobExperinceController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                      hintText: 'ادخل عدد سنين الخبرة المطلوبة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال عدد سنين الخبرة المطلوبة';
                    }
                    if (!RegExp(r'^[1-9]\d*$').hasMatch(value)) {
                      return 'عدد السنين يجب ان يكون رقم صحيح ايجابي';
                    }
                    if (int.parse(value) <= 0) {
                      return 'عدد السنين يجب ان يكون رقم صحيح ايجابي';
                    }
                    j_exp = value;
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
                      // print('job name: $j_name');
                      // print('job description: $j_desc');
                      // print('job minimum Salary: $j_sal_min');
                      // print('job maximum Salary: $j_sal_max');
                      // print('job minimum age: $j_age_min');
                      // print('job maximum age: $j_age_max');
                      // print('job requirements: $j_req');
                      // print('job education: $j_edu');
                      // print('job experince: $j_exp');
                      // print('job skill array: ${skills.toString()}');
                      AuthCont.addJob(
                              j_name,
                              j_desc,
                              j_sal_min,
                              j_sal_max,
                              j_req,
                              j_age_min,
                              j_age_max,
                              j_edu,
                              j_exp,
                              selectedMainCategory,
                              skills)
                          .then((value) {
                        print(value.body);
                        print(value.statusCode);
                        int j_id = json.decode(value.body)['j_id'];
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => viewjob(j_id)),
                        );
                      });
                    }
                  },
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'اضف وظيفة',
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
