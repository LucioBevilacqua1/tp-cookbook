import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:flare_flutter/flare_actor.dart';
import 'package:frontend/src/services/auth_service.dart';
import 'package:frontend/src/services/users_service.dart';
import 'package:logging/logging.dart';

class LoadingPage extends StatefulWidget {
  @override
  LoadingPageState createState() {
    return LoadingPageState();
  }
}

class LoadingPageState extends State<LoadingPage> {
  //LoadingDialog loading = LoadingDialog();
  AuthService appAuth;
  bool isLoading = false;
  bool _isLogged = false;
  final Logger log = Logger('LoadingPageState');
  @override
  void initState() {
    super.initState();
    // Set default home.
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: <Widget>[
          FlareActor(
            "assets/animations/splash_screen.flr",
            alignment: Alignment.center,
            fit: BoxFit.fitWidth,
            animation: "Untitled",
            callback: (a) async {
              log.info("Entra al callback");
              showLoading();
              await _redirectToDefaultPage();
            },
          ),
          PositionedDirectional(
            start: MediaQuery.of(context).size.width * .45,
            width: MediaQuery.of(context).size.width * .1,
            height: MediaQuery.of(context).size.width * .1,
            bottom: MediaQuery.of(context).size.height * .2,
            child: Visibility(
              visible: isLoading,
              child: SizedBox(
                child: CircularProgressIndicator(
                  backgroundColor: Colors.orange,
                  valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  showLoading() {
    setState(() {
      isLoading = true;
    });
  }

  Future<void> _redirectToDefaultPage() async {
    appAuth = AuthService(context: context);
    UsersService usersService = UsersService(context: context);
    String _defaultHome = '/auth';
    // Get result of the login function.
    _isLogged = await appAuth.isLogged();

    if (_isLogged) {
      await usersService
          .getCurrentUserAndUpdateData(FirebaseAuth.instance.currentUser.uid);
      _defaultHome = '/home';
    } else {
      _defaultHome = '/auth';
    }
    await Navigator.of(context).pushReplacementNamed(_defaultHome);
  }
}
