import 'package:flutter/material.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/widgets.dart';
import 'package:sarah_junior/settings/help.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
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
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: ListView(
            children: [
              const Text(
                "تعديل الملف الشخصي",
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.w500,
                ),
                textDirection: TextDirection.rtl,
              ),
              //create space between the text and picture
              SizedBox(
                height: 15,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                      width: 130,
                      height: 130,
                      decoration: BoxDecoration(
                          border: Border.all(
                            width: 4,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          boxShadow: [
                            BoxShadow(
                                spreadRadius: 2,
                                blurRadius: 10,
                                color: Colors.black.withOpacity(0.1),
                                offset: Offset(0, 10))
                          ],
                          shape: BoxShape.circle,
                          image: DecorationImage(
                            fit: BoxFit.cover,
                            image: NetworkImage(
                                "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg"),
                          )),
                    ),
                    InkWell(
                      onTap: () {
                        // Add your button's onTap logic here
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        height: 40,
                        width: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          color: Color(0xFFFFE0B1),
                        ),
                        child: Icon(
                          Icons.edit,
                          color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              SizedBox(
                height: 35,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: [
                    buildTextField("الاسم", "سارة عماد", false),
                    buildTextField(
                        "البريد الالكتروني", "sarah@gmail.com", false),
                    buildTextField("كلمة المرور", "****", true),
                    buildTextField("اسم المستخدم", "سارةة", false),
                  ],
                ),
              ),
              SizedBox(
                height: 38,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE0B1),
                      padding: EdgeInsets.symmetric(horizontal: 50),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "CANCEL",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color(0xFFFFE0B1),
                      padding: EdgeInsets.symmetric(horizontal: 60),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                    ),
                    child: Text(
                      "SAVE",
                      style: TextStyle(
                        fontSize: 14,
                        letterSpacing: 2.2,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              )
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

  Widget buildTextField(
    String labelText,
    String placeholder,
    bool isPasswordTextField,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextField(
        obscureText: isPasswordTextField && !showPassword,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showPassword = !showPassword;
                    });
                  },
                  icon: Icon(
                    Icons.remove_red_eye,
                    color: Colors.grey,
                  ),
                )
              : null,
          contentPadding: const EdgeInsets.only(bottom: 3),
          labelText: labelText,
          floatingLabelBehavior: FloatingLabelBehavior.always,
          hintText: placeholder,
          hintStyle: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color.fromARGB(255, 54, 54, 54),
          ),
        ),
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
}
