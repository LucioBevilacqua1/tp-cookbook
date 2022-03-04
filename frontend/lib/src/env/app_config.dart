import 'package:flutter/material.dart';

class AppConfig extends InheritedWidget {
  final String baseUrl;
  final String appTitle;
  final Widget child;

  AppConfig({@required this.child, @required this.baseUrl, @required this.appTitle});

  static AppConfig of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: AppConfig);
  }

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) => false;
}
