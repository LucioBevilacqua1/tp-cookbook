import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/services/menu_item_service.dart';
import 'package:logging/logging.dart';

class PreviewOrderModel extends BaseModel {
  final Logger log = Logger('PreviewOrderModel');

  MenuItemService menuItemService;
  List<MenuItem> allMenuItems = [];
  double totalPrice = 0.0;

  ViewState viewState = ViewState.Busy;
  onModelReady(BuildContext context, List<MenuItem> orderItems) async {
    menuItemService = MenuItemService(context: context);
    for (var item in orderItems) {
      totalPrice += item.price;
    }
    viewState = ViewState.Idle;
    notifyListeners();
  }
}
