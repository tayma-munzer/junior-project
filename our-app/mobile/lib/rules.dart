// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class RulesPage extends StatefulWidget {
  const RulesPage({Key? key}) : super(key: key);

  @override
  State<RulesPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<RulesPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Container(
          //قواعد و شروط التطبيق
          ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
