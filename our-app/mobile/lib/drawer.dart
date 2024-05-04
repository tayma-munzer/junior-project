import 'package:flutter/material.dart';
import 'package:mobile/addcourse.dart';
import 'package:mobile/addcvskills.dart';
import 'package:mobile/addservice.dart';
import 'package:mobile/contactus.dart';
import 'package:mobile/rules.dart';
import 'package:mobile/settings_.dart';
import 'package:mobile/whoarewe.dart';
import 'package:mobile/addjob.dart';
import 'package:mobile/addcvmaininfo.dart';
import 'package:mobile/colors.dart';

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
                ListTile(
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
                      MaterialPageRoute(builder: (context) => AddService()),
                    );
                  },
                ),
                ListTile(
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
                      MaterialPageRoute(builder: (context) => AddCourse()),
                    );
                  },
                ),
                ListTile(
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
                      MaterialPageRoute(builder: (context) => AddjobPage()),
                    );
                  },
                ),
                ListTile(
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
                      MaterialPageRoute(builder: (context) => AddCVMain()),
                    );
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
