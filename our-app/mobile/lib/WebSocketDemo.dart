import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';
import 'package:web_socket_channel/status.dart' as status;

void main() => runApp(hello());

class hello extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: WebSocketDemo(),
    );
  }
}

// import 'package:web_socket_channel/web_socket_channel.dart';
// import 'package:web_socket_channel/status.dart' as status;

// main() async {
//   final wsUrl = Uri.parse('ws://example.com');
//   final channel = WebSocketChannel.connect(wsUrl);

//   await channel.ready;

//   channel.stream.listen((message) {
//     channel.sink.add('received!');
//     channel.sink.close(status.goingAway);
//   });
// }

class WebSocketDemo extends StatefulWidget {
  @override
  _WebSocketDemoState createState() => _WebSocketDemoState();
}

class _WebSocketDemoState extends State<WebSocketDemo> {
  late WebSocketChannel channel;
  late TextEditingController _controller;

  void start() async {
    final wsUrl = Uri.parse('ws://10.0.2.2:8080');
    channel = WebSocketChannel.connect(wsUrl);
    print('connect');
    // await channel.ready;
    // channel.sink.add('received!');
    // print('sent');
  }

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    start();
    //channel = IOWebSocketChannel.connect('ws://10.0.2.2:8080');

    //     headers: {'Sec-WebSocket-Key': '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'});
    // channel.sink.close();

    //channel = WebSocketChannel.connect(Uri.parse('ws://10.0.2.2:8080'));
    // headers: {'Sec-WebSocket-Key': '258EAFA5-E914-47DA-95CA-C5AB0DC85B11'}));
  }

  @override
  void dispose() {
    channel.sink.close();
    _controller.dispose();
    print('cloooose');
    super.dispose();
  }

  void _sendMessage() async {
    print('hi'); //await channel.ready;
    print('goo');
    // channel.stream.listen((message) {
    channel.sink.add('received!');
    channel.sink.close(status.goingAway);
    print('close');
    // });
    // if (_controller.text.isNotEmpty) {
    //   channel.sink.add(_controller.text);
    //   channel.sink.add("hiiiiiiiiii");
    //   print(_controller.text);
    // }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('WebSocket Demo')),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: _controller,
              decoration: InputDecoration(labelText: 'Send a message'),
            ),
            StreamBuilder(
              stream: channel.stream,
              builder: (context, snapshot) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 24.0),
                  child: Text(snapshot.hasData ? '${snapshot.data}' : ''),
                );
              },
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _sendMessage,
        tooltip: 'Send message',
        child: Icon(Icons.send),
      ),
    );
  }
}
