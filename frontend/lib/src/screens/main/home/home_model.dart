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
  List<MenuItem> allMenuItems = [];
  List<MenuItem> orderItems = [];
  TextEditingController nameTextController = TextEditingController();
  TextEditingController descriptionTextController = TextEditingController();
  TextEditingController priceTextController = TextEditingController();
  bool createMode = true;
  bool editMode = false;
  bool openForm = false;
  MenuItem menuItemToEdit;

  ViewState viewState = ViewState.Busy;
  onModelReady(BuildContext context) async {
    menuItemService = MenuItemService(context: context);
    allMenuItems = await menuItemService.getAllMenuItems();
    viewState = ViewState.Idle;
    notifyListeners();
  }

  switchOpenForm() {
    openForm = !openForm;
    notifyListeners();
  }

  void switchCreateMode() {
    descriptionTextController.clear();
    nameTextController.clear();
    priceTextController.clear();
    editMode = false;
    createMode = true;
    menuItemToEdit = null;
    notifyListeners();
  }

  void switchEditMode({MenuItem menuItem}) {
    editMode = true;
    createMode = false;
    openForm = true;
    nameTextController.text = menuItem.name;
    descriptionTextController.text = menuItem.description;
    priceTextController.text = menuItem.price.toString();
    menuItemToEdit = menuItem;
    notifyListeners();
  }

  Future createMenuItem(context) async {
    if (validateForm()) {
      viewState = ViewState.Busy;
      notifyListeners();
      MenuItem createdMenuItem = await menuItemService.createMenuItem(
          description: descriptionTextController.text,
          name: nameTextController.text,
          price: double.tryParse(priceTextController.text),
          photoUrl: "https://cdn0.iconfinder.com/data/icons/kameleon-free-pack-rounded/110/Food-Dome-512.png");

      descriptionTextController.clear();
      nameTextController.clear();
      priceTextController.clear();

      allMenuItems.add(createdMenuItem);
      createMode = false;
      openForm = false;
      viewState = ViewState.Idle;
      notifyListeners();
      Toast.show("Item creado con éxito", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("Datos inválidos", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }

  Future editMenuItem(BuildContext context) async {
    if (validateForm()) {
      viewState = ViewState.Busy;
      notifyListeners();
      menuItemToEdit.description = descriptionTextController.text;
      menuItemToEdit.name = nameTextController.text;
      menuItemToEdit.price = double.tryParse(priceTextController.text);

      await menuItemService.editMenuItem(
        id: menuItemToEdit.id,
        description: descriptionTextController.text,
        name: nameTextController.text,
        price: double.tryParse(priceTextController.text),
      );

      descriptionTextController.clear();
      nameTextController.clear();
      priceTextController.clear();
      createMode = true;
      editMode = false;
      openForm = false;

      allMenuItems[allMenuItems.lastIndexWhere((element) => element.id == menuItemToEdit.id)] = menuItemToEdit;

      viewState = ViewState.Idle;
      notifyListeners();
      Toast.show("Item editado con éxito", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    } else {
      Toast.show("Datos inválidos", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
    }
  }

  Future deleteMenuItem({MenuItem menuItem}) async {
    viewState = ViewState.Busy;
    notifyListeners();

    await menuItemService.deleteMenuItem(
      id: menuItem.id,
    );
    allMenuItems.removeWhere((element) => element.id == menuItem.id);

    viewState = ViewState.Idle;
    notifyListeners();
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
