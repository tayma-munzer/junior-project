import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:http/http.dart' as http;

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentJobIndex = 0;
  int _currentServicesIndex = 0;

  List<dynamic> jobs = [];
  List<dynamic> services = [];

  void fetchJobs() async {
    var url = get_home_page_jobs;
    var res = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      jobs = data.map((item) => item).toList();
      print('jobs');
      print(jobs);
    });
  }

  void fetchServices() async {
    var url = get_home_page_services;
    var res = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      services = data.map((item) => item).toList();
      print('services');
      print(services);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchJobs();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: Container(
        padding: const EdgeInsets.all(16.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
          // Jobs Section
          Text(
            'الاعمال',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // Job Card with Arrows
          if (jobs.isNotEmpty)
            SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    height: 100,
                    width: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Job Name
                        Text(
                          jobs[_currentJobIndex]['j_name'].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        // Job Description
                        Text(
                          jobs[_currentJobIndex]['j_desc'].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Arrow
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentJobIndex = (_currentJobIndex - 1)
                                .clamp(0, jobs.length - 1);
                          });
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      // Right Arrow
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentJobIndex = (_currentJobIndex + 1)
                                .clamp(0, jobs.length - 1);
                          });
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
          SizedBox(
            height: 10,
          ),
          Text(
            'الخدمات',
            textAlign: TextAlign.right,
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 10),
          // service Card with Arrows
          if (services.isNotEmpty)
            SizedBox(
              height: 150,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      color: Colors.grey[200],
                    ),
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // service Image
                        Image.network(
                          services[_currentServicesIndex]['s_img'].toString(),
                          height: 50,
                          width: 50,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object error,
                              StackTrace? stackTrace) {
                            return Placeholder(
                              fallbackHeight: 50,
                              fallbackWidth: 50,
                            );
                          },
                        ),

                        // services Description
                        Text(
                          services[_currentServicesIndex]['s_desc'].toString(),
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      // Left Arrow
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentServicesIndex = (_currentServicesIndex - 1)
                                .clamp(0, services.length - 1);
                          });
                        },
                        icon: const Icon(Icons.arrow_back_ios),
                      ),
                      // Right Arrow
                      IconButton(
                        onPressed: () {
                          setState(() {
                            _currentServicesIndex = (_currentServicesIndex + 1)
                                .clamp(0, services.length - 1);
                          });
                        },
                        icon: const Icon(Icons.arrow_forward_ios),
                      ),
                    ],
                  ),
                ],
              ),
            )
          else
            const Center(
              child: CircularProgressIndicator(),
            ),
        ]),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
