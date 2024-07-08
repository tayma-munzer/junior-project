import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:mobile/buildCatItem.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/editjob.dart';
import 'package:mobile/viewjob.dart';
import 'package:mobile/editjob.dart';

class SearchJob extends StatefulWidget {
  final int jt_id;
  const SearchJob(this.jt_id, {Key? key});

  @override
  State<SearchJob> createState() => _SearchJobState();
}

List jobs = [];

class _SearchJobState extends State<SearchJob> {
  void fetchJobs() async {
    var url = get_jobs_for_type;
    var res = await http
        .post(Uri.parse(url), body: {'jt_id': widget.jt_id.toString()});
    List data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print('test');
      print(jobs);
    });
  }

  String? user;
  String? job;
  String? service;
  TextEditingController _controller = TextEditingController();
  late WebSocket socket;
  List<dynamic>? _searchResults;
  Map<String, dynamic>? results;

  Future fetchRoles() async {
    String? userRole = await AuthManager.isUser();
    String? jobRole = await AuthManager.isjobOwner();
    String? serviceRole = await AuthManager.isserviceOwner();
    setState(() {
      this.user = userRole;
      this.job = jobRole;
      this.service = serviceRole;
    });
  }

  void deleteJob(int j_id) async {
    var url = delete_job;
    var res = await http.post(Uri.parse(url), body: {'j_id': j_id});
    fetchJobs();
  }

  @override
  void initState() {
    super.initState();
    fetchJobs();
    fetchRoles();
    //connect("ws://10.0.2.2:8770"); // هاد استدعي جوا زر البحث و بس
  }

  Future<void> connect(url) async {
    try {
      print("try");
      socket = await WebSocket.connect(url);
      print('WebSocket connected');
      final data = {
        'search_string': _controller.text,
        'jt_id': widget.jt_id.toString()
      };
      socket.add(jsonEncode(data));
      socket.listen(
        (message) {
          print("receive");
          // ********************
          setState(() {
            results = jsonDecode(message);
            print(results);
            _searchResults = results!['jobs'];
            print(_searchResults);
            jobs = _searchResults!;
          });
          // ***********************
        },
        onError: (error) {
          print('WebSocket error: $error');
        },
        onDone: () {
          print('WebSocket connection closed');
        },
      );
      print('WebSocket connection established.');
    } catch (e) {
      print('WebSocket connection failed: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Row(
            children: [
              ElevatedButton(
                onPressed: () {
                  connect("ws://10.0.2.2:8770");
                },
                child: Text('بحث'),
                style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(
                      Color.fromARGB(255, 243, 176, 145)),
                ),
              ),
              Expanded(
                child: TextField(
                  controller: _controller,
                  textAlign: TextAlign.right,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                  ),
                  cursorColor: Colors.black,
                ),
              ),
            ],
          ),
          SizedBox(
            height: 20,
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 5.0,
                  mainAxisSpacing: 5.0,
                ),
                itemCount: jobs.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => viewjob(jobs[index]['j_id']),
                        ),
                      );
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: index % 4 < 2
                            ? Color.fromARGB(255, 146, 206, 255)
                            : Colors.white,
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(0),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            jobs[index]['j_title'],
                            style: TextStyle(fontSize: 20.0),
                          ),
                          Text(
                            jobs[index]['j_desc'],
                            style: TextStyle(fontSize: 16.0),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
