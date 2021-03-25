import 'dart:async';
import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:frontend/src/env/app_config.dart';

class UsersService {
  final Logger log = Logger('UsersService');
  //Main URL
  static String usersApiUrl;

  static final FirebaseFirestore db = FirebaseFirestore.instance;
  final FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  UsersService({@required BuildContext context}) {
    usersApiUrl = AppConfig.of(context).baseUrl + "api-users/";
  }

  /*------------------------------
  GET A USER BY USERID
  1- Sends the uid 
  2- if succeed, returns de User retrieved
  --------------------------------*/
  Future<UserData> getUserById(String uid) async {
    String getUserByUserIdUrl = usersApiUrl + uid;
    var response = await http.get(getUserByUserIdUrl, headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      return UserData.fromJson(jsonDecode(response.body)['user']['data']);
    } else {
      log.severe("----Detalles del error: " +
          jsonDecode(response.body)["errors"].toString());
      throw Exception(jsonDecode(response.body)["msg"].toString());
    }
  }

  //------------------------------
  /// Gets current user
  ///
  /// Sets last seen and device token
  ///
  /// `@returns` current user
  //------------------------------
  Future<UserData> getCurrentUserAndUpdateData(String uid) async {
    String deviceToken = await _firebaseMessaging.getToken();
    String url =
        usersApiUrl + "getCurrentUserAndUpdateUserData/" + uid + ".json";

    var body = {"deviceToken": deviceToken};

    var response =
        await http.put(url, body: jsonEncode(body), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      UserData currentUser =
          UserData.fromJson(jsonDecode(response.body)["data"]["user"]);

      Configs.setCurrentUser(currentUser);
      return currentUser;
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }

  //------------------------------
  /// Gets all users of the database
  //------------------------------
  Future<List<UserData>> getAllUsers() async {
    List<UserData> allUsers = List();
    String urlGetAllUsers = usersApiUrl + "getAllUsers.json";
    var response = await http.get(urlGetAllUsers, headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      log.info("Referral id agregado con éxito");
      for (var user in jsonDecode(response.body)["data"]["users"]) {
        allUsers.add(UserData.fromJson(user));
      }
      return allUsers;
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }
}
