import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/model/order.dart';
import 'package:intl/intl.dart';
import 'package:liquid_pull_to_refresh/liquid_pull_to_refresh.dart';

import 'notifications_model.dart';

class NotificationsView extends StatefulWidget {
  NotificationsView({Key key}) : super(key: key);

  @override
  _NotificationsViewState createState() => _NotificationsViewState();
}

class _NotificationsViewState extends State<NotificationsView> with SingleTickerProviderStateMixin {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<NotificationsModel>(
      onModelReady: (model) => model.onModelReady(context),
      builder: (context, model, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text("Pedidos"),
            automaticallyImplyLeading: false,
            centerTitle: true,
          ),
          body: LiquidPullToRefresh(
            height: 50,
            showChildOpacityTransition: false,
            animSpeedFactor: 3,
            springAnimationDurationInMilliseconds: 300,
            onRefresh: () => model.onModelReady(context),
            child: model.viewState == ViewState.Busy
                ? Visibility(
                    visible: model.viewState == ViewState.Busy,
                    child: Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 50,
                            width: 50,
                            child: CircularProgressIndicator(
                              backgroundColor: Colors.orange,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )
                : ListView.builder(
                    padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                    itemCount: model.allOrders.length,
                    shrinkWrap: true,
                    physics: AlwaysScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      Order order = model.allOrders[index];
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text("Id del pedido: " + order.id),
                                  Text(
                                    "Estado: " + order.status,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  Text(
                                    "Fecha: " +
                                        DateFormat('EEE, dd/MM/y - HH:mm', 'es_ES').format(order.createdAt.toLocal()),
                                    style: TextStyle(fontSize: 12),
                                  ),
                                  Divider(),
                                  Text("Items pedidos: " + order.items.length.toString()),
                                  Divider(),
                                  ListView.builder(
                                      shrinkWrap: true,
                                      itemCount: order.items.length,
                                      physics: ClampingScrollPhysics(),
                                      itemBuilder: (context, index) {
                                        MenuItem menuItem = order.items[index];
                                        return Column(
                                          children: [
                                            Row(
                                              children: [
                                                Expanded(
                                                  child: Column(
                                                    crossAxisAlignment: CrossAxisAlignment.start,
                                                    children: [
                                                      Text(
                                                        menuItem.name,
                                                        style: TextStyle(fontWeight: FontWeight.bold),
                                                      ),
                                                      Text(
                                                        "Descripción: " + menuItem.description,
                                                        maxLines: 2,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                Text("Precio: \$" + menuItem.price.toStringAsFixed(1)),
                                              ],
                                            ),
                                            Divider()
                                          ],
                                        );
                                      }),
                                  Text(
                                    "Precio total: \$" + order.totalPrice.toString(),
                                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                ],
                              ),
                            ),
                          ));
                    }),
          ),
        );
      },
    );
  }
}
