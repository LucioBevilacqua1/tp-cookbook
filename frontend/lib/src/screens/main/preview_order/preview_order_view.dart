import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/screens/main/preview_order/preview_order_model.dart';

class PreviewOrderView extends StatefulWidget {
  final List<MenuItem> orderItems;
  PreviewOrderView({@required this.orderItems});

  @override
  PreviewOrderViewState createState() {
    return PreviewOrderViewState();
  }
}

class PreviewOrderViewState extends State<PreviewOrderView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<PreviewOrderModel>(
      onModelReady: (model) => model.onModelReady(context, widget.orderItems),
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
          leadingWidth: 40,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.only(right: 40),
                child: Text(
                  "Revisá tu pedido",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ],
          ),
        ),
        body: Column(
          children: <Widget>[
            Divider(
              color: Colors.transparent,
            ),
            Text(
              "Total: \$" + model.totalPrice.toStringAsFixed(1),
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
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
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.orange[800]),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 70),
                  itemCount: widget.orderItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    MenuItem orderItem = widget.orderItems[index];
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: InkWell(
                          onTap: () {
                            setState(() {});
                          },
                          child: Card(
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                children: [
                                  Text(orderItem.name),
                                  Text("Descripción: " + orderItem.description),
                                  Text("Precio: " + orderItem.price.toStringAsFixed(1))
                                ],
                              ),
                            ),
                          ),
                        ));
                  }),
            )
          ],
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton.extended(
            foregroundColor: Colors.white,
            backgroundColor: Colors.greenAccent[700],
            onPressed: model.isLoading
                ? null
                : () async {
                    await model.confirmOrder(context);
                  },
            icon: model.isLoading ? Icon(Icons.real_estate_agent_rounded) : null,
            label: Text(model.isLoading ? "Generando pedido" : "Confirmar pedido")),
      ),
    );
  }
}
