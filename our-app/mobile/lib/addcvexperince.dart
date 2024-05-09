import 'package:flutter/material.dart';
import 'package:mobile/addcvlanguage.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/addcvprojects.dart';

class AddCVExperience extends StatefulWidget {
  final int cv_id;
  const AddCVExperience(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<AddCVExperience> createState() => _AddCVExperienceState();
}

class _AddCVExperienceState extends State<AddCVExperience> {
  TextEditingController CVPositionController = TextEditingController();
  TextEditingController CVCompanyController = TextEditingController();
  TextEditingController CVStartDateController = TextEditingController();
  TextEditingController CVEndDateController = TextEditingController();
  TextEditingController CVResponsibilitiesController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String position = '';
  String company = '';
  String start_date = '';
  String end_date = '';
  String responsibilities = '';
  List<Map<String, String>> experiences = [];

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
                  ': قسم الخبرة',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 16.0),
                Text(
                  ' اسم الشركة او مكان العمل ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVCompanyController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل اسم الشركة او العمل'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال اسم الشركة او مكان العمل';
                    }
                    company = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'المسمى الوظيفي',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVPositionController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل المسمى الوظيفي'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال المسمى الوظيفي  ';
                    }
                    position = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' تاريخ البدء في العمل ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVStartDateController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل تاريخ البدء في العمل'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' يرجى ادخال تاريخ البدء في العمل  ';
                    }
                    start_date = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' تاريخ انهاء العمل ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVEndDateController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل تاريخ انهاء العمل'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' يرجى ادخال تاريخ انهاء العمل  ';
                    }
                    end_date = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'المسؤوليات في العمل ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVResponsibilitiesController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'المسؤوليات في العمل '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return ' يرجى ادخال المسؤوليات التي تم تحملها في العمل   ';
                    }
                    responsibilities = value;
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
                      Map<String, String> experience = {
                        'position': position,
                        'company': company,
                        'start_date': start_date,
                        'end_date': end_date,
                        'responsibilities': responsibilities
                      };
                      experiences.add(experience);
                      print('experience added to the list ');
                      setState(() {
                        CVPositionController.clear();
                        CVCompanyController.clear();
                        CVResponsibilitiesController.clear();
                        CVStartDateController.clear();
                        CVEndDateController.clear();
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
                    itemCount: experiences.length,
                    itemBuilder: (context, index) {
                      final experience = experiences[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                " اسم الشركة او مكان العمل : ${experience['company']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " المسمى الوظيفي : ${experience['position']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "  تاريخ البدء في العمل : ${experience['start_date']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "  تاريخ انهاء العمل : ${experience['end_date']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "  المسؤوليات في العمل : ${experience['responsibilities']} ",
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
                                    addCVLanguages(widget.cv_id)),
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
                          if (_formKey.currentState!.validate()) {
                            AuthCont.add_exp(
                                    widget.cv_id.toString(), experiences)
                                .then((value) {
                              if (value.statusCode == 200) {
                                print(
                                    ' experince added to the CV sucessfully successfully');
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          addCVLanguages((widget.cv_id)),
                                    ));
                              } else {
                                // Error response
                                print(
                                    'Failed to add the  experince to the CV. Error: ${value.body}');
                              }
                            });
                          }
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
