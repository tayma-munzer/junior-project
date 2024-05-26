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

class _AddPageState extends State {
  String? user;
  String? job;
  String? service;

  Future fetchRoles() async {
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
              Center(child: Image.asset('assets/add.png', width: 300)),
              service == 'true' ? SizedBox(height: 20) : Container(),
              service == 'true'
                  ? Card(
                      color: Color.fromARGB(255, 255, 227, 184),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddService(),
                              ),
                            );
                          },
                          child: Icon(Icons.add),
                        ),
                        title: Text('اضف خدمتك الخاصة',
                            textAlign: TextAlign.right),
                        subtitle: Text(
                          'وابدأ باكتساب ارباحك',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  : Container(),
              service == 'true' ? SizedBox(height: 20) : Container(),
              service == 'true'
                  ? Card(
                      color: Color.fromARGB(255, 175, 243, 255),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddCourse(),
                              ),
                            );
                          },
                          child: Icon(Icons.cloud_download),
                        ),
                        title: Text('هل لديك معارف و خبرات تريد نقلها للعالم؟',
                            textAlign: TextAlign.right),
                        subtitle: Text(
                          ' هل تريد ان ترفع الكورس الخاص بك وايصاله لاكبر عدد من المستفيدين؟ سارع برفع الكورس الخاص بك دون أي رسوم',
                          textAlign: TextAlign.right,
                        ),
                      ),
                    )
                  : Container(),
              service == 'true' ? SizedBox(height: 20) : Container(),
              job == 'true'
                  ? Card(
                      color: Color.fromARGB(255, 255, 227, 184),
                      child: ListTile(
                        leading: GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => AddjobPage(),
                              ),
                            );
                          },
                          child: Icon(Icons.search),
                        ),
                        title: Text('ألديك فرصة عمل ؟',
                            textAlign: TextAlign.right),
                        subtitle: Text(
                          ' اتبحث عن موظفين كفؤ بانسب توصيف وظيفي تبحث عنه؟ الافع التوصيف الوظيفي مع كاقة التفاصيل والمتطلبات وانتظر المتدمين للوظيفة واختر الانسب ',
                          textAlign: TextAlign.right,
                        ),
                      ),
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
