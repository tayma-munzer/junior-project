import 'package:flutter/material.dart';
import 'package:mobile/addcourse.dart';

import 'package:mobile/addservice.dart';
import 'package:mobile/addsugestiontoservice.dart';

import 'package:mobile/controller/authManager.dart';

import 'package:mobile/settings_.dart';
import 'package:mobile/veiwProfile.dart';
import 'package:mobile/view%20_my_services_admin.dart';
import 'package:mobile/viewCV.dart';
import 'package:mobile/view_inrolled_courses.dart';
import 'package:mobile/view_inrolled_services.dart';
import 'package:mobile/view_my_courses_admin.dart';

import 'package:mobile/addjob.dart';
import 'package:mobile/addcvmaininfo.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/viewjobs.dart';

class CustomDrawer extends StatefulWidget {
  @override
  _CustomDrawerState createState() => _CustomDrawerState();
}

class _CustomDrawerState extends State<CustomDrawer> {
  bool _isAddExpanded = false;

  void _toggleAddExpansion() {
    setState(() {
      _isAddExpanded = !_isAddExpanded;
    });
  }

  String? user;
  String? job;
  String? service;

  Future<void> fetchRoles() async {
    String? userRole = await AuthManager.isUser();
    String? jobRole = await AuthManager.isjobOwner();
    String? serviceRole = await AuthManager.isserviceOwner();
    setState(() {
      this.user = userRole;
      this.job = jobRole;
      this.service = serviceRole;
    });
  }

  @override
  void initState() {
    super.initState();
    fetchRoles();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: AppColors.appbarColor,
            ),
            child: Text(
              " ",
              style: TextStyle(
                color: Colors.white,
                fontSize: 28,
              ),
            ),
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('اعدادات'),
                SizedBox(width: 10),
                Icon(Icons.settings),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SettingsPage()),
              );
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(' الحساب الشخصي'),
                SizedBox(width: 10),
                Icon(Icons.person),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ViewProfile()),
              );
            },
          ),
          job == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('عرض فرص العمل الخاصة بي'),
                      SizedBox(width: 10),
                      Icon(Icons.view_carousel),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ViewJobs()),
                    );
                  },
                )
              : Container(),
          user == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(' سيرتي الذاتية'),
                      SizedBox(width: 10),
                      Icon(Icons.view_comfortable),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => viewcv()),
                    );
                  },
                )
              : Container(),
          service == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('عرض الخدمات الخاصة بي'),
                      SizedBox(width: 10),
                      Icon(Icons.view_array),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewServices(),
                        ));
                  },
                )
              : Container(),
          service == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('عرض الكورسات الخاصة بي'),
                      SizedBox(width: 10),
                      Icon(Icons.view_array),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewCourses(),
                        ));
                  },
                )
              : Container(),
          user == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('عرض الكورسات المسجلة'),
                      SizedBox(width: 10),
                      Icon(Icons.view_array),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewCourses2(),
                        ));
                  },
                )
              : Container(),
          user == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('عرض الخدمات المسجلة'),
                      SizedBox(width: 10),
                      Icon(Icons.view_array),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ViewServices2(),
                        ));
                  },
                )
              : Container(),
          service == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(' اقتراح لخدمة غير موجودة'),
                      SizedBox(width: 10),
                      Icon(Icons.new_label),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => ServiceSuggetion()),
                    );
                  },
                )
              : Container(),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('اضف'),
                SizedBox(width: 10),
                Icon(Icons.add),
              ],
            ),
            onTap: _toggleAddExpansion,
          ),
          if (_isAddExpanded)
            Column(
              children: [
                service == 'true'
                    ? ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(' خدمة'),
                            SizedBox(width: 10),
                            Icon(Icons.business),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddService()),
                          );
                        },
                      )
                    : SizedBox(),
                service == 'true'
                    ? ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('كورس'),
                            SizedBox(width: 10),
                            Icon(Icons.book),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCourse()),
                          );
                        },
                      )
                    : SizedBox(),
                job == 'true'
                    ? ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('عمل'),
                            SizedBox(width: 10),
                            Icon(Icons.work),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddjobPage()),
                          );
                        },
                      )
                    : SizedBox(),
                user == 'true'
                    ? ListTile(
                        title: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text('سيرة ذاتية'),
                            SizedBox(width: 10),
                            Icon(Icons.edit_document),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AddCVMain()),
                          );
                        },
                      )
                    : SizedBox(),
              ],
            ),
        ],
      ),
    );
  }
}
