import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MenuItem {
  String description;
  double price;
  String name;
  String photoUrl;

  MenuItem({
    @required this.description,
    @required this.photoUrl,
    @required this.price,
  });

  MenuItem.fromJson(Map<String, dynamic> item) {
    this.description = item["description"];
    this.price = item["price"];
    this.photoUrl = item["photoUrl"];
    this.name = item["name"];
  }

  MenuItem.fromDocumentSnapshot(DocumentSnapshot item) {
    this.description = item.data()["description"];
    this.price = item.data()["price"];
    this.photoUrl = item.data()["photoUrl"];
    this.name = item.data()["name"];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'description': this.description,
        'price': this.price,
        'photoUrl': this.photoUrl,
        'name': this.name,
      };
}
