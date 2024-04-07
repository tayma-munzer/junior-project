// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';

class FirstPage extends StatefulWidget {
  const FirstPage({Key? key}) : super(key: key);

  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  bool _isExpanded = false;
  bool _isAddExpanded = false;

  void _toggleExpansion() {
    setState(() {
      _isExpanded = !_isExpanded;
    });
  }

  void _toggleAddExpansion() {
    setState(() {
      _isAddExpanded = !_isAddExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: AppBar(
          backgroundColor: Color.fromARGB(255, 252, 226, 188),
          actions: [
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.notifications_active),
            ),
            IconButton(
              onPressed: () {
                Scaffold.of(context).openDrawer();
              },
              icon: Icon(Icons.arrow_forward),
            ),
          ],
        ),
      ),
      drawer: SizedBox(
        width: MediaQuery.of(context).size.width - 50,
        child: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: <Widget>[
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Color.fromARGB(255, 255, 225, 181),
                ),
                padding: EdgeInsets.all(0.0),
                child: Container(
                  height: 10,
                  child: Center(),
                ),
              ),
              _buildListTileWithIcon('الاعدادات', Icons.settings),
              _buildListTileWithIcon('تواصل معنا', Icons.contact_mail),
              _buildListTileWithIcon('من نحن', Icons.info),
              _buildListTileWithIcon('شروط و قواعد', Icons.rule),
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
                    _buildListTileWithIcon('خدمة', Icons.business),
                    _buildListTileWithIcon('كورس', Icons.book),
                    _buildListTileWithIcon('فرصة عمل', Icons.work),
                  ],
                ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: CurvedNavigationBar(
        height: 47.0,
        backgroundColor: Color.fromARGB(255, 255, 255, 255),
        color: Color.fromARGB(255, 255, 224, 176),
        animationDuration: Duration(milliseconds: 300),
        items: const [
          Icon(Icons.home),
          Icon(Icons.add),
          Icon(Icons.search),
          Icon(Icons.person),
        ],
      ),
    );
  }

  ListTile _buildListTileWithIcon(String title, IconData icon) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title),
          SizedBox(width: 10),
          Icon(icon),
        ],
      ),
      onTap: () {
        // Handle the onTap action
      },
    );
  }
}
