import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'package:mobile/appbar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/bottombar.dart';
import 'dart:async';
import 'package:mobile/constant/links.dart';
import 'package:mobile/services_types.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'dart:typed_data';

class AddService extends StatefulWidget {
  const AddService({Key? key}) : super(key: key);

  @override
  State<AddService> createState() => _AddServiceState();
}

class _AddServiceState extends State<AddService> {
  String selectedMainCategory = 'Category 1';
  String selectedSecondaryCategory = 'Subcategory 1';
  String selectedDuration = '1 hour';
  final FocusNode _focusNode = FocusNode();
  final ImagePicker _picker = ImagePicker();
  XFile? image;
  List<String> images = [];
  File? _imageFile;
  String? _savedImagePath;
  String? base64Image;
  String durationOrCalendar = 'duration';
  DateTime? selectedDate;
  int durationInDays = 0;
  String? image_name;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  List first_type = [];
  List sec_type = [];

  void fetch() async {
    var url1 = services_first_type;
    var res = await http.get(Uri.parse(url1));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      first_type = data.map((item) => item).toList();
      selectedMainCategory = first_type[0]['type'];
    });
  }

  int calculateDaysDifference(DateTime startDate, DateTime endDate) {
    return endDate.difference(startDate).inDays;
  }

  void fetchnext() async {
    var url2 = get_all_services_second_types;
    var res2 = await http.get(Uri.parse(url2));
    List<dynamic> data2 = json.decode(res2.body);
    setState(() {
      sec_type = data2.map((item) => item).toList();
      selectedSecondaryCategory = sec_type[0]['sec_type'];
    });
  }

  void fetch_sec_types(type) async {
    String type_id = '';
    for (var item in first_type) {
      if (item['type'] == type) {
        type_id = item['t_id'].toString();
      }
    }
    var url2 = services_second_type;
    var res2 = await http.post(Uri.parse(url2), body: {"t_id": type_id});
    List<dynamic> data = json.decode(res2.body);
    setState(() {
      sec_type = data.map((item) => item).toList();
      selectedSecondaryCategory = sec_type[0]['sec_type'];
    });
  }

  @override
  void initState() {
    super.initState();
    fetch();
    fetchnext();
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  late Directory documentDirectory;
  Future<void> _getImageFromGallery() async {
    final image = await ImagePicker().pickImage(source: ImageSource.gallery);
    if (image != null) {
      _imageFile = File(image.path);
      image_name = image.name;
    }
    if (_imageFile != null) {
      final imageBytes = await _imageFile!.readAsBytes();
      setState(() {
        base64Image = base64Encode(imageBytes);
      });
    }
  }

  String service_name = "";
  String service_price = "";
  String service_desc = "";
  String service_duration = "";
  String service_sec_type = "";
  String service_img = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: <Widget>[
                Center(child: Image.asset('assets/service.png', width: 200)),
                SizedBox(
                  height: 20,
                ),
                Text(
                  'اسم الخدمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'اجعل الاسم مختصر و واضح',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.text_fields),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال اسم الخدمة';
                    } else {
                      service_name = value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'سعر الخدمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'على سعر الخدمة 50000 كحد ادنى',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.attach_money),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال سعر الخدمة';
                    }
                    if (double.tryParse(value) == null ||
                        double.parse(value) < 50000) {
                      return 'الرجاء إدخال قيمة صحيحة أكبر من 50000';
                    } else {
                      service_price = value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 30),
                Text(
                  'التصنيف الرئيسي',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedMainCategory,
                  items: first_type.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['type'],
                      child: Text(value['type'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (value) {
                    setState(() {
                      selectedMainCategory = value!;
                      fetch_sec_types(value.trim());
                    });
                  },
                  icon: SizedBox.shrink(),
                ),
                SizedBox(height: 10),
                Text(
                  'التصنيف الفرعي',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                DropdownButton<String>(
                  value: selectedSecondaryCategory,
                  items: sec_type.map((value) {
                    return DropdownMenuItem<String>(
                      value: value['sec_type'],
                      child:
                          Text(value['sec_type'], textAlign: TextAlign.right),
                    );
                  }).toList(),
                  onChanged: (String? value) {
                    setState(() {
                      selectedSecondaryCategory = value!;
                      service_sec_type = value;
                    });
                  },
                  icon: SizedBox.shrink(),
                ),
                SizedBox(height: 10),
                Text(
                  'الوصف',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: 'ادخل وصفا عن خدمتك',
                    contentPadding: EdgeInsets.only(top: 20),
                    prefixIcon: Icon(Icons.description),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'الرجاء إدخال وصف للخدمة';
                    } else {
                      service_desc = value;
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                Text(
                  'مدة الخدمة',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),

                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'مدة',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Radio(
                      value: 'duration',
                      groupValue: durationOrCalendar,
                      onChanged: (value) {
                        setState(() {
                          durationOrCalendar = value!;
                        });
                      },
                    ),
                    Expanded(
                      child: Container(
                        alignment: Alignment.centerRight,
                        child: Text(
                          'تقويم',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),
                    Radio(
                      value: 'calendar',
                      groupValue: durationOrCalendar,
                      onChanged: (value) {
                        setState(() {
                          durationOrCalendar = value!;
                        });
                      },
                    ),
                  ],
                ),

                if (durationOrCalendar == 'calendar')
                  ElevatedButton(
                    onPressed: () async {
                      final DateTime? picked = await showDatePicker(
                        context: context,
                        initialDate: DateTime.now(),
                        firstDate: DateTime.now(),
                        lastDate: DateTime(2101),
                      );
                      if (picked != null && picked.isAfter(DateTime.now())) {
                        setState(() {
                          selectedDate = picked;
                          durationInDays =
                              calculateDaysDifference(DateTime.now(), picked);
                        });
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content: Text('التاريخ يجب أن يكون في المستقبل'),
                        ));
                      }
                    },
                    child: const Text('اختر التاريخ'),
                  )
                else
                  TextFormField(
                    keyboardType: TextInputType.number,
                    onChanged: (value) {
                      setState(() {
                        selectedDate = null;
                        durationInDays = int.tryParse(value) ?? 0;
                      });
                    },
                    decoration: InputDecoration(
                      hintText: 'المدة بالساعات',
                    ),
                    textAlign: TextAlign.right,
                  ),
// عرض التاريخ المتاح
                if (selectedDate != null)
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        'التاريخ المحدد: ${DateFormat('yyyy-MM-dd').format(selectedDate!)}',
                        textAlign: TextAlign.right,
                      ),
                      Text(
                        'عدد الأيام المتبقية: $durationInDays',
                        textAlign: TextAlign.right,
                      ),
                    ],
                  )
                else if (durationInDays > 0)
                  Text(
                    'المدة المحددة: $durationInDays ساعات',
                    textAlign: TextAlign.right,
                  ),
                SizedBox(height: 30),
                Text(
                  'قواعد للمشتريين',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                TextFormField(
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    hintText: ' ',
                    contentPadding: EdgeInsets.only(top: 50),
                    prefixIcon: Icon(Icons.rule),
                  ),
                ),
                SizedBox(height: 20),
                Text(
                  'الصور',
                  textAlign: TextAlign.right,
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                      height: 250,
                      width: 250,
                      child: base64Image != null
                          ? Image.memory(base64Decode(base64Image!))
                          : Text('لا يوجد صور للعرض')),
                ),

                Center(
                  child: Column(
                    children: [
                      ElevatedButton(
                        onPressed: _getImageFromGallery,
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 50)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                          'اضف صورة',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                      SizedBox(height: 10),
                      ElevatedButton(
                        onPressed: () {
                          if (_formKey.currentState!.validate()) {
                            print(service_name);
                            print(service_price);
                            print(service_sec_type);
                            print(service_desc);
                            print(selectedDuration);
                            print(base64Image);
                            print(image_name);
                            AuthCont.addService(
                                    service_name,
                                    service_price,
                                    service_sec_type,
                                    service_desc,
                                    selectedDuration,
                                    base64Image!,
                                    image_name!)
                                .then((value) {
                              if (value.statusCode == 200) {
                                print('Service added successfully');
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => services_types()),
                                );
                              } else {
                                // Error response
                                print(
                                    'Failed to add service. Error: ${value.body}'); //${value.body}
                              }
                            });
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStateProperty.all<Color>(Colors.blue),
                          minimumSize: MaterialStateProperty.all<Size>(
                              Size(double.infinity, 50)),
                          foregroundColor:
                              MaterialStateProperty.all<Color>(Colors.white),
                        ),
                        child: Text(
                          '   اضف خدمة    ',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ],
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
