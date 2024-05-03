import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class AddjobPage extends StatefulWidget {
  const AddjobPage({Key? key}) : super(key: key);

  @override
  State<AddjobPage> createState() => _AddjobPageState();
}

class _AddjobPageState extends State<AddjobPage> {
  TextEditingController jobTitleController = TextEditingController();
  TextEditingController jobDescriptionController = TextEditingController();
  TextEditingController jobSalaryController = TextEditingController();
  TextEditingController jobRequirementsController = TextEditingController();

  GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String j_name = '';
  String j_desc = '';
  int j_sal = 0;
  String j_req = '';

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
                SizedBox(height: 16.0),
                Text('اسم الوظيفة'),
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
                Text('التوصيف الوظيفي'),
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
                Text('الراتب'),
                TextFormField(
                  controller: jobSalaryController,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(hintText: 'ادخل الراتب'),
                  validator: (value) {
                    if (value == null ||
                        value.isEmpty ||
                        !RegExp(r'^[0-9]*$').hasMatch(value)) {
                      return 'يرجى ادخال رقم صحيح للراتب';
                    }
                    j_sal = int.parse(value);
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text('المتطلبات الوظيفية'),
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
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor:
                        MaterialStateProperty.all<Color>(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      //هون يفترض حط ال api
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
