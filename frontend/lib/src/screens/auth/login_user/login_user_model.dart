import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/services/auth_service.dart';
import 'package:frontend/src/services/users_service.dart';
import 'package:toast/toast.dart';

class LoginUserModel extends BaseModel {
  AuthService authService;
  UsersService usersService;
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  ViewState viewState = ViewState.Busy;

  onModelReady(BuildContext context) async {
    authService = AuthService(context: context);
    usersService = UsersService(context: context);
    viewState = ViewState.Idle;
    notifyListeners();
  }

  Future loginUser(context) async {
    if (validateForm()) {
      viewState = ViewState.Busy;
      notifyListeners();

      try {
        UserCredential logedUser = await authService.loginUser(
          email: emailTextController.text,
          password: passwordTextController.text,
        );

        await usersService.getCurrentUserAndUpdateData(logedUser.user.uid);

        emailTextController.clear();
        passwordTextController.clear();
        viewState = ViewState.Idle;
        notifyListeners();

        Toast.show("Sesión iniciada con éxito", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        Navigator.of(context).popAndPushNamed('/home');
      } catch (e) {
        Toast.show("Error iniciando sesión", context,
            duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
        viewState = ViewState.Idle;
        notifyListeners();
      }
    } else {
      Toast.show("Datos inválidos", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }

  bool validateForm() {
    if (emailTextController.text.isNotEmpty &&
        passwordTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
