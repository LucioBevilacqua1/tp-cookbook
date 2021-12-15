import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_model.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/order.dart';
import 'package:frontend/src/services/order_service.dart';
import 'package:logging/logging.dart';

class NotificationsModel extends BaseModel {
  final Logger log = Logger('NotificationsModel');

  OrderService orderService;
  List<Order> allOrders = [];
  double totalPrice = 0.0;
  bool isLoading = false;

  ViewState viewState = ViewState.Busy;
  onModelReady(BuildContext context) async {
    orderService = OrderService(context: context);
    allOrders = await orderService.getAllOrders();
    allOrders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
    viewState = ViewState.Idle;
    notifyListeners();
  }
}
