import 'package:flutter/material.dart';
import 'package:mobile/addcveducation.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';

class addCVProjects extends StatefulWidget {
  final int cv_id;
  const addCVProjects(this.cv_id, {Key? key}) : super(key: key);

  @override
  State<addCVProjects> createState() => _addCVProjectsState();
}

class _addCVProjectsState extends State<addCVProjects> {
  TextEditingController CVProjectNameController = TextEditingController();
  TextEditingController CVProjectDescController = TextEditingController();
  TextEditingController CVStartDateController = TextEditingController();
  TextEditingController CVEndDateController = TextEditingController();
  TextEditingController CVResponsibilitiesController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String p_name = '';
  String p_desc = '';
  String start_date = '';
  String end_date = '';
  String responsibilities = '';
  List<Map<String, String>> projects = [];
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
                  ': قسم المشاريع ',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                SizedBox(height: 16.0),
                Text(
                  ' عنوان المشروع ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVProjectNameController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل عنوان المشروع '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال عنوان المشروع';
                    }
                    p_name = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' وصف المشروع',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVProjectDescController,
                  maxLines: null,
                  textAlign: TextAlign.right,
                  keyboardType: TextInputType.multiline,
                  decoration: InputDecoration(hintText: 'ادخل وصف المشروع'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال وصف المشروع   ';
                    }
                    p_desc = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' تاريخ البدء في المشروع ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVStartDateController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل تاريخ البدء في المشروع'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '  ادخل تاريخ البدء في المشروع  ';
                    }
                    start_date = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' تاريخ انهاء المشروع ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVEndDateController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل تاريخ انهاء المشروع'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return '  ادخل تاريخ انهاء المشروع  ';
                    }
                    end_date = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'المسؤوليات في المشروع ',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
                TextFormField(
                  controller: CVResponsibilitiesController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'المسؤوليات في المشروع '),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'برجى ادخال مسؤوليات المشروع   ';
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
                      Map<String, String> project = {
                        'p_name': p_name,
                        'p_desc': p_desc,
                        'start_date': start_date,
                        'end_date': end_date,
                        'responsibilities': responsibilities
                      };
                      projects.add(project);
                      print('project added to the list');
                      setState(() {
                        CVProjectNameController.clear();
                        CVProjectDescController.clear();
                        CVStartDateController.clear();
                        CVEndDateController.clear();
                        CVResponsibilitiesController.clear();
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
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ),
                SizedBox(height: 16.0),
                Directionality(
                  textDirection: TextDirection.rtl,
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: projects.length,
                    itemBuilder: (context, index) {
                      final project = projects[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "عنوان المشروع : ${project['p_name']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "وصف المشروع : ${project['p_desc']}",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " تاريخ البدء في المشروع : ${project['start_date']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                " تاريخ انهاء المشروع : ${project['end_date']} ",
                                style: TextStyle(fontSize: 20),
                              ),
                              Text(
                                "  المسؤوليات في المشروع : ${project['responsibilities']} ",
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
                                    addCVEduction(widget.cv_id),
                              ));
                        },
                        child: Text(
                          ' تخطي',
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
                          AuthCont.add_projects(
                                  widget.cv_id.toString(), projects)
                              .then((value) {
                            if (value.statusCode == 200) {
                              print(
                                  ' project added to the CV sucessfully successfully');
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        addCVEduction(widget.cv_id)),
                              );
                            } else {
                              // Error response
                              print(
                                  'Failed to add the project to the CV. Error: ${value.body}');
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
