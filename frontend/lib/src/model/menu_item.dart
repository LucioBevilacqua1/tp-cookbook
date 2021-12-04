import 'package:flutter/material.dart';

class MenuItem {
  String id;
  String description;
  double price;
  String name;
  String photoUrl;

  MenuItem({
    this.id,
    @required this.description,
    @required this.photoUrl,
    @required this.price,
  });

  MenuItem.fromJson(Map<String, dynamic> item) {
    this.id = item["id"];
    this.description = item["description"];
    this.price = item["price"];
    this.photoUrl = item["photoUrl"];
    this.name = item["name"];
  }

  MenuItem.fromDocumentSnapshot(Map<String, dynamic> item) {
    this.id = item["id"];
    this.description = item["description"];
    this.price = item["price"];
    this.photoUrl = item["photoUrl"];
    this.name = item["name"];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'id': this.id ?? null,
        'description': this.description,
        'price': this.price,
        'photoUrl': this.photoUrl,
        'name': this.name,
      };
}
