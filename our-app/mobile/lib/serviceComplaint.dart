import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'appbar.dart';
import 'constant/links.dart';
import 'controller/authManager.dart';
import 'drawer.dart';

class ComplaintPage extends StatefulWidget {

  final String sId;

  ComplaintPage({ required this.sId});
  @override
  _ComplaintPageState createState() => _ComplaintPageState();
}

class _ComplaintPageState extends State<ComplaintPage> {
  final _formKey = GlobalKey<FormState>();
  String _title = '';
  String _complaint = '';
  @override
  void initState() {
    super.initState();

    print('sId: ${widget.sId}');
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                TextFormField(
                  decoration: InputDecoration(
                    labelText: 'سبب الشكوى',
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please enter the title';
                    }
                    return null;
                  },
                  onChanged: (value) {
                    setState(() {
                      _title = value;
                    });
                  },
                ),
                SizedBox(height: 25.0),
                Flexible(
                  child: TextFormField(
                    maxLines: null,
                    decoration: InputDecoration(
                      labelText: 'مضمون الشكوى',
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the complaint';
                      }
                      return null;
                    },
                    onChanged: (value) {
                      setState(() {
                        _complaint = value;
                      });
                    },
                  ),
                ),
                SizedBox(height: 30.0),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _submitComplaint(); // Call the API to submit the complaint
                    }
                  },
                  child: Text(
                    'إرسال',
                    style: TextStyle(
                      fontSize: 18.0,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  style: ButtonStyle(
                    backgroundColor:
                    MaterialStateProperty.all<Color>(Colors.blue),
                    padding: MaterialStateProperty.all<EdgeInsets>(
                      EdgeInsets.symmetric(horizontal: 80.0, vertical: 10.0),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  void _showConfirmationDialog() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Directionality(
          textDirection: TextDirection.rtl,
          child: AlertDialog(
            title: Text(
              'تم الإرسال',
              style: TextStyle(
                fontSize: 25.0,
                fontWeight: FontWeight.bold,
              ),
            ),
            content: Text(
              'شكرا على تفاعلك, تم اعلام فريقنا بالأمر',
              style: TextStyle(
                fontSize: 20.0,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('تم'),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _submitComplaint() async {
    {
      try {
        if (widget.sId == null) {
          print('Invalid sId');
          return;
        }

        String? token = await AuthManager.getToken();
        var url = add_service_complaint;
        var response = await http.post(Uri.parse(url), body: {
          'description': _complaint,
          'token': token,
          's_id': widget.sId,
        });
        print(token);
print("hello");
        print(response.body); // Print the response body for debugging

        if (response.statusCode == 200) {
          _showConfirmationDialog();
        } else {
          // Handle the error if the complaint submission fails
          print('Complaint submission failed');
        }
      } catch (e) {
        // Handle any network or API-related errors
        print('Error: $e');
      }
    }


}}
