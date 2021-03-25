import 'package:flutter/cupertino.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:frontend/src/services/auth_service.dart';
import 'package:frontend/src/services/users_service.dart';
import 'package:toast/toast.dart';

class RegisterUserModel extends BaseModel {
  AuthService authService;
  UsersService usersService;
  List<UserData> allUsers = List();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController roleTextController = TextEditingController();
  TextEditingController emailTextController = TextEditingController();
  TextEditingController passwordTextController = TextEditingController();
  bool createMode = false;
  ViewState viewState = ViewState.Busy;

  onModelReady(BuildContext context) async {
    authService = AuthService(context: context);
    usersService = UsersService(context: context);
    allUsers = await usersService.getAllUsers();
    viewState = ViewState.Idle;
    notifyListeners();
  }

  Future<String> loginUser() {
    return Future(null);
  }

  Future registerUser(context) async {
    if (validateForm()) {
      viewState = ViewState.Busy;
      notifyListeners();
      UserData createdUser = await authService.signup(
          email: emailTextController.text,
          name: nameTextController.text,
          password: passwordTextController.text,
          role: roleTextController.text.toLowerCase());

      emailTextController.clear();
      nameTextController.clear();
      passwordTextController.clear();
      roleTextController.clear();

      allUsers.add(createdUser);
      createMode = false;
      viewState = ViewState.Idle;
      notifyListeners();
      Toast.show("Item creado con éxito", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("Datos inválidos", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }

  void switchCreateMode() {
    createMode = !createMode;
    notifyListeners();
  }

  bool validateForm() {
    if (emailTextController.text.isNotEmpty &&
        nameTextController.text.isNotEmpty &&
        nameTextController.text.contains(" ") &&
        passwordTextController.text.isNotEmpty &&
        roleTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
