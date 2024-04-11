import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:sarah_junior/settings/help.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

enum PopupType {
  Message,
  TextField,
}

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  double _rating = 3.0;
  bool isSwitchOn = false;
  bool isChatNotificationsOn = false;
  bool isExpanded = false;
  bool isAddExpanded = false;

  void toggleExpansion() {
    setState(() {
      isExpanded = !isExpanded;
    });
  }

  void toggleAddExpansion() {
    setState(() {
      isAddExpanded = !isAddExpanded;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
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
                onTap: toggleAddExpansion,
              ),
              if (isAddExpanded)
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
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(
              children: [
                Text(
                  "الاعدادات",
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.w500),
                ),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: Color.fromARGB(255, 255, 224, 176),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "الحساب",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                buildAccountOptionRow2(context, "المساعدة"),
                buildAccountOptionRow2(context, "المحفظة"),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.volume_up_outlined,
                      color: Color.fromARGB(255, 255, 224, 176),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "الاشعارات",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "نشاطات الحساب",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isSwitchOn = !isSwitchOn;
                        });
                      },
                      child: CupertinoSwitch(
                        value: isSwitchOn,
                        onChanged: (bool value) {
                          setState(() {
                            isSwitchOn = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "اشعارات المحادثات",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w500,
                        color: Colors.grey[600],
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          isChatNotificationsOn = !isChatNotificationsOn;
                        });
                      },
                      child: CupertinoSwitch(
                        value: isChatNotificationsOn,
                        onChanged: (bool value) {
                          setState(() {
                            isChatNotificationsOn = value;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.feedback,
                      color: Color.fromARGB(255, 255, 224, 176),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "رأيك يهمنا",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                buildAccountOptionRow(
                    context, "تقييم التطبيق", PopupType.TextField, ""),
                buildAccountOptionRow2(context, "تواصل معنا"),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: Color.fromARGB(255, 255, 224, 176),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "",
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                buildAccountOptionRow(context, "تبديل الحساب",
                    PopupType.Message, "ٍيتم الذهاب ألى صفحة تسجيل الدخول"),
                buildAccountOptionRow(context, "تسجيل الخروج",
                    PopupType.Message, "هل انت متأكد أنك تريد تسجيل الخروج"),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                Text(
                  "الاصدار 1.0.0",
                  style: TextStyle(fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ],
            ),
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
      onTap: () {},
    );
  }

  Widget buildAccountOptionRow(BuildContext context, String title,
      PopupType popupType, dynamic message) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
            ),
          ),
          GestureDetector(
            onTap: () {
              if (popupType == PopupType.Message) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                      title: Text('انتبه'),
                      content: message is String ? Text(message) : message,
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context); // Close the dialog
                          },
                          child: Text('إغلاق'),
                        ),
                      ],
                    );
                  },
                );
              } else if (popupType == PopupType.TextField) {
                showDialog(
                  context: context,
                  builder: (BuildContext context) {
                    return AlertDialog(
                        title: Text('أضف تقييمك'),
                        content: SingleChildScrollView(
                          child: RatingBar.builder(
                            initialRating: _rating,
                            minRating: 1,
                            direction: Axis.horizontal,
                            allowHalfRating: true,
                            itemCount: 5,
                            itemSize: 18,
                            itemBuilder: (context, _) => Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                            onRatingUpdate: (rating) {
                              setState(() {
                                _rating = rating;
                              });
                            },
                          ),
                        ));
                  },
                );
              }
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

  Widget buildAccountOptionRow2(BuildContext context, String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          GestureDetector(onTap: () {}, child: Icon(Icons.arrow_forward_ios)),
        ],
      ),
    );
  }
}
