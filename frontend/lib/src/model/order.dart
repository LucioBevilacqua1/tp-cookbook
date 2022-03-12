import 'package:flutter/material.dart';

import 'menu_item.dart';

class Order {
  String id;
  String userOrderedId;
  String status;
  double totalPrice;
  DateTime createdAt;
  List<MenuItem> items = [];

  Order({
    this.id,
    this.userOrderedId,
    this.createdAt,
    @required this.status,
    @required this.totalPrice,
    @required this.items,
  });

  Order.fromJson(Map<String, dynamic> item) {
    this.id = item["id"];
    this.userOrderedId = item["userOrderedId"] ?? "";
    this.status = item["status"];
    this.totalPrice = item["totalPrice"];
    this.createdAt = DateTime.tryParse(item["createdAt"]);
    for (var item in item["items"]) {
      this.items.add(MenuItem.fromJson(item));
    }
  }

  Order.fromDocumentSnapshot(Map<String, dynamic> item) {
    this.id = item["id"];
    this.userOrderedId = item["userOrderedId"] ?? "";
    this.status = item["status"];
    this.totalPrice = item["totalPrice"];
    this.createdAt = DateTime.tryParse(item["createdAt"]);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id ?? null,
        'userOrderedId': this.userOrderedId,
        'status': this.status,
        'totalPrice': this.totalPrice,
        'items': this.items,
        'createdAt': this.createdAt.toIso8601String(),
      };
}
