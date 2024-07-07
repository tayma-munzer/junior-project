import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;

class viewaltservice extends StatefulWidget {
  final int a_id;
  const viewaltservice(this.a_id, {super.key});

  @override
  State<viewaltservice> createState() => _viewaltserviceState();
}

class _viewaltserviceState extends State<viewaltservice> {
  Map<String, dynamic>? alt_service;
  void fetchalt_service() async {
    var url = get_alt_service;
    var res =
        await http.post(Uri.parse(url), body: {"a_id": widget.a_id.toString()});
    setState(() {
      alt_service = json.decode(res.body);
      print(alt_service);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchalt_service();
  }

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
