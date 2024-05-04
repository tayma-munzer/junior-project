import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authcontroller.dart';
import 'package:mobile/drawer.dart';

class addCVLanguages extends StatefulWidget {
  const addCVLanguages({Key? key}) : super(key: key);

  @override
  State<addCVLanguages> createState() => _addCVLanguagesState();
}

class _addCVLanguagesState extends State<addCVLanguages> {
  GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  List lang_type = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Container(),
      bottomNavigationBar: BottomBar(),
    );
  }
}
