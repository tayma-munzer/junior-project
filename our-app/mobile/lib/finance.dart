import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/archiCategory.dart';

import 'package:mobile/bottombar.dart';
import 'package:mobile/buildCatItem.dart';
import 'package:mobile/buildchip.dart';

import 'package:mobile/drawer.dart';
import 'package:mobile/graphicsCategory.dart';
import 'package:mobile/itCategory.dart';
import 'package:mobile/languagecategory.dart';
import 'package:mobile/managmentCategory.dart';

class FinanceCategoryPage extends StatefulWidget {
  @override
  _FinanceCategoryPageState createState() => _FinanceCategoryPageState();
}

class _FinanceCategoryPageState extends State<FinanceCategoryPage> {
  List<String> topChips = [
    "اللغات",
    "تقنية المعلومات",
    "التصميم",
    "الادارة",
    "العمارة",
    "المحاسبة"
  ];
  List<String> itemTitles = [
    "تطوير الواجهة الأمامية",
    "برمجة فلاتر",
    "تصميم الويب",
    "تصميم واجهة المستخدم/تجربة المستخدم",
  ];
  List<String> itemSubTitles = [
    "تعلم تقنيات تطوير الواجهة الأمامية",
    "إنشاء تطبيقات جميلة باستخدام فلاتر",
    "إنشاء تصاميم مواقع ويب رائعة",
    "إتقان فن تصميم واجهة المستخدم/تجربة المستخدم",
  ];
  List<String> itemImages = [
    "https://t4.ftcdn.net/jpg/00/65/77/27/360_F_65772719_A1UV5kLi5nCEWI0BNLLiFaBPEkUbv5Fv.jpg",
    "https://media.geeksforgeeks.org/wp-content/uploads/20230426115225/computer-image-660.jpg",
    "https://classroomclipart.com/image/static7/preview2/simple-open-laptop-computer-59673.jpg",
    "https://media.geeksforgeeks.org/wp-content/uploads/20230426115225/computer-image-660.jpg",
    "https://media.geeksforgeeks.org/wp-content/uploads/20230426115225/computer-image-660.jpg",
  ];
  List<double> itemRatings = [4.5, 4.0, 4.2, 4.8];
  List<Widget> pages = [
    LanguageCategoryPage(),
    ITCategoryPage(),
    GraphicsCategoryPage(),
    ManagmentCategoryPage(),
    ArchiCategoryPage(),
    FinanceCategoryPage()
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          padding: EdgeInsets.only(left: 25.0, top: 20.0, right: 25.0),
          child: Column(
            children: <Widget>[
              Container(
                height: 45.0,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: topChips.length,
                  itemBuilder: (
                    BuildContext context,
                    int index,
                  ) {
                    return Buildchip(
                      topChips[index],
                      pages[index],
                      index,
                    );
                  },
                ),
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: itemTitles.length,
                  itemBuilder: (BuildContext context, int index) {
                    return Column(
                      children: [
                        BuildItem(
                          itemTitles[index],
                          itemSubTitles[index],
                          itemImages[index],
                          itemRatings[index],
                        ),
                        SizedBox(
                          height: 10.0,
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
