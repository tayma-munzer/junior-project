import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/controller/authManager.dart';

class AuthCont {
  static Future<http.Response> loginAuth(email, pass) async {
    var url = login;
    var res = await http
        .post(Uri.parse(url), body: {"email": email, "password": pass});
    return res;
  }

  // مالو داعي ما استخدمتو
  static Future<http.Response> service_first_type_Auth() async {
    var url = services_first_type;
    var res = await http.get(Uri.parse(url));
    return res;
  }

  static Future<http.Response> service_second_type_Auth(t_id) async {
    var url = services_second_type;
    var res = await http.post(Uri.parse(url), body: {"t_id": t_id});
    return res;
  }

  static Future<http.Response> addService(
      String name,
      String price,
      String subCategory,
      String description,
      String duration,
      String img_path,
      String img_name) async {
    var url = add_service;
    final token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {
      'service_name': name,
      'service_price': price,
      //'mainCategory': mainCategory,
      'service_sec_type': subCategory,
      'service_desc': description,
      'service_duration': duration,
      'service_img': img_path,
      'img_name': img_name,
      'token': token,
    });
    return res;
  }

  static Future<http.Response> addJob(
    String j_name,
    String j_desc,
    String j_sal,
    String j_req,
  ) async {
    final token = await AuthManager.getToken();
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'j_name': j_name,
      'j_desc': j_desc,
      'j_sal': j_sal,
      'j_req': j_req,
      'token': token
    });
    return res;
  }

  static Future<http.Response> add_cv(
    String career_obj,
    String phone,
    String address,
    String email,
  ) async {
    var url = add_main_cv;
    final token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {
      'career_obj': career_obj,
      'phone': phone,
      'address': address,
      'email': email,
      'token': token,
    });
    return res;
  }

  static Future<http.Response> add_skills(
    String cv_id,
    List<dynamic> skills,
  ) async {
    var url = add_cv_skills;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'cv_id': cv_id,
          'skills': skills,
        }));
    return res;
  }

  static Future<http.Response> add_training_courses(
    String cv_id,
    List<dynamic> courses,
  ) async {
    var url = add_cv_training_courses;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'cv_id': cv_id,
          'training_courses': courses,
        }));
    return res;
  }

  static Future<http.Response> add_exp(
    String cv_id,
    List<dynamic> exp,
  ) async {
    var url = add_cv_exp;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'cv_id': cv_id,
          'experiences': exp,
        }));
    return res;
  }

  static Future<http.Response> add_projects(
    String cv_id,
    List<dynamic> projects,
  ) async {
    var url = add_cv_projects;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'cv_id': cv_id,
          'projects': projects,
        }));
    return res;
  }

  static Future<http.Response> add_education(
    String cv_id,
    List<dynamic> edu,
  ) async {
    var url = add_cv_education;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'cv_id': cv_id,
          'education': edu,
        }));
    return res;
  }

  static Future<http.Response> add_languages(
    String cv_id,
    List<dynamic> lang,
  ) async {
    var url = add_cv_language;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'cv_id': cv_id,
          'languages': lang,
        }));
    return res;
  }

  static Future<http.Response> editJob(String j_id, String j_sal, String j_name,
      String j_desc, String j_req) async {
    var url = edit_job;
    var res = await http.post(Uri.parse(url), body: {
      'j_id': j_id,
      'j_sal': j_sal,
      'j_name': j_name,
      'j_desc': j_desc,
      'j_req': j_req,
    });
    return res;
  }

  static Future<http.Response> editSkill(
      String s_id, String s_name, String s_level, String years_of_exp) async {
    var url = edit_skills;
    var res = await http.post(Uri.parse(url), body: {
      's_id': s_id,
      's_name': s_name,
      's_level': s_level,
      'years_of_exp': years_of_exp,
    });
    return res;
  }

  static Future<http.Response> editproject(
      String p_id,
      String p_name,
      String p_desc,
      String start_date,
      String end_date,
      String resbonsabilities) async {
    var url = edit_skills;
    var res = await http.post(Uri.parse(url), body: {
      'p_id': p_id,
      'p_name': p_name,
      'p_desc': p_desc,
      'start_date': start_date,
      'end_date': end_date,
      'resbonsabilities': resbonsabilities,
    });
    return res;
  }
}
