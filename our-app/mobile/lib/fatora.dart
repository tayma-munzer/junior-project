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
        "https://egate-t.fatora.me/start/a8317857-e290-4b6a-a7e0-6302560d58d1/ar/1"));

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("استكمال عملية الدفع")),
      body: WebViewWidget(controller: controller),
    );
  }
}
