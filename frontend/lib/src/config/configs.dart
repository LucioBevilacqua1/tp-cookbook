import 'package:frontend/src/model/user_data.dart';
import 'package:logging/logging.dart';

class Configs {
  static String ggKEY2;
  static UserData currentUser;

  static Logger log = Logger("Configs");

  //Headers for json requests
  static Map<String, String> headers = {
    "Content-Type": "application/json",
    "Access-Control_Allow_Origin": "*",
  };

  static setCurrentUser(UserData user) {
    currentUser = user;
  }
}
