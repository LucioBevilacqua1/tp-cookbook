import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/screens/main/home/home_model.dart';
import 'package:frontend/src/services/order_service.dart';
import 'package:logging/logging.dart';
import 'package:toast/toast.dart';

import '../../../../service_locator.dart';

class PreviewOrderModel extends BaseModel {
  final Logger log = Logger('PreviewOrderModel');

  OrderService orderService;
  List<MenuItem> allMenuItems = [];
  double totalPrice = 0.0;
  bool isLoading = false;

  ViewState viewState = ViewState.Busy;
  onModelReady(BuildContext context, List<MenuItem> orderItems) async {
    allMenuItems = orderItems;
    orderService = OrderService(context: context);
    for (var item in orderItems) {
      totalPrice += item.price;
    }
    viewState = ViewState.Idle;
    notifyListeners();
  }

  Future confirmOrder(BuildContext context) async {
    try {
      isLoading = true;
      notifyListeners();
      await orderService.createOrder(status: "requested", items: allMenuItems);
      HomeModel homeModel = locator<HomeModel>();
      homeModel.orderItems = [];
      homeModel.notifyListeners();
      Toast.show("Pedido creado con éxito", context, duration: Toast.LENGTH_LONG, gravity: Toast.TOP);
      Navigator.of(context).pop();
    } catch (e) {
      Toast.show("Error creando pedido", context, duration: Toast.LENGTH_SHORT, gravity: Toast.TOP);
    }

    isLoading = false;
    notifyListeners();
  }
}
