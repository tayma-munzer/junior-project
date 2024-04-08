import 'package:flutter/material.dart';
import 'package:sarah_junior/settings/settings_.dart';
import 'package:sarah_junior/settings/settings_.dart';
import 'package:sarah_junior/settings/help.dart';

class SettingsUI extends StatelessWidget {
  const SettingsUI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Setting UI",
      home: SettingsPage(),
    );
  }
}

void main() {
  runApp(const SettingsUI());
}
