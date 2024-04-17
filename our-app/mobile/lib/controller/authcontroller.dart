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

  static Future<http.Response> service_first_type_Auth() async {
    var url = services_first_type;
    var res = await http.post(Uri.parse(url));
    return res;
  }

  static Future<http.Response> service_second_type_Auth(t_id) async {
    var url = services_second_type;
    var res = await http.post(Uri.parse(url), body: {"t_id": t_id});
    return res;
  }
}
