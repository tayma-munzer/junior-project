import 'dart:io';

import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;

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
    var res = await http.post(Uri.parse(url), body: {
      'service_name': name,
      'service_price': price,
      //'mainCategory': mainCategory,
      'service_sec_type': subCategory,
      'service_desc': description,
      'service_duration': duration,
      'service_img': img_path,
      'img_name': img_name,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> addJob(
    String j_name,
    String j_desc,
    String j_sal,
    String j_req,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'j_name': j_name,
      'j_desc': j_desc,
      'j_sal': j_sal,
      'j_req': j_req,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> add_cv(
    String career_obj,
    String phone,
    String address,
    String email,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'career_obj': career_obj,
      'phone': phone,
      'address': address,
      'email': email,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> add_skills(
    String s_name,
    String s_level,
    String years_of_exp,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      's_name': s_name,
      's_level': s_level,
      'years_of_exp': years_of_exp,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> add_training_courses(
    String course_name,
    String training_center,
    String completion_date,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'course_name': course_name,
      'training_center': training_center,
      'completion_date': completion_date,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> add_exp(
    String position,
    String company,
    String start_date,
    String end_date,
    String responsibilities,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'position': position,
      'company': company,
      'start_date': start_date,
      'end_date': end_date,
      'responsibilities': responsibilities,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> add_projects(
    String p_name,
    String p_desc,
    String start_date,
    String end_date,
    String responsibilities,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'p_name': p_name,
      'p_desc': p_desc,
      'start_date': start_date,
      'end_date': end_date,
      'responsibilities': responsibilities,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }

  static Future<http.Response> add_education(
    String degree,
    String uni,
    String grad_year,
    String field_of_study,
    String GPA,
  ) async {
    var url = add_job;
    var res = await http.post(Uri.parse(url), body: {
      'degree': degree,
      'uni': uni,
      'grad_year': grad_year,
      'field_of_study': field_of_study,
      'GPA': GPA,
      'token':
          "f2ea3690b018ac64b27c3dbb016b5814523559b5fea9d29af6900e30a93efcf1",
    });
    return res;
  }
}
