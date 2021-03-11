import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'name.dart';

class UserData {
  String email;
  String deviceToken;
  String uid;
  Name name;
  String photoURL;

  UserData({
    @required this.name,
    @required this.email,
    @required this.uid,
    @required this.photoURL,
    this.deviceToken,
  });

  UserData.fromJson(Map<String, dynamic> item) {
    this.name = Name.fromJson(item["name"]);
    this.email = item["email"];
    this.uid = item["uid"];
    this.photoURL = item["photoURL"];
    this.deviceToken = item["deviceToken"];
  }

  UserData.fromDocumentSnapshot(DocumentSnapshot item) {
    this.name = Name.fromJson(Map<String, dynamic>.from(item.data()["name"]));
    this.email = item.data()["email"];
    this.uid = item.data()["uid"];
    this.photoURL = item.data()["photoURL"];
    this.deviceToken = item.data()["deviceToken"];
  }

  Map<String, dynamic> toJson() => <String, dynamic>{
        'name': this.name.toJson(),
        'email': this.email,
        'uid': this.uid,
        'photoURL': this.photoURL,
        'deviceToken': this.deviceToken,
      };
}
