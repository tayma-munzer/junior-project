import 'package:flutter/material.dart';
import 'package:mobile/addcourse.dart';
import 'package:mobile/addcveducation.dart';
import 'package:mobile/addcvskills.dart';
import 'package:mobile/addservice.dart';
import 'package:mobile/addvideo.dart';
import 'package:mobile/contactus.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/listCourses.dart';
import 'package:mobile/rules.dart';
import 'package:mobile/settings_.dart';
import 'package:mobile/viewCV.dart';
import 'package:mobile/viewallJobs.dart';
import 'package:mobile/viewservice.dart';
import 'package:mobile/viewvideo.dart';
import 'package:mobile/whoarewe.dart';
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
    // TODO: implement initState
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
                fontSize: 24,
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
                Text('تواصل معنا'),
                SizedBox(width: 10),
                Icon(Icons.contact_mail),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ContactUsPage()),
              );
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('من نحن'),
                SizedBox(width: 10),
                Icon(Icons.info),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => WhoPage()),
              );
            },
          ),
          ListTile(
            title: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text('شروط و قواعد'),
                SizedBox(width: 10),
                Icon(Icons.rule),
              ],
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => RulesPage()),
              );
            },
          ),
          job == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text('فرص العامل الخاصة بي'),
                      SizedBox(width: 10),
                      Icon(Icons.rule),
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
                      Text('عرض حميع فرص العمل'),
                      SizedBox(width: 10),
                      Icon(Icons.rule),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => viewallJobs()),
                    );
                  },
                )
              : Container(),
          service == 'true'
              ? ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(' الدورات التعليمية الخاصة بي'),
                      SizedBox(width: 10),
                      Icon(Icons.rule),
                    ],
                  ),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => ListCourses()),
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
                            Text('cv'),
                            SizedBox(width: 10),
                            Icon(Icons.work),
                          ],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => viewservice(2)),
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
