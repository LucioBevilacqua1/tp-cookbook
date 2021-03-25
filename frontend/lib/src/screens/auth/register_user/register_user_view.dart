import 'package:flutter/material.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:intl/intl.dart';

import 'register_user_model.dart';

class RegisterUserView extends StatefulWidget {
  RegisterUserView({Key key}) : super(key: key);

  @override
  _RegisterUserViewState createState() => _RegisterUserViewState();
}

class _RegisterUserViewState extends State<RegisterUserView>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<RegisterUserModel>(
      onModelReady: (model) => model.onModelReady(context),
      builder: (context, model, child) {
        double _width = MediaQuery.of(context).size.width;
        return Scaffold(
          body: Container(
            child: ListView(
              children: <Widget>[
                Visibility(
                  visible: Configs.currentUser.role == UserData.ADMIN,
                  child: Padding(
                    padding:
                        EdgeInsets.fromLTRB(_width * .1, 15, _width * .1, 15),
                    child: InkWell(
                      onTap: () {
                        setState(() {
                          model.switchCreateMode();
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.greenAccent[700],
                          borderRadius: BorderRadius.all(
                            Radius.circular(30),
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Align(
                              alignment: Alignment.center,
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(bottom: 15, top: 15),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.add,
                                      size: 30,
                                    ),
                                    Text(
                                      'Crear usuario',
                                      style: TextStyle(
                                          color: Colors.white, fontSize: 18),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                Visibility(
                  visible: model.createMode,
                  child: Container(
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ]),
                          child: TextField(
                            controller: model.nameTextController,
                            textCapitalization: TextCapitalization.words,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Nombre y apellido',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
                              color: Colors.white,
                              boxShadow: [
                                BoxShadow(color: Colors.black12, blurRadius: 5)
                              ]),
                          child: TextField(
                            controller: model.roleTextController,
                            decoration: InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Rol',
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50)),
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
                                  await model.registerUser(context);
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
                                      'Crear'.toUpperCase(),
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
                          height: 50,
                          color: Colors.transparent,
                        )
                      ],
                    ),
                  ),
                ),
                Divider(),
                Container(
                  width: _width,
                  color: Colors.teal,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 20, top: 20),
                          child: Text(
                            'Usuarios',
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Divider(
                  color: Colors.transparent,
                ),
                Visibility(
                  visible: model.viewState == ViewState.Busy,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 50,
                        width: 50,
                        child: CircularProgressIndicator(
                          backgroundColor: Colors.orange,
                          valueColor:
                              AlwaysStoppedAnimation<Color>(Colors.orange[800]),
                        ),
                      ),
                    ],
                  ),
                ),
                ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: model.allUsers.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      UserData user = model.allUsers[index];
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Usuario: " +
                                      user.name.firstName +
                                      " " +
                                      user.name.surname),
                                  Text("Email: " + user.email),
                                  Text("Rol: " + user.role),
                                  Text("Última conexión: " +
                                      DateFormat('EEE, dd/MM/y HH:mm', 'es_ES')
                                          .format(user.lastSeen.toLocal()))
                                ],
                              ),
                            ),
                          ));
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
