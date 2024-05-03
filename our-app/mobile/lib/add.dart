import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(Icons.add),
                  title: Text('اضف خدمتك الخاصة', textAlign: TextAlign.right),
                  subtitle: Text(
                    'وابدأ باكتساب ارباحك',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Add Course Function
                },
                icon: Icon(Icons.arrow_back_ios),
                label: Text('اضف خدمة '),
              ),
              SizedBox(height: 20),
              Card(
                child: ListTile(
                  leading: Icon(Icons.cloud_download),
                  title: Text('هل لديك معارف و خبرات تريد نقلها للعالم؟',
                      textAlign: TextAlign.right),
                  subtitle: Text(
                    '  هل تريد ان ترفع الكورس الخاص بك وايصاله لاكبر عدد من المستفيدين؟ سارع برفع الكورس الخاص بك دون أي رسوم',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Add Course Function
                },
                icon: Icon(Icons.arrow_back_ios),
                label: Text('اضف كورس'),
              ),
              SizedBox(height: 10),
              Card(
                child: ListTile(
                  leading: Icon(Icons.search),
                  title: Text('ألديك فرصة عمل ؟', textAlign: TextAlign.right),
                  subtitle: Text(
                    ' اتبحث عن موظفين كفؤ بانسب توصيف وظيفي تبحث عنه؟ الافع التوصيف الوظيفي مع كاقة التفاصيل والمتطلبات وانتظر المتدمين للوظيفة واختر الانسب ',
                    textAlign: TextAlign.right,
                  ),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Add Course Function
                },
                icon: Icon(Icons.arrow_back_ios),
                label: Text('اضف فرصة عمل'),
              ),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
