import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/addcvprojects.dart';

class AddCVExperience extends StatefulWidget {
  const AddCVExperience({Key? key}) : super(key: key);

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
                Text(': قسم الخبرة', textAlign: TextAlign.right),
                SizedBox(height: 16.0),
                Text(' اسم الشركة او مكان العمل '),
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
                Text('االمسمى الوظيفي'),
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
                Text(' تاريخ البدء في العمل '),
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
                Text(' تاريخ انهاء العمل '),
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
                Text('المسؤوليات في العمل '),
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
                      AuthCont.add_exp(position, company, start_date, end_date,
                              responsibilities)
                          .then((value) {
                        if (value.statusCode == 200) {
                          print(
                              ' experince added to the CV sucessfully successfully');
                        } else {
                          // Error response
                          print(
                              'Failed to add the  experince to the CV. Error: ${value.body}');
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
                                builder: (context) => addCVProjects()),
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
                                builder: (context) => addCVProjects()),
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
