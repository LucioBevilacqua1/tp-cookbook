import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/services/menu_item_service.dart';
import 'package:logging/logging.dart';
import 'package:toast/toast.dart';

class HomeModel extends BaseModel {
  final Logger log = Logger('HomeModel');

  MenuItemService menuItemService;
  List<MenuItem> allMenuItems = List();
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  bool createMode = false;
  ViewState viewState = ViewState.Busy;
  onModelReady(BuildContext context) async {
    menuItemService = MenuItemService(context: context);
    allMenuItems = await menuItemService.getAllMenuItems();
    viewState = ViewState.Idle;
    notifyListeners();
  }

  void switchCreateMode() {
    createMode = !createMode;
    notifyListeners();
  }

  Future createMenuItem(context) async {
    if (validateForm()) {
      viewState = ViewState.Busy;
      notifyListeners();
      MenuItem createdUser = await menuItemService.createMenuItem(
          description: descriptionTextController.text,
          name: nameTextController.text,
          price: double.tryParse(priceTextController.text),
          photoUrl:
              "https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Food-Dome-512.png");

      descriptionTextController.clear();
      nameTextController.clear();
      priceTextController.clear();

      allMenuItems.add(createdUser);
      createMode = false;
      viewState = ViewState.Idle;
      notifyListeners();
      Toast.show("Usuario creado con éxito", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("Datos inválidos", context,
          duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }

  bool validateForm() {
    if (descriptionTextController.text.isNotEmpty &&
        nameTextController.text.isNotEmpty &&
        priceTextController.text.isNotEmpty) {
      return true;
    }
    return false;
  }
}
