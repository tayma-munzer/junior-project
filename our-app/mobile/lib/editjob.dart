import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
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
  TextEditingController _salaryController = TextEditingController();
  TextEditingController _requirementsController = TextEditingController();

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
      _nameController.text = jobdetails!['j_name'].toString();
      _descController.text = jobdetails!['j_desc'].toString();
      _salaryController.text = jobdetails!['j_sal'].toString();
      _requirementsController.text = jobdetails!['j_req'].toString();
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
      body: Form(
        key: _formKey,
        child: Center(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: 50),
              Image.asset('assets/edit.png', width: 100),
              SizedBox(height: 50),
              _buildJobItem('اسم الوظيفة', 'j_name', _nameController, (value) {
                jobdetails!['j_name'] = value;
              }),
              _buildJobItem('التوصيف الوظيفي', 'j_desc', _descController,
                  (value) {
                jobdetails!['j_desc'] = value;
              }),
              _buildJobItem(
                  'الراتب (بالليرة السورية)', 'j_sal', _salaryController,
                  (value) {
                jobdetails!['j_sal'] = value;
              }, isInteger: true),
              _buildJobItem('متطلبات الوظيفة', 'j_req', _requirementsController,
                  (value) {
                jobdetails!['j_req'] = value;
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
  }
}
