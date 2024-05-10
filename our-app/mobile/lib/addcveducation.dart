import 'package:flutter/material.dart';
import 'package:mobile/addcvexperince.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';

class addCVEduction extends StatefulWidget {
  final int cv_id;
  const addCVEduction(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<addCVEduction> createState() => _addCVEductionState();
}

class _addCVEductionState extends State<addCVEduction> {
  TextEditingController CVEducationDegreeController = TextEditingController();
  TextEditingController CVEductionUniController = TextEditingController();
  TextEditingController CVEducationGradYearController = TextEditingController();
  TextEditingController CVeducationFieldOfStudyController =
      TextEditingController();
  TextEditingController CVEducationGPAController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String degree = '';
  String uni = '';
  String grad_year = '';
  String field_of_study = '';
  String GPA = '';
  List<Map<String, String>> educations = [];

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
                  ': قسم التعلم ',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 16.0),
                Text(
                  ' اسم الجامعة  ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVEductionUniController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل اسم الجامعة  '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم الجامعة';
                    }
                    uni = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' اختصاص الدراسة ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVeducationFieldOfStudyController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل اختصاصك الدراسي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال التخصص الدراسي   ';
                    }
                    field_of_study = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'سنة التخرج',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVEducationGradYearController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل سنة تخرجك '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' يرجى ادخال سنة التخرج ';
                    }
                    if (!RegExp(r"^\d*\.?\d+$").hasMatch(value)) {
                      return 'الرجاء إدخال رقم موجب';
                    }
                    grad_year = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'درجة الشهادة',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVEducationDegreeController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل درجة الشهادة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء ادخال  درجة الشهادة';
                    }
                    degree = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'معدل التخرج',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVEducationGPAController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل معدل تخرجك'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'ادخل معدل تخرجك';
                    }
                    if (!RegExp(r"^\d*\.?\d+$").hasMatch(value)) {
                      return 'الرجاء إدخال رقم موجب عشري';
                    }
                    GPA = value;
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
                      Map<String, String> education = {
                        'degree': degree,
                        'uni': uni,
                        'grad_year': grad_year,
                        'field_of_study': field_of_study,
                        'gba': GPA
                      };
                      educations.add(education);
                      print('education added to the list');
                      setState(() {
                        CVEducationDegreeController.clear();
                        CVEductionUniController.clear();
                        CVEducationGradYearController.clear();
                        CVEducationGPAController.clear();
                        CVeducationFieldOfStudyController.clear();
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
                    itemCount: educations.length,
                    itemBuilder: (context, index) {
                      final project = educations[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " اسم الجامعة : ${project['uni']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " اختصاص الدراسة : ${project['field_of_study']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " سنة التخرج : ${project['grad_year']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "  درجة الشهادة : ${project['degree']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "   المعدل التراكمي  : ${project['gba']} ",
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
                          backgroundColor: MaterialStateProperty.all(
                              Color.fromARGB(255, 209, 231, 255)),
                        ),
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    AddCVExperience(widget.cv_id)),
                          );
                        },
                        child: Text(
                          'تخطي ',
                          style: TextStyle(
                            color: const Color.fromARGB(255, 7, 7, 7),
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                        ),
                        onPressed: () {
                          AuthCont.add_education(
                                  widget.cv_id.toString(), educations)
                              .then((value) {
                            if (value.statusCode == 200) {
                              print(
                                  ' education added to the CV sucessfully successfully');
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        AddCVExperience(widget.cv_id),
                                  ));
                            } else {
                              // Error response
                              print(
                                  'Failed to add the education to the CV. Error: ${value.body}');
                            }
                          });
                        },
                        child: Text(
                          'التالي ',
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
