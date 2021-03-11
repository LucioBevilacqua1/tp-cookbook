import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:logging/logging.dart';

class Configs {
  static String ggKEY2;
  static UserData currentUser;
  static bool isGpsEnabled = true;
  static bool locationPermissionEnabled;
  static AuthorizationStatus notificationPermissionStatus =
      AuthorizationStatus.authorized;

  static Logger log = Logger("Configs");

  //Headers for json requests
  static Map<String, String> headers = {"Content-Type": "application/json"};

  static setCurrentUser(UserData user) {
    currentUser = user;
  }
}
