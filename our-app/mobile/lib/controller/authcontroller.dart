import 'package:mobile/constant/links.dart';
import 'package:http/http.dart' as http;

class AuthController {
  Future loginAuth(email, pass) async {
    var url = login;
    var res = await http
        .post(Uri.parse(url), body: {"email": email, "password": pass});

    if (res.statusCode == 200) {
      return res;
    } else {
      return "invalid input";
    }
  }
}
