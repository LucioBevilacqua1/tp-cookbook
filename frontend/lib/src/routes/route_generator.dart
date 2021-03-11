import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:frontend/src/screens/loading_screen.dart';
import 'package:frontend/src/screens/main/home/home_view.dart';
import 'package:frontend/src/screens/tabs_page_model.dart';
import 'package:frontend/src/screens/tabs_page_view.dart';

import '../../service_locator.dart';

class RouteGenerator {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    // Getting arguments passed in while calling Navigator.pushname
    final args = settings.arguments;
    switch (settings.name) {
      case '/':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/'), builder: (_) => LoadingPage());
        break;
      case '/home':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/home'),
            builder: (_) => TabsPageView());
        break;
      case '/adminUtilities':
        return MaterialPageRoute(
            settings: RouteSettings(name: '/adminUtilities'),
            builder: (_) => HomeView());
        break;
      default:
        // Por alguna razon cuando entro de una push con la app matada entra al router manda una ruta json y no entra a ningun lado
        // FIX temporal es que por default redireccione a la ruta '/' si el name no tiene una '/' y tabs no esta inicializado
        TabsPageModel tabsPageModel = locator<TabsPageModel>();
        bool isInitialized = tabsPageModel.bottomBar != null;
        if (!settings.name.contains('/') && !isInitialized) {
          return MaterialPageRoute(
              settings: RouteSettings(name: '/'),
              builder: (_) => LoadingPage());
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
