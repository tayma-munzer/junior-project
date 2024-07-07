import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/constant/links.dart';

class viewallaltservices extends StatefulWidget {
  final int s_id;
  const viewallaltservices(this.s_id, {super.key});

  @override
  State<viewallaltservices> createState() => _viewallaltservicesState();
}

class _viewallaltservicesState extends State<viewallaltservices> {
  List<dynamic>? alt_service;
  void fetchallalt_service() async {
    var url = get_all_alt_services;
    var res =
        await http.post(Uri.parse(url), body: {"s_id": widget.s_id.toString()});
    setState(() {
      print(res.body);
      alt_service = json.decode(res.body);
      print(alt_service);
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchallalt_service();
  }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
