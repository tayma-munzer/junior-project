import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';

class fatora extends StatefulWidget {
  //final WebViewController controller;
  const fatora({super.key});

  @override
  State<fatora> createState() => _fatoraState();
}

class _fatoraState extends State<fatora> {
  WebViewController controller = WebViewController()
    ..setJavaScriptMode(JavaScriptMode.unrestricted)
    ..loadRequest(Uri.parse(
        "https://egate-t.fatora.me/start/c699aae9-4db5-4ea8-8bcb-ecbf78b047bb/ar/1"));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("ji");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("استكمال عملية الدفع")),
      body: WebViewWidget(controller: controller),
    );
  }
}
