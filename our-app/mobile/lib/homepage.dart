import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/drawer.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/viewcoursetobuy.dart';
import 'package:mobile/viewjobtobuy.dart';
import 'package:mobile/viewservicetobuy.dart';
import 'package:mobile/wallet.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State<MainHomePage> createState() => _MainHomePageState();
}

class _MainHomePageState extends State<MainHomePage> {
  int _currentJobIndex = 0;
  int _currentServicesIndex = 0;
  int _currentCoursesIndex = 0;

  List<dynamic> jobs = [];
  List<dynamic> services = [];
  List<dynamic> courses = [];

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

  void fetchCourses() async {
    var url = get_home_page_courses;
    var res = await http.get(Uri.parse(url));
    List<dynamic> data = json.decode(res.body);
    setState(() {
      courses = data.map((item) => item).toList();
      print('courses');
      print(courses);
    });
  }

  @override
  void initState() {
    super.initState();
    fetchJobs();
    fetchServices();
    fetchCourses();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(16.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.end, children: [
            Center(child: Image.asset('assets/homepage.png', width: 300)),

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
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) =>
                              viewjobtobuy(jobs[_currentJobIndex]['j_id'])));
                },
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 227, 184),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              jobs[_currentJobIndex]['j_name'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 66, 62, 62),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              jobs[_currentJobIndex]['j_desc'].toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 66, 62, 62),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentJobIndex = (_currentJobIndex - 1)
                                    .clamp(0, jobs.length - 1);
                              });
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
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
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(),
              ),
            SizedBox(height: 10),
            Text(
              'الخدمات',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            if (services.isNotEmpty)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewservicetobuy(
                              services[_currentServicesIndex]['s_id'])));
                },
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 227, 184),
                          image: DecorationImage(
                            image: NetworkImage(services[_currentServicesIndex]
                                    ['s_image']
                                .toString()),
                            fit: BoxFit.cover,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              services[_currentServicesIndex]['s_name']
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 66, 62, 62),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              services[_currentServicesIndex]['s_desc']
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 66, 62, 62),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentServicesIndex =
                                    (_currentServicesIndex - 1)
                                        .clamp(0, services.length - 1);
                              });
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentServicesIndex =
                                    (_currentServicesIndex + 1)
                                        .clamp(0, services.length - 1);
                              });
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(),
              ),
            SizedBox(height: 10),
            Text(
              'الكورسات',
              textAlign: TextAlign.right,
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            SizedBox(height: 10),
            // course Card with Arrows
            if (courses.isNotEmpty)
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => viewcoursetotobuy(
                              courses[_currentCoursesIndex]['c_id'])));
                },
                child: SizedBox(
                  height: 150,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        height: 100,
                        width: 300,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Color.fromARGB(255, 255, 227, 184),
                        ),
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              courses[_currentCoursesIndex]['c_name']
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 66, 62, 62),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                            Text(
                              courses[_currentCoursesIndex]['c_desc']
                                  .toString(),
                              textAlign: TextAlign.center,
                              style: const TextStyle(
                                color: Color.fromARGB(255, 66, 62, 62),
                                fontWeight: FontWeight.bold,
                                fontSize: 16,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentCoursesIndex =
                                    (_currentCoursesIndex - 1)
                                        .clamp(0, courses.length - 1);
                              });
                            },
                            icon: const Icon(Icons.arrow_back_ios),
                          ),
                          IconButton(
                            onPressed: () {
                              setState(() {
                                _currentCoursesIndex =
                                    (_currentCoursesIndex + 1)
                                        .clamp(0, courses.length - 1);
                              });
                            },
                            icon: const Icon(Icons.arrow_forward_ios),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              )
            else
              const Center(
                child: CircularProgressIndicator(),
              ),
          ]),
        ),
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
