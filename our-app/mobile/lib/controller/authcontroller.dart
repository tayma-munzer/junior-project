import 'dart:convert';
import 'dart:io';

import 'package:get/get.dart';
import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;
import 'package:mobile/controller/authManager.dart';
import 'package:mobile/edittrainingcourse.dart';

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
      String img_data,
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
      'service_img_data': img_data,
      'img_name': img_name,
      'token': token,
    });
    return res;
  }

  static Future<http.Response> addJob(
      String j_title,
      String j_desc,
      int j_min_sal,
      int j_max_sal,
      String j_req,
      int j_min_age,
      int j_max_age,
      String education,
      String num_of_exp_years,
      String category,
      List<Map<String, String>> skills) async {
    final token = await AuthManager.getToken();
    var url = add_job;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'j_title': j_title,
          'j_desc': j_desc,
          'j_min_sal': j_min_sal.toString(),
          'j_max_sal': j_max_sal.toString(),
          'j_min_age': j_min_age.toString(),
          'j_max_age': j_max_age.toString(),
          'education': education,
          'j_req': j_req,
          'num_of_exp_years': num_of_exp_years,
          'category': category,
          'token': token,
          'skills': skills,
        }));
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
    var url = edit_projects;
    var res = await http.post(Uri.parse(url), body: {
      'p_id': p_id,
      'p_name': p_name,
      'p_desc': p_desc,
      'start_date': start_date,
      'end_date': end_date,
      'responsibilities': resbonsabilities,
    });
    return res;
  }

  static Future<http.Response> editexp(
      String exp_id,
      String company,
      String position,
      String start_date,
      String end_date,
      String responsibilities) async {
    var url = edit_experience;
    var res = await http.post(Uri.parse(url), body: {
      'exp_id': exp_id,
      'company': company,
      'position': position,
      'start_date': start_date,
      'end_date': end_date,
      'responsibilities': responsibilities,
    });
    return res;
  }

  static Future<http.Response> edittrainingcourse(
      String t_id,
      String course_name,
      String training_center,
      String completion_date) async {
    var url = edit_training_courses;
    var res = await http.post(Uri.parse(url), body: {
      't_id': t_id,
      'course_name': course_name,
      'training_center': training_center,
      'completion_date': completion_date
    });
    return res;
  }

  static Future<http.Response> editeducation(
      String e_id,
      String uni,
      String degree,
      String field_of_study,
      String grad_year,
      String gba) async {
    var url = edit_education;
    var res = await http.post(Uri.parse(url), body: {
      'e_id': e_id,
      'uni': uni,
      'degree': degree,
      'field_of_study': field_of_study,
      'grad_year': grad_year,
      'gba': gba,
    });
    return res;
  }

  static Future<http.Response> editCourse(
    String c_id,
    String c_name,
    String c_desc,
    String c_price,
    String c_img,
    String c_duration,
    String pre_requisite,
    String c_img_data,
  ) async {
    var url = edit_course;

    var response = await http.post(Uri.parse(url), body: {
      'c_id': c_id,
      'c_name': c_name,
      'c_desc': c_desc,
      'c_price': c_price,
      'c_img': c_img,
      'c_duration': c_duration,
      'pre_requisite': pre_requisite,
      'c_img_data': c_img_data,
    });

    return response;
  }

  static Future<http.Response> editProfile(
    String age,
    String u_desc,
    String image,
    String u_img_name,
    String f_name,
    String l_name,
    String email,
    String password,
    String username,
  ) async {
    var url = edit_profile;
    final token = await AuthManager.getToken();
    var response = await http.post(
      Uri.parse(url),
      body: {
        'token': token,
        'age': age,
        'u_desc': u_desc,
        'u_img_data': image,
        'u_img_name': u_img_name,
        'f_name': f_name,
        'l_name': l_name,
        'email': email,
        'password': password,
        'username': username,
      },
    );

    return response;
  }

  static Future<http.Response> addCourse(
      String c_name,
      String c_desc,
      String c_price,
      String c_img,
      String c_img_data,
      String c_duration,
      String pre_requisite,
      String category,
      String num_of_free_videos) async {
    final token = await AuthManager.getToken();
    var url = add_course;
    var res = await http.post(Uri.parse(url), body: {
      'c_name': c_name,
      'c_desc': c_desc,
      'c_price': c_price,
      'c_img': c_img,
      'c_img_data': c_img_data,
      'c_duration': c_duration,
      'pre_requisite': pre_requisite,
      'category': category,
      'num_of_free_videos': num_of_free_videos,
      'token': token
    });
    return res;
  }

  static Future<http.Response> service_enrollment(String s_id) async {
    var url = add_service_enrollment;
    final token = await AuthManager.getToken();
    print(token);
    var res = await http.post(Uri.parse(url), body: {
      's_id': s_id,
      'token': token,
    });
    return res;
  }

  static Future<http.Response> course_enrollment(String c_id) async {
    var url = add_course_enrollment;
    final token = await AuthManager.getToken();
    print(token);
    var res = await http.post(Uri.parse(url), body: {
      'c_id': c_id,
      'token': token,
    });
    return res;
  }

  static Future<http.Response> signup(
    Map<String, String> data,
    List<dynamic> roles,
  ) async {
    var url = register;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          'data': data,
          'roles': roles,
        }));
    print(res.body);
    return res;
  }

  static Future<http.Response> addaltservice(
    int s_id,
    List<dynamic> alt_services,
  ) async {
    var url = add_alt_service;
    var res = await http.post(Uri.parse(url),
        body: jsonEncode({
          's_id': s_id,
          'alt_service': alt_services,
        }));
    print(res.body);
    return res;
  }

  static Future<http.Response> add_discount_service(
      String s_id, String discount) async {
    var url = add_service_discount;
    var res = await http.post(Uri.parse(url), body: {
      's_id': s_id,
      'discount': discount,
    });
    return res;
  }

  static Future<http.Response> delete_discount_service(String s_id) async {
    var url = delete_discount;
    var res = await http.post(Uri.parse(url), body: {
      's_id': s_id,
    });
    return res;
  }

  static Future<http.Response> add_service_suggest(String suggest) async {
    var url = add_not_found_service;
    final token = await AuthManager.getToken();
    var res = await http.post(Uri.parse(url), body: {
      'token': token,
      'service_desc': suggest,
    });
    return res;
  }
}
