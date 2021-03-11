import 'package:flutter/material.dart';

class MyApp extends InheritedWidget {
  final Widget child;
  MyApp(this.child) : super(child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return false;
  }

  static MyApp of(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType(aspect: MyApp);
  }
}
