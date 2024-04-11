import 'package:flutter/material.dart';

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
              color: Color.fromARGB(255, 255, 225, 181),
            ),
            child: Text(
              ' ',
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
              // Handle Settings tap
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
              // Handle About Us tap
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
              // Handle About Us tap
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
              // Handle About Us tap
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
                    // Handle Option 1 tap
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
                    // Handle Option 2 tap
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
                    // Handle Option 3 tap
                  },
                ),
              ],
            ),
        ],
      ),
    );
  }
}
