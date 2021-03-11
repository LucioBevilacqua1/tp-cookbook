import 'package:meta/meta.dart';
import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String baseUrl;
  final String appTitle;
  final Widget child;
  final String apiKey;

  AppConfig({@required this.child, @required this.baseUrl, @required this.appTitle, @required this.apiKey});

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
