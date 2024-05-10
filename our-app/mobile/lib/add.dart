import 'package:flutter/material.dart';
import 'package:mobile/addcourse.dart';
import 'package:mobile/addjob.dart';
import 'package:mobile/addservice.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';

class AddPage extends StatefulWidget {
  const AddPage({Key? key}) : super(key: key);

  @override
  _AddPageState createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
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
              service == 'true' ? SizedBox(height: 20) : Container(),
              service == 'true'
                  ? Card(
                      child: ListTile(
                        leading: Icon(Icons.add),
                        title: Text('اضف خدمتك الخاصة',
                            textAlign: TextAlign.right),
                        subtitle: Text(
                          'وابدأ باكتساب ارباحك',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  : Container(),
              service == 'true' ? SizedBox(height: 10) : Container(),
              service == 'true'
                  ? ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddService()),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      label: Text('اضف خدمة '),
                    )
                  : Container(),
              service == 'true' ? SizedBox(height: 20) : Container(),
              service == 'true'
                  ? Card(
                      child: ListTile(
                        leading: Icon(Icons.cloud_download),
                        title: Text('هل لديك معارف و خبرات تريد نقلها للعالم؟',
                            textAlign: TextAlign.right),
                        subtitle: Text(
                          '  هل تريد ان ترفع الكورس الخاص بك وايصاله لاكبر عدد من المستفيدين؟ سارع برفع الكورس الخاص بك دون أي رسوم',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  : Container(),
              service == 'true' ? SizedBox(height: 10) : Container(),
              service == 'true'
                  ? ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddCourse()),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      label: Text('اضف كورس'),
                    )
                  : Container(),
              service == 'true' ? SizedBox(height: 10) : Container(),
              job == 'true'
                  ? Card(
                      child: ListTile(
                        leading: Icon(Icons.search),
                        title: Text('ألديك فرصة عمل ؟',
                            textAlign: TextAlign.right),
                        subtitle: Text(
                          ' اتبحث عن موظفين كفؤ بانسب توصيف وظيفي تبحث عنه؟ الافع التوصيف الوظيفي مع كاقة التفاصيل والمتطلبات وانتظر المتدمين للوظيفة واختر الانسب ',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  : Container(),
              job == 'true' ? SizedBox(height: 10) : Container(),
              job == 'true'
                  ? ElevatedButton.icon(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => AddjobPage()),
                        );
                      },
                      icon: Icon(Icons.arrow_back_ios),
                      label: Text('اضف فرصة عمل'),
                    )
                  : Container(),
            ],
          ),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
