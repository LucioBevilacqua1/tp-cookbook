import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:frontend/src/app.dart';
import 'package:frontend/src/env/app_config.dart';
import 'package:logging/logging.dart';

import 'service_locator.dart';
import 'src/routes/route_generator.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
  await Firebase.initializeApp();

  setupLocator();
  Logger.root.level = Level.ALL;
  Logger.root.onRecord.listen((LogRecord rec) {
    print('----${rec.level.name}: ${rec.loggerName} -> ${rec.message}');
  });
  var configuredApp = AppConfig(
    baseUrl: "https://935b99e36c3f.ngrok.io/",
    appTitle: "CookBook",
    apiKey: "AIzaSyDYu7E-0If7x4dNw0UScmhjWkzdfQbOz0A",
    child: MyApp(
      MaterialApp(
        initialRoute: '/',
        onGenerateRoute: RouteGenerator.generateRoute,
        theme: ThemeData(
            primaryColor: Colors.orange,
            primarySwatch: Colors.cyan,
            iconTheme: IconThemeData(color: Colors.white)),
        localizationsDelegates: [
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
        ],
        supportedLocales: [
          const Locale('es', 'AR'),
          const Locale('pt', 'BR'),
          const Locale('en', 'US')
        ],
      ),
    ),
  );
  return runApp(configuredApp);
}
