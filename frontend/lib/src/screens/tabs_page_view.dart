import 'dart:io';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/screens/tabs_page_model.dart';
import 'package:logging/logging.dart';
import 'package:vibration/vibration.dart';

import 'main/widgets/curved_navigation_bar/curved_navigation_bar.dart';

class TabsPageView extends StatefulWidget {
  TabsPageView({Key key}) : super(key: key);

  @override
  _TabsPageViewState createState() => _TabsPageViewState();
}

class _TabsPageViewState extends State<TabsPageView>
    with TickerProviderStateMixin {
  final Logger log = Logger('TabsPageView');
  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;

  @override
  void initState() {
    super.initState();
    firebaseCloudMessagingListeners();
  }

  Future<void> firebaseCloudMessagingListeners() async {
    /// Push received  with the app killed
    RemoteMessage message = await _firebaseMessaging.getInitialMessage();
    if (message != null) {
      Map<String, String> data = Map<String, String>.from(message.data);
      log.info('on launch ' + data.toString());
      log.info('on launch $message');
      switch (data['route']) {
        default:
      }
    }

    /// Push received with the app in foreground
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      //IOS doesn't have the ['data'] field it's all in the message
      Map<String, String> data = Map<String, String>.from(message.data);
      log.info('on message ' + data.toString());
      log.info("DATA: " + data.toString());
      switch (data['route']) {
        case 'driverTripDetail':
          showToastNotification(data);
          break;
        case 'tripperTripDetail':
          showToastNotification(data);
          break;
        case 'driverRegistered':
          showToastNotification(data);
          break;
        default:
      }
    });

    /// Push received with the app open but in background
    FirebaseMessaging.onMessageOpenedApp.listen(
      (RemoteMessage message) async {
        Map<String, String> data = Map<String, String>.from(message.data);
        log.info('on resume $message');
        switch (data['route']) {
          default:
        }
      },
    );

    _firebaseMessaging.getToken().then((token) {
      assert(token != null);
      log.info("LISTEN " + token);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<TabsPageModel>(
      onModelReady: (model) => model.onModelReady(context),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldKey,
        bottomNavigationBar: CurvedNavigationBar(
          key: bottomBarKey,
          buttonBackgroundColor: Colors.white,
          backgroundColor: Colors.white,
          color: Color(0xFFC75414),
          items: <Icon>[
            Icon(
              Icons.menu_book,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.menu_book,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.account_box,
              size: 30,
              color: Colors.white,
            ),
          ],
          height: 60,
          animationDuration: Duration(milliseconds: 200),
          onTap: (index) {
            model.changeTabSelected(index);
            setState(() {});
          },
        ),
        body: Stack(
          children: <Widget>[
            IndexedStack(
              index: model.selectedIndex,
              children: model.pages,
            ),
          ],
        ),
        drawer: Drawer(
          child: Column(
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed('/profile');
                },
                child: DrawerHeader(
                  decoration: BoxDecoration(color: Colors.white10),
                  child: Column(
                    children: <Widget>[
                      Expanded(
                        child: Container(
                          width: 92,
                          height: 92,
                          child: Configs.currentUser == null
                              ? ClipOval(
                                  child: CachedNetworkImage(
                                    imageUrl:
                                        "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973461_960_720.png",
                                    placeholder: (context, url) =>
                                        CircularProgressIndicator(),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
                                    fit: BoxFit.cover,
                                  ),
                                )
                              : ClipOval(
                                  child: CachedNetworkImage(
                                  imageUrl: Configs.currentUser.photoURL,
                                  placeholder: (context, url) =>
                                      CircularProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      Icon(Icons.error),
                                  fit: BoxFit.cover,
                                )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(0, 4, 0, 0),
                        child: Configs.currentUser == null
                            ? Container()
                            : Center(
                                child: Text(
                                  Configs.currentUser.name.firstName,
                                  textScaleFactor: 1.0,
                                  style: TextStyle(
                                      fontSize: 25,
                                      color: Colors.grey[900],
                                      fontFamily: 'BebasNeue'),
                                ),
                              ),
                      ),
                      Text("Ver perfil",
                          textScaleFactor: 1.0,
                          style: TextStyle(color: Colors.teal, fontSize: 10))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  vibrationHigh() async {
    bool hasAmplitude = false;
    if (await Vibration.hasAmplitudeControl()) {
      hasAmplitude = true;
    }
    if (Platform.isAndroid) {
      if (hasAmplitude) {
        await Vibration.vibrate(duration: 200, amplitude: 200);
        Future.delayed(Duration(milliseconds: 400),
            () async => {await Vibration.vibrate(duration: 200)});
      } else {
        await Vibration.vibrate(duration: 200);
        Future.delayed(Duration(milliseconds: 400),
            () async => {await Vibration.vibrate(duration: 200)});
      }
    } else {
      await HapticFeedback.vibrate();
      Future.delayed(Duration(milliseconds: 400),
          () async => {await HapticFeedback.vibrate()});
    }
  }

  void showChatToastNotification(dynamic data) {
    vibrationHigh();
  }

  void showToastNotification(dynamic data) {
    vibrationHigh();
  }
}
