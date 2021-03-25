import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/core/view_state.dart';

import 'login_user_model.dart';

class LoginUserView extends StatefulWidget {
  LoginUserView({Key key}) : super(key: key);

  @override
  _LoginUserViewState createState() => _LoginUserViewState();
}

class _LoginUserViewState extends State<LoginUserView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<LoginUserModel>(
      onModelReady: (model) => model.onModelReady(context),
      builder: (context, model, child) {
        double _width = MediaQuery.of(context).size.width;
        return Scaffold(
          body: Container(
            child: ListView(
              children: <Widget>[
                Container(
                  width: _width,
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
                      Container(
                        width: _width / 1.2,
                        height: 45,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: model.emailTextController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Email',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Container(
                        width: _width / 1.2,
                        height: 45,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextField(
                          obscureText: true,
                          controller: model.passwordTextController,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Contraseña',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      InkWell(
                        onTap: model.viewState == ViewState.Idle
                            ? () async {
                                await model.loginUser(context);
                              }
                            : null,
                        child: Container(
                          height: 45,
                          width: _width / 1.2,
                          decoration: BoxDecoration(
                              color: Colors.green[800],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: model.viewState == ViewState.Idle
                                ? Text(
                                    'Iniciar sesión'.toUpperCase(),
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold),
                                  )
                                : CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 20,
                        color: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
