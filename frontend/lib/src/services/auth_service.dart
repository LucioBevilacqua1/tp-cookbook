import 'dart:async';
import 'dart:convert';
import 'package:firebase_auth/firebase_auth.dart';
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
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // -----------------------------------------------------
  /// Checks if there's a user logged in
  ///
  /// 1. Gets the [currentUser]
  /// 2. If [user], [user.email] and [user.phoneNumber] are not __null__ returns __true__, else returns __false__
  // -----------------------------------------------------
  Future<bool> isLogged() async {
    User loggedUser = _auth.currentUser;
    //user, mail and phone number != null
    bool isLogged = (loggedUser != null &&
        loggedUser.phoneNumber != null &&
        loggedUser.phoneNumber.isNotEmpty &&
        loggedUser.email != null &&
        loggedUser.email.isNotEmpty);
    return isLogged;
  }

  //------------------------------
  /// Logs in a registered user
  //------------------------------
  Future<UserCredential> loginUser({String email, String password}) async {
    try {
      return await _auth.signInWithEmailAndPassword(
          email: email, password: password);
    } catch (e) {
      throw Exception(e);
    }
  }

  //------------------------------
  /// Registers a new user
  //------------------------------
  Future<UserData> signup(
      {String email, String password, String name, String role}) async {
    String signupUrl = authApiUrl + "signup.json";
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
