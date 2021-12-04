import 'package:flutter/material.dart';

import 'name.dart';

class UserData {
  String email;
  String deviceToken;
  String uid;
  Name name;
  String role;
  String photoURL;
  DateTime lastSeen;

  static const String ADMIN = "admin";

  UserData({
    @required this.name,
    @required this.email,
    @required this.uid,
    @required this.photoURL,
    @required this.role,
    @required this.lastSeen,
    this.deviceToken,
  });

  bool isAdmin() {
    return role == ADMIN;
  }

  UserData.fromJson(Map<String, dynamic> item) {
    this.name = Name.fromJson(item["name"]);
    this.email = item["email"];
    this.uid = item["uid"];
    this.photoURL = item["photoURL"];
    this.role = item["role"] ?? "indefinido";
    this.deviceToken = item["deviceToken"];
    this.lastSeen = DateTime.tryParse(item["lastSeen"]);
  }

  UserData.fromDocumentSnapshot(Map<String, dynamic> item) {
    this.name = Name.fromJson(Map<String, dynamic>.from(item["name"]));
    this.email = item["email"];
    this.uid = item["uid"];
    this.photoURL = item["photoURL"];
    this.role = item["role"] ?? "indefinido";
    this.deviceToken = item["deviceToken"];
    this.lastSeen = DateTime.tryParse(item["lastSeen"]);
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name.toJson(),
        'email': this.email,
        'uid': this.uid,
        'photoURL': this.photoURL,
        'role': this.role ?? "indefinido",
        'deviceToken': this.deviceToken,
        'lastSeen': this.lastSeen,
      };
}
