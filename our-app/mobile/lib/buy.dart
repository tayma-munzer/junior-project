// ignore_for_file: unused_import
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';

class BuyPage extends StatefulWidget {
  final int s_id;

  const BuyPage(this.s_id, {Key? key}) : super(key: key);
  @override
  State<BuyPage> createState() => _BuyPageState();
}

class _BuyPageState extends State<BuyPage> {
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
