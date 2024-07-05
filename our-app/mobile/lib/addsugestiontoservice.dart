import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';

class ServiceSuggetion extends StatefulWidget {
  const ServiceSuggetion({Key? key}) : super(key: key);

  @override
  _ServiceSuggetionState createState() => _ServiceSuggetionState();
}

class _ServiceSuggetionState extends State<ServiceSuggetion> {
  String userInput = '';

  void updateUserInput(String input) {
    setState(() {
      userInput = input;
    });
  }

  void sendSuggestion() {
    if (userInput.isNotEmpty) {
      showDialog(
        context: context,
        builder: (_) => AlertDialog(
          title: Text('تم ارسال اقتراحكم \n شكرا'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('لا يمکن ارسال مقترح فارغ')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Stack(
        children: <Widget>[
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Text(
                  'اختر صلاحياتك',
                  style: TextStyle(fontSize: 25),
                ),
                Card(
                  margin: EdgeInsets.all(20),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      textAlign: TextAlign.right,
                      maxLines: 5,
                      onChanged: (input) {
                        updateUserInput(input);
                      },
                      decoration: InputDecoration(
                        hintText: 'اكتب اقتراحك هنا',
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.send),
                  onPressed: () {
                    sendSuggestion();
                  },
                ),
              ],
            ),
          ),
          Positioned(
            top: 0,
            right: 0,
            child: Image.asset('assets/toppinkcorner.png', width: 300),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            child: Image.asset('assets/bluecorner.png', width: 300),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
