import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/model/order.dart';
import 'package:http/http.dart' as http;
import 'package:logging/logging.dart';
import 'package:frontend/src/env/app_config.dart';
import 'package:frontend/src/model/menu_item.dart';

class OrderService {
  final Logger log = Logger('OrderService');
  static String orderApiUrl;
  OrderService({@required BuildContext context}) {
    orderApiUrl = AppConfig.of(context).baseUrl + "order/";
  }

  //------------------------------
  /// Gets all Orders
  //------------------------------
  Future<List<Order>> getAllOrders() async {
    List<Order> allOrders = [];
    String urlGetAllOrders = orderApiUrl + "getAllOrders.json";
    var response = await http.get(Uri.parse(urlGetAllOrders), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      for (var user in jsonDecode(response.body)["data"]["orders"]) {
        allOrders.add(Order.fromJson(user));
      }
      return allOrders;
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }

  //------------------------------
  /// Creates a new Order
  //------------------------------
  Future<Order> createOrder({String status, List<MenuItem> items}) async {
    String createMenuItemUrl = orderApiUrl + "createOrder.json";
    var body = {"status": status, "items": items};

    var response = await http.post(Uri.parse(createMenuItemUrl), body: jsonEncode(body), headers: Configs.headers);
    if (jsonDecode(response.body)["success"]) {
      return Order.fromJson(jsonDecode(response.body)["data"]["order"]);
    } else {
      log.severe('Error base de datos: ' + response.body.toString());
      throw Exception(jsonDecode(response.body)["msg"]);
    }
  }
}
