import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/colors.dart';
import 'package:mobile/drawer.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({super.key});

  @override
  _EditProfilePageState createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  bool showPassword = false;
  // Define arrays for profile information and image URL
  List<String> labels = [
    "الاسم",
    "الكنية",
    "البريد الالكتروني",
    "كلمة المرور",
    "اسم المستخدم",
    "العمر",
    "التوصيف",
    "ذكر/انثى",
  ];
  List<String> placeholders = [
    "سارة",
    " عماد",
    "sarah@gmail.com",
    "sarah123",
    "سارةة",
    "22",
    "طالبة جامعية",
    "انثى",
  ];
  String networkImageUrl =
      "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
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
                height: 20,
              ),
              Center(
                child: Stack(
                  children: [
                    Container(
                        width: 150,
                        height: 150,
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
                            image: NetworkImage(networkImageUrl),
                          ),
                        )),
                    InkWell(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                      },
                      child: Container(
                        height: 50,
                        width: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(
                            width: 4,
                            color: Color.fromARGB(255, 255, 255, 255),
                          ),
                          color: AppColors.appColor,
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
                height: 40,
              ),
              Directionality(
                textDirection: TextDirection.rtl,
                child: Column(
                  children: List.generate(labels.length, (index) {
                    return buildTextField(
                        labels[index], placeholders[index], index == 3);
                  }),
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
                      backgroundColor: AppColors.appColor,
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
                      backgroundColor: AppColors.appColor,
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
              ),
              SizedBox(
                height: 38,
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }

  Widget buildTextField(
    String labelText,
    String placeholder,
    bool isPasswordTextField,
  ) {
    bool showCurrentPassword = false;

    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0),
      child: TextFormField(
        obscureText: isPasswordTextField ? !showCurrentPassword : false,
        decoration: InputDecoration(
          suffixIcon: isPasswordTextField
              ? IconButton(
                  onPressed: () {
                    setState(() {
                      showCurrentPassword = !showCurrentPassword;
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
        validator: (value) {
          // تمت إضافة وظيفة التحقق من الحقل النصي
          if (value == null || value.isEmpty) {
            return 'الرجاء إدخال $labelText';
          }
          return null;
        },
      ),
    );
  }
}
