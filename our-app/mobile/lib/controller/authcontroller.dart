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
      String img_path) async {
    var url = add_service;
    var res = await http.post(Uri.parse(url), body: {
      'service_name': name,
      'service_price': price,
      //'mainCategory': mainCategory,
      'service_sec_type': subCategory,
      'service_desc': description,
      'service_duration': duration,
      'service_img': img_path,
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
}
