import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/drawer.dart';

class Viewaltservice extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Center(
        child: Text('Wallet Page Content'),
      ),
    );
  }
}
