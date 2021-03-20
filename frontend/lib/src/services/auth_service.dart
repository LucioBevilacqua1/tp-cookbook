import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:frontend/src/env/app_config.dart';

class AuthService {
  final Logger log = Logger('UsersService');
  static String authApiUrl;
  AuthService({@required BuildContext context}) {
    authApiUrl = AppConfig.of(context).baseUrl + "auth/";
  }

  //------------------------------
  /// Registers a new user
  //------------------------------
  Future<UserData> signup(
      {String email, String password, String name, String role}) async {
    String signupUrl = authApiUrl + "signup";
    var body = {
      "email": email,
      "password": password,
      "name": {"firstName": name.split(" ")[0], "surname": name.split(" ")[1]},
      "role": role
    };

    var response = await http.post(signupUrl,
        body: jsonEncode(body), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      return UserData.fromJson(jsonDecode(response.body)["data"]["user"]);
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }
}
