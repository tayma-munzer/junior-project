import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mobile/appbar.dart';
import 'package:mobile/bottombar.dart';
import 'package:mobile/constant/links.dart';
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/drawer.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/viewjob.dart';

class MainHomePage extends StatefulWidget {
  const MainHomePage({Key? key}) : super(key: key);

  @override
  State createState() => _MainHomePageState();
}

class _MainHomePageState extends State {
  int _currentServiceIndex = 0;
  int _currentCourseIndex = 0;
  int _currentJobIndex = 0;
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

  Future<List<String>> _getAllServices() async {
    return ['Service 1', 'Service 2', 'Service 3', 'Service 4'];
  }

  Future<List<String>> _getAllCourses() async {
    return ['course 1', 'course 2', 'course 3', 'course 4'];
  }

  Future<List<Map<String, String>>> _getAllJobs() async {
    final url = get_user_jobs;
    String? token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {'token': token});

    if (res.statusCode == 200) {
      List<dynamic> data = json.decode(res.body);
      List<Map<String, String>> jobs = data.map((item) {
        return {
          'name': item['j_name'].toString(),
          'description': item['j_desc'].toString(),
        };
      }).toList();

      return jobs;
    } else {
      throw Exception('Failed to load jobs');
    }
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    fetchJobs();
    fetchCourses();
    fetchServices();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(33.0),
        child: CustomAppBar(),
      ),
      drawer: CustomDrawer(),
      body: FutureBuilder<List<String>>(
        future: _getAllServices(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final services = snapshot.data!;
            final startIndex = _currentServiceIndex * 2;
            final endIndex = startIndex + 2;
            final displayedServices = services.sublist(
              startIndex,
              endIndex.clamp(0, services.length),
            );

            return Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'الخدمات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      ListView.builder(
                        scrollDirection: Axis.horizontal,
                        itemCount: displayedServices.length,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 1.0),
                            child: Container(
                              width: 140,
                              height: 130,
                              margin: const EdgeInsets.only(left: 31),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.blue,
                              ),
                              child: Center(
                                child: Text(
                                  displayedServices[index],
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                  ),
                                  textAlign: TextAlign.right,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                      Positioned(
                        left: 5,
                        top: 50,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _currentServiceIndex = (_currentServiceIndex - 1)
                                  .clamp(0, (services.length / 2).floor() - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        child: IconButton(
                          onPressed: () {
                            setState(() {
                              _currentServiceIndex = (_currentServiceIndex + 1)
                                  .clamp(0, (services.length / 2).floor() - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'الكورسات',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      FutureBuilder<List<String>>(
                        future: _getAllCourses(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final courses = snapshot.data!;
                            final startIndex = _currentCourseIndex * 2;
                            final endIndex = startIndex + 2;
                            final displayedCourses = courses.sublist(
                              startIndex,
                              endIndex.clamp(0, courses.length),
                            );

                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: displayedCourses.length,
                              itemBuilder: (context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(left: 1.0),
                                  child: Container(
                                    width: 140,
                                    height: 130,
                                    margin: const EdgeInsets.only(left: 31),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      color: Colors.green,
                                    ),
                                    child: Center(
                                      child: Text(
                                        displayedCourses[index],
                                        style: const TextStyle(
                                          color: Colors.white,
                                          fontSize: 16,
                                        ),
                                        textAlign: TextAlign.right,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching courses'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Positioned(
                        left: 5,
                        top: 50,
                        child: IconButton(
                          onPressed: () async {
                            final coursesLength =
                                (await _getAllCourses()).length;
                            setState(() {
                              _currentCourseIndex = (_currentCourseIndex - 1)
                                  .clamp(0, (coursesLength / 2).floor() - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        child: IconButton(
                          onPressed: () async {
                            final coursesLength =
                                (await _getAllCourses()).length;
                            setState(() {
                              _currentCourseIndex = (_currentCourseIndex + 1)
                                  .clamp(0, (coursesLength / 2).floor() - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.all(16.0),
                  child: Text(
                    'الاعمال',
                    textAlign: TextAlign.right,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                SizedBox(
                  height: 150,
                  child: Stack(
                    children: [
                      FutureBuilder<List<Map<String, String>>>(
                        future: _getAllJobs(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            final jobs = snapshot.data!;
                            final startIndex = _currentJobIndex * 2;
                            final endIndex = startIndex + 2;
                            final displayedJob = jobs.sublist(
                              startIndex,
                              endIndex.clamp(0, jobs.length),
                            );
                            return ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount: displayedJob.length,
                              itemBuilder: (context, index) {
                                return GestureDetector(
                                  // onTap: () {
                                  //   Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             viewjob(jobdetails['j_id'])),
                                  //   );
                                  // },
                                  child: Padding(
                                    padding: const EdgeInsets.only(left: 1.0),
                                    child: Container(
                                      width: 140,
                                      height: 130,
                                      margin: const EdgeInsets.only(left: 31),
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(10),
                                        color: const Color.fromARGB(
                                            255, 175, 76, 134),
                                      ),
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Text(
                                              displayedJob[index]['name']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 16,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                            Text(
                                              displayedJob[index]
                                                  ['description']!,
                                              style: const TextStyle(
                                                color: Colors.white,
                                                fontSize: 12,
                                              ),
                                              textAlign: TextAlign.right,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          } else if (snapshot.hasError) {
                            return const Center(
                              child: Text('Error fetching jobs'),
                            );
                          } else {
                            return const Center(
                              child: CircularProgressIndicator(),
                            );
                          }
                        },
                      ),
                      Positioned(
                        left: 5,
                        top: 50,
                        child: IconButton(
                          onPressed: () async {
                            final jobsLength = (await _getAllJobs()).length;
                            setState(() {
                              _currentJobIndex = (_currentJobIndex - 1)
                                  .clamp(0, (jobsLength / 2).floor() - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_back_ios),
                        ),
                      ),
                      Positioned(
                        right: 10,
                        top: 50,
                        child: IconButton(
                          onPressed: () async {
                            final jobsLength = (await _getAllJobs()).length;
                            setState(() {
                              _currentJobIndex = (_currentJobIndex + 1)
                                  .clamp(0, (jobsLength / 2).floor() - 1);
                            });
                          },
                          icon: const Icon(Icons.arrow_forward_ios),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          } else if (snapshot.hasError) {
            return const Center(
              child: Text('Error fetching services'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: BottomBar(),
    );
  }
}
