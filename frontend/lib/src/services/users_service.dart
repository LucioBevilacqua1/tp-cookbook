import 'dart:async';
import 'dart:convert';
import 'dart:io';
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

  /// UPDATES USER'S LAST SEEN AND DEVICE TOKEN
  /// * This function runs on every sign in
  Future updateLastSeenAndDeviceToken(String uid) async {
    var url = usersApiUrl + "updateLastSeenAndDeviceToken/" + uid;
    String token = await _firebaseMessaging.getToken();
    var body = {'token': token};
    var response =
        await http.put(url, body: jsonEncode(body), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      log.info("LastSeen y deviceToken actualizados con éxito");
      log.info("response: " + response.body.toString());
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }

  // -----------------------------------------------------
  /// Last step before the user can access to `/home`
  ///
  /// 1. Gets notification permission
  /// 2. Gets GPS and location permission
  /// 3. Signs in the user and updates user data on the db
  // -----------------------------------------------------
  Future<void> setCurrentUser([Function(String) changeProgressMessage]) async {
    String deviceToken;
    bool progressMessageActive = changeProgressMessage != null;
    log.info("Entra a setCurrentUser");

    /// 1. Asks for notification permission
    try {
      if (Platform.isIOS) {
        NotificationSettings result =
            await _firebaseMessaging.requestPermission();
        Configs.notificationPermissionStatus = result.authorizationStatus;
      } else if (Platform.isAndroid) {
        Configs.notificationPermissionStatus = AuthorizationStatus.authorized;
      }
      deviceToken = await _firebaseMessaging.getToken();
    } catch (e) {
      log.severe("No se habilitó el permiso de notificacion");
      Configs.notificationPermissionStatus = AuthorizationStatus.denied;
    }

    /// 3. Signs in the user and updates user data on the db
    //user = _auth.currentUser;

    ///the next  lines are the biggest mistery in history programming, but works, so dont touch it
    ///if you dont reload 2 times firebase doesnt recognize the email verification, I repeat: IT WORKS, SO DONT TOUCH IT
    //await user.reload();
    /*if (!user.emailVerified) {
      user = _auth.currentUser;
      user.reload();
    }*/
    if (progressMessageActive) {
      changeProgressMessage("Iniciando sesión");
    }
    UserData currentUser = await getCurrentUserAndUpdateUserData(
        "ZY7J6dSoKsUoI2TTCdIbl7MGh0n1", deviceToken);
    if (progressMessageActive) {
      changeProgressMessage("Disfrutá el viaje");
    }
    Configs.setCurrentUser(currentUser);
  }

  /*------------------------------
   set last seen, device token and referral Id and returns current user
  --------------------------------*/
  Future<UserData> getCurrentUserAndUpdateUserData(
      String uid, deviceToken) async {
    String url = usersApiUrl + "getCurrentUserAndUpdateUserData/" + uid;
    var body = {"deviceToken": deviceToken};
    log.info("Url para getCurrentUserAndUpdateUserData: " + url);

    var response =
        await http.put(url, body: jsonEncode(body), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      log.info("Referral id agregado con éxito");
      return UserData.fromJson(jsonDecode(response.body)["data"]["user"]);
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
    QuerySnapshot usersSnapshot = await db.collection('usersCollection').get();
    for (var user in usersSnapshot.docs) {
      allUsers.add(UserData.fromDocumentSnapshot(user));
    }
    return allUsers;
  }
}
