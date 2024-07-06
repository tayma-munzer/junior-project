import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/addcvtrainingcourse.dart';

class AddAltService extends StatefulWidget {
  final int s_id;
  const AddAltService(this.s_id, {Key? key}) : super(key: key);

  @override
  _AddAltServiceState createState() => _AddAltServiceState();
}

class _AddAltServiceState extends State<AddAltService> {
  TextEditingController AltServiceTitleController = TextEditingController();
  TextEditingController AltServicePriceController = TextEditingController();
  TextEditingController AltServiceDurationController = TextEditingController();
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String durationOrCalendar = 'duration';
  DateTime? selectedDate;
  int durationInDays = 0;
  String alttitle = '';
  String altprice = '';

  List<Map<String, dynamic>> altservices = [];

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
                Center(child: Image.asset('assets/altservice.png', width: 200)),
                SizedBox(height: 20.0),
                Text(
                  'عنوان الخدمة اللاحقة',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextFormField(
                  controller: AltServiceTitleController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل عنوان الخدمة اللاحقة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال عنوان الخدمة اللاحقة';
                    }
                    alttitle = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  ' سعر الخدمة اللاحقة',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                TextFormField(
                  controller: AltServicePriceController,
                  textAlign: TextAlign.right,
                  decoration:
                      InputDecoration(hintText: 'ادخل سعر الخدمة اللاحقة'),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'يرجى ادخال سعر الخدمة اللاحقة';
                    }
                    if (!RegExp(r'^\d+$').hasMatch(value)) {
                      return 'الرجاء إدخال رقم صحيح موجب';
                    }
                    altprice = value;
                    return null;
                  },
                ),
                SizedBox(height: 16.0),
                Text(
                  'مدة الخدمة اللاحقة',
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Text('بالايام'),
                    Radio(
                      value: 'days',
                      groupValue: durationOrCalendar,
                      onChanged: (value) {
                        setState(() {
                          durationOrCalendar = value.toString();
                        });
                      },
                    ),
                    Text('بالساعات'),
                    Radio(
                      value: 'hours',
                      groupValue: durationOrCalendar,
                      onChanged: (value) {
                        setState(() {
                          durationOrCalendar = value.toString();
                        });
                      },
                    ),
                    Text('لا يوجد مدة مضافة'),
                    Radio(
                      value: 'no_duration',
                      groupValue: durationOrCalendar,
                      onChanged: (value) {
                        setState(() {
                          durationOrCalendar = value.toString();
                        });
                      },
                    ),
                  ],
                ),
                if (durationOrCalendar == 'days')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          ).then((value) {
                            if (value != null) {
                              setState(() {
                                selectedDate = value;
                                durationInDays =
                                    value.difference(DateTime.now()).inDays;
                              });
                            }
                          });
                        },
                        child: Text('اختر التاريخ'),
                      ),
                      if (selectedDate != null)
                        Text('عدد الايام المتبقي: $durationInDays'),
                    ],
                  ),
                if (durationOrCalendar == 'hours')
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextFormField(
                        controller: AltServiceDurationController,
                        textAlign: TextAlign.right,
                        decoration: InputDecoration(
                            hintText: 'ادخل عدد الساعات المطلوبة'),
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return 'الرجاء إدخال عدد ساعات صحيح';
                          }
                          if (int.tryParse(value) == null ||
                              int.parse(value) <= 0) {
                            return 'يرجى ادخال عدد موجب وصحيح';
                          }
                          return null;
                        },
                      ),
                      Text(
                          'عدد الساعات المطلوبة لانجاز العمل: ${AltServiceDurationController.text}'),
                    ],
                  ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      String durationValue;
                      if (durationOrCalendar == 'days') {
                        durationValue = " ايام " + durationInDays.toString();
                      } else if (durationOrCalendar == 'hours') {
                        durationValue =
                            " ساعات " + AltServiceDurationController.text;
                      } else {
                        durationValue = 'لا تستهلك وقت اضافي';
                      }

                      Map<String, dynamic> altservice = {
                        'a_name': AltServiceTitleController.text,
                        'a_price': AltServicePriceController.text,
                        'added_duration': durationValue.toString(),
                      };
                      setState(() {
                        altservices.add(altservice);
                        print('alternative service added to list');
                        AltServiceTitleController.clear();
                        AltServicePriceController.clear();
                        AltServiceDurationController.clear();
                        durationInDays = 0;
                        selectedDate = null;
                      });
                    }
                  },
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'اضافة',
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
                    itemCount: altservices.length,
                    itemBuilder: (context, index) {
                      final altservice = altservices[index];
                      return Container(
                        color: index % 2 == 0
                            ? const Color.fromARGB(255, 163, 214, 255)
                            : Colors.white,
                        child: ListTile(
                          title: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                  "عنوان الخدمة اللاحقة : ${altservice['a_name']}"),
                              Text(
                                  "مدة الخدمة اللاحقة : ${altservice['added_duration']}"),
                              Text(
                                  "سعر الخدمة اللاحقة : ${altservice['a_price']}"),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                SizedBox(height: 16.0),
                ElevatedButton(
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),
                  ),
                  onPressed: () {
                    print(altservices);
                    AuthCont.addaltservice(widget.s_id, altservices)
                        .then((value) {
                      print(value.body);
                      print(value.statusCode);
                    });
                  },
                  child: Container(
                    width: screenWidth - 50,
                    child: Center(
                      child: Text(
                        'حفظ',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 20),
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
