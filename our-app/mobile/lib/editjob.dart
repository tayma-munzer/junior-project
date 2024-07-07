import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';

class EditJob extends StatefulWidget {
  final int j_id;

  const EditJob(this.j_id, {Key? key}) : super(key: key);

  @override
  State createState() => _EditJobState();
}

class _EditJobState extends State<EditJob> {
  Map<String, dynamic>? jobdetails = {};
  final _formKey = GlobalKey<FormState>();
  TextEditingController _nameController = TextEditingController();
  TextEditingController _descController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();
  TextEditingController _minimumsalController = TextEditingController();
  TextEditingController _maxmumsalController = TextEditingController();
  TextEditingController _minimumageController = TextEditingController();
  TextEditingController _maximumageController = TextEditingController();
  TextEditingController _educationController = TextEditingController();
  TextEditingController _yearsofexperinceController = TextEditingController();

  @override
  void initState() {
    super.initState();
    fetchjobdetails();
  }

  void fetchjobdetails() async {
    var url = get_job;
    var res =
        await http.post(Uri.parse(url), body: {"j_id": widget.j_id.toString()});
    setState(() {
      jobdetails = json.decode(res.body);
      _nameController.text = jobdetails!['job']['j_title'].toString();
      _descController.text = jobdetails!['job']['j_desc'].toString();
      _minimumsalController.text = jobdetails!['job']['j_min_sal'].toString();
      _maxmumsalController.text = jobdetails!['job']['j_max_sal'].toString();
      _minimumageController.text = jobdetails!['job']['j_min_age'].toString();
      _maximumageController.text = jobdetails!['job']['j_max_age'].toString();
      _educationController.text = jobdetails!['job']['education'].toString();
      _yearsofexperinceController.text =
          jobdetails!['job']['num_of_exp_years'].toString();
      _requirementsController.text = jobdetails!['job']['j_req'].toString();

      print(jobdetails);
    });
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
        child: Form(
          key: _formKey,
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 50),
                Image.asset('assets/edit.png', width: 100),
                SizedBox(height: 50),
                _buildJobItem('عنوان الوظيفة', 'j_title', _nameController,
                    (value) {
                  jobdetails!['job']['j_title'] = value;
                }),
                _buildJobItem('التوصيف الوظيفي', 'j_desc', _descController,
                    (value) {
                  jobdetails!['job']['j_desc'] = value;
                }),
                _buildJobItem(
                  'الحد الادنى للراتب',
                  'j_min_sal',
                  _minimumsalController,
                  (value) {
                    jobdetails!['job']['j_min_sal'] = value;
                  },
                ),
                _buildJobItem(
                    ' الحد الاقصى للراتب', 'j_max_sal', _maxmumsalController,
                    (value) {
                  jobdetails!['job']['j_max_sal'] = value;
                }),
                _buildJobItem(
                    '  المتطلبات الوظيفية ', 'j_req', _requirementsController,
                    (value) {
                  jobdetails!['job']['j_req'] = value;
                }),
                _buildJobItem(
                    '    الحد الادنى للعمر', 'j_min_age', _minimumageController,
                    (value) {
                  jobdetails!['job']['j_min_age'] = value;
                }),
                _buildJobItem(
                    '    الحد الاقصى للعمر', 'j_max_age', _maximumageController,
                    (value) {
                  jobdetails!['job']['j_max_age'] = value;
                }),
                _buildJobItem('      درجة التعليم المطلوبة', 'education',
                    _educationController, (value) {
                  jobdetails!['job']['education'] = value;
                }),
                _buildJobItem('   عدد سنين الخبرة المطلوبة', 'num_of_exp_years',
                    _yearsofexperinceController, (value) {
                  jobdetails!['job']['num_of_exp_years'] = value;
                }),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveJobDetails();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                    minimumSize: MaterialStateProperty.all(Size(300, 50)),
                  ),
                  child: Text(
                    ' حفظ التغيريات',
                    style: TextStyle(
                      color: Color.fromARGB(255, 255, 255, 255),
                      fontSize: 18,
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

  Widget _buildJobItem(String labelText, String key,
      TextEditingController controller, void Function(String) onSave,
      {bool isInteger = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Expanded(
            child: TextFormField(
              controller: controller,
              decoration: InputDecoration(
                hintText: labelText,
                contentPadding:
                    EdgeInsets.symmetric(horizontal: 15, vertical: 10),
              ),
              textAlign: TextAlign.right,
              maxLines: 2,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return 'يرجى ملء الحقل';
                } else if (isInteger && int.tryParse(input) == null) {
                  return 'يرجى ادخال رقم موجب صحيح';
                }
                return null;
              },
              onChanged: (newValue) {
                onSave(newValue);
              },
            ),
          ),
          SizedBox(width: 10),
          Text(
            labelText,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  void _saveJobDetails() {
    print(jobdetails);
    AuthCont.editJob(
      jobdetails!['job']['j_id'].toString(),
      jobdetails!['job']['j_title'].toString(),
      jobdetails!['job']['j_desc'].toString(),
      jobdetails!['job']['j_req'].toString(),
      jobdetails!['job']['j_min_sal'].toString(),
      jobdetails!['job']['j_max_sal'].toString(),
      jobdetails!['job']['j_min_age'].toString(),
      jobdetails!['job']['j_max_age'].toString(),
      jobdetails!['job']['education'].toString(),
      jobdetails!['job']['num_of_exp_years'].toString(),
    ).then((value) {
      if (value.statusCode == 200) {
        print('edit successfully');
      } else {
        print('something went wrong');
        print(value.body);
      }
    });
  }
}
