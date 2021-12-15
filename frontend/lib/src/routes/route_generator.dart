import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/screens/auth/login_user/login_user_view.dart';
import 'package:frontend/src/screens/auth/register_user/register_user_view.dart';
import 'package:frontend/src/screens/loading_screen.dart';
import 'package:frontend/src/screens/main/home/home_view.dart';
import 'package:frontend/src/screens/main/notifications/notifications_view.dart';
import 'package:frontend/src/screens/main/preview_order/preview_order_view.dart';
import 'package:frontend/src/screens/tabs_page_model.dart';
import 'package:frontend/src/screens/tabs_page_view.dart';

import '../../service_locator.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushname
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(settings: RouteSettings(name: '/'), builder: (_) => LoadingPage());
        break;

      case '/home':
        return MaterialPageRoute(settings: RouteSettings(name: '/home'), builder: (_) => TabsPageView());
        break;

      case '/auth':
        return MaterialPageRoute(settings: RouteSettings(name: '/auth'), builder: (_) => LoginUserView());
        break;

      case '/previewOrderView':
        if (args is List) {
          return MaterialPageRoute(
              settings: RouteSettings(name: '/previewOrderView'),
              builder: (_) => PreviewOrderView(orderItems: args[0]));
        }
        return _errorRoute();
        break;

      case '/registerUserView':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/registerUserView'), builder: (_) => RegisterUserView());
        break;

      case '/notificationsView':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/notificationsView'), builder: (_) => NotificationsView());
        break;

      case '/adminUtilities':
        return MaterialPageRoute(settings: RouteSettings(name: '/adminUtilities'), builder: (_) => HomeView());
        break;

      default:
        TabsPageModel tabsPageModel = locator<TabsPageModel>();
        bool isInitialized = tabsPageModel.bottomBar != null;
        if (!settings.name.contains('/') && !isInitialized) {
          return MaterialPageRoute(settings: RouteSettings(name: '/'), builder: (_) => LoadingPage());
        } else {
          return _errorRoute(settings, "Default");
        }
        break;
    }
  }

  static Route<dynamic> _errorRoute([settings, from]) {
    return MaterialPageRoute(builder: (_) {
      return Scaffold(
        appBar: AppBar(
          title: Text(
            'Error',
            textScaleFactor: 1.0,
          ),
        ),
        body: Center(
          child: Text(
            'Error en el redireccionamiento, reiniciar la app por favor',
            textScaleFactor: 1.0,
          ),
        ),
      );
    });
  }
}
