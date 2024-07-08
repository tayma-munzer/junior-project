import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/contactus.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/edit_profile.dart';
import 'package:mobile/help.dart';
import 'package:mobile/veiwProfile.dart';
import 'package:mobile/wallet.dart';
import 'package:http/http.dart' as http;
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
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Directionality(
          textDirection: TextDirection.rtl,
          child: Container(
            padding: EdgeInsets.only(left: 16, top: 25, right: 16),
            child: Column(
              children: [
                const Text(
                  "الإعدادات",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
                ),
                const SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.person,
                      color: AppColors.appColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "الحساب",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
                const Divider(
                  height: 15,
                  thickness: 2,
                ),
                SizedBox(
                  height: 10,
                ),
                buildAccountOptionRow2(context, " الملف الشخصي", () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ViewProfile(),
                    ),
                  );
                }),
                buildAccountOptionRow2(context, "المساعدة", () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => HelpPage()),
                  );
                }),
                buildAccountOptionRow2(context, "المحفظة", () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletPage()),
                  );
                }),
                SizedBox(
                  height: 40,
                ),
               /* Row(
                  children: [
                    Icon(
                      Icons.volume_up_outlined,
                      color: AppColors.appColor,
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
                ),*/
               /* SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: 10,
                ),*/
                Row(
                  children: [
                    Icon(
                      Icons.feedback,
                      color: AppColors.appColor,
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    Text(
                      "رأيك يهمنا",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                buildAccountOptionRow2(context, "تواصل معنا", () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ContactUsPage()),
                  );
                }),
                SizedBox(
                  height: 40,
                ),
                Row(
                  children: [
                    Icon(
                      Icons.info,
                      color: AppColors.appColor,
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

                buildAccountOptionRow2(context, "حذف الحساب", () {
                  Navigator.pop(context); // Close the drawer
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => WalletPage()),
                  );
                }),
                SizedBox(height: 40,),
                Divider(
                  height: 15,
                  thickness: 2,
                ),
                Text(
                  "الاصدار 1.0.0",
                  style: TextStyle(fontSize: 12, fontWeight: FontWeight.w400),
                ),
                SizedBox(height: 10,),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  ListTile _buildListTileWithIcon(
      String title, IconData icon, VoidCallback onTap) {
    return ListTile(
      title: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          Text(title),
          SizedBox(width: 10),
          Icon(icon),
        ],
      ),
      onTap: onTap,
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
                        content: RatingBar.builder(
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

  Widget buildAccountOptionRow2(BuildContext context, String title, VoidCallback onTap) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          GestureDetector(
            onTap: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: Text('تأكيد الحذف'),
                    content: Text('هل أنت متأكد أنك تريد حذف الحساب؟'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('إلغاء'),
                      ),
                      TextButton(
                        onPressed: () {
                          // Call the delete account API
                          deleteAccount();
                          Navigator.pop(context); // Close the dialog
                        },
                        child: Text('حذف'),
                      ),
                    ],
                  );
                },
              );
            },
            child: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }

// Function to delete the account
  void deleteAccount() async {
    try {
      final uri = Uri.parse(delete_account); // Convert string to Uri

      final response = await http.post(uri);
print(response.body);
      if (response.statusCode == 200) {
        // Account deleted successfully
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('تم الحذف بنجاح'),
              content: Text('تم حذف الحساب بنجاح.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('حسنًا'),
                ),
              ],
            );
          },
        );
      } else {
        // Failed to delete account
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: Text('فشل في الحذف'),
              content: Text(
                  'حدث خطأ أثناء حذف الحساب. يرجى المحاولة مرة أخرى.'),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context); // Close the dialog
                  },
                  child: Text('حسنًا'),
                ),
              ],
            );
          },
        );
      }
    } catch (e) {
      // Error occurred during the API call
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('خطأ'),
            content: Text('حدث خطأ أثناء إجراء الطلب. يرجى المحاولة مرة أخرى.'),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context); // Close the dialog
                },
                child: Text('حسنًا'),
              ),
            ],
          );
        },
      );
    }
  }}
