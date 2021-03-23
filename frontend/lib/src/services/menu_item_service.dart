import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:frontend/src/env/app_config.dart';
import 'package:frontend/src/model/menu_item.dart';

class MenuItemService {
  final Logger log = Logger('MenuItemService');
  static String menuItemApiUrl;
  MenuItemService({@required BuildContext context}) {
    menuItemApiUrl = AppConfig.of(context).baseUrl + "menuItem/";
  }

  //------------------------------
  /// Gets all Foods and Drinks
  //------------------------------
  Future<List<MenuItem>> getAllMenuItems() async {
    List<MenuItem> allMenuItems = List();
    String urlGetAllMenuItems = menuItemApiUrl + "getAllMenuItems.json";
    var response = await http.get(urlGetAllMenuItems, headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      log.info("Referral id agregado con éxito");
      for (var user in jsonDecode(response.body)["data"]["menuItems"]) {
        allMenuItems.add(MenuItem.fromJson(user));
      }
      return allMenuItems;
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }

  //------------------------------
  /// Creates a new Food or Drink
  //------------------------------
  Future<MenuItem> createMenuItem(
      {String description, double price, String name, String photoUrl}) async {
    String createMenuItemUrl = menuItemApiUrl + "createMenuItem.json";
    var body = {
      "description": description,
      "name": name,
      "price": price,
      "photoUrl": photoUrl
    };

    var response = await http.post(createMenuItemUrl,
        body: jsonEncode(body), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      return MenuItem.fromJson(jsonDecode(response.body)["data"]["menuItem"]);
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }
}
