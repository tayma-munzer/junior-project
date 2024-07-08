import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constant/links.dart';

class Editaltservice extends StatefulWidget {
  final int a_id;

  const Editaltservice(this.a_id, {Key? key}) : super(key: key);

  @override
  State<Editaltservice> createState() => _EditaltserviceState();
}

class _EditaltserviceState extends State<Editaltservice> {
  Map<String, dynamic> altserivesdetails = {};
  TextEditingController nameController = TextEditingController();
  TextEditingController priceController = TextEditingController();
  TextEditingController addeddurationController = TextEditingController();

  void fetch() async {
    var url = get_alt_service;
    var res =
        await http.post(Uri.parse(url), body: {'a_id': widget.a_id.toString()});
    Map<String, dynamic> data = json.decode(res.body);
    altserivesdetails = data;
    nameController.text = altserivesdetails['a_name'] ?? '';
    priceController.text = altserivesdetails['a_price'].toString() ?? '';
    addeddurationController.text =
        altserivesdetails['added_duration'].toString() ?? '';
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    fetch();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: [
                  SizedBox(
                    height: 150,
                  ),
                  Text(
                    'خدمة لاحقة',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),
                  SizedBox(height: 10),
                  buildTextField(
                      ' اسم الخدمة اللاحقة', nameController, (value) {}),
                  buildTextField(
                      'سعر الخدمة اللاحقة', priceController, (value) {}),
                  buildTextField(
                      'المدة المضافة', addeddurationController, (value) {}),
                  SizedBox(height: 20),
                  SizedBox(
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        if (nameController.text.isNotEmpty &&
                            priceController.text.isNotEmpty &&
                            addeddurationController.text.isNotEmpty) {
                          saveValues();
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'يرجى ملء جميع الحقول',
                                textAlign: TextAlign.right,
                                style: TextStyle(color: Colors.white),
                              ),
                            ),
                          );
                        }
                      },
                      style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.all(Colors.blue),
                        minimumSize: MaterialStateProperty.all(Size(300, 40)),
                      ),
                      child: Text('حفظ',
                          style: TextStyle(color: Colors.white, fontSize: 18)),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildTextField(String label, TextEditingController controller,
      String? Function(String) validator) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: TextFormField(
        controller: controller,
        textAlign: TextAlign.right,
        decoration: InputDecoration(
          labelText: label,
          border: OutlineInputBorder(),
        ),
      ),
    );
  }

  void saveValues() {
    String name = nameController.text;
    String price = priceController.text;
    String addeddduration = addeddurationController.text;

    print('name: $name');
    print('price: $price');
    print('addeddduration: $addeddduration');
    print('alt id id: ${altserivesdetails['a_id']}');
    var url = edit_alt_service;
    http.post(Uri.parse(url), body: {
      'a_id': altserivesdetails['a_id'].toString(),
      'a_name': name,
      'a_price': price,
      'added_duration': addeddduration,
    });
  }
}
