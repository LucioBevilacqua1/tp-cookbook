import 'package:flutter/material.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:frontend/src/screens/main/home/home_model.dart';
import 'package:toast/toast.dart';

class HomeView extends StatefulWidget {
  HomeView();

  @override
  HomeViewState createState() {
    return HomeViewState();
  }
}

class HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final GlobalKey<ScaffoldState> _scaffoldHomeViewKey =
        GlobalKey<ScaffoldState>();
    double _width = MediaQuery.of(context).size.width;
    return BaseView<HomeModel>(
      onModelReady: (model) => model.onModelReady(context),
      builder: (context, model, child) => Scaffold(
        key: _scaffoldHomeViewKey,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              Visibility(
                visible: Configs.currentUser.role == UserData.ADMIN,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(_width * .1, 15, _width * .1, 15),
                  child: InkWell(
                    onTap: () {
                      setState(() {
                        model.switchOpenForm();
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
                                    'Crear Comida/Bebida',
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
                visible: model.openForm,
                child: Container(
                  width: _width,
                  padding: EdgeInsets.only(top: 10),
                  child: Column(
                    children: <Widget>[
                      Visibility(
                        visible: !model.createMode,
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 15),
                          child: InkWell(
                            onTap: model.viewState == ViewState.Idle
                                ? () async {
                                    model.switchCreateMode();
                                  }
                                : null,
                            child: Container(
                              height: 45,
                              width: _width * .3,
                              decoration: BoxDecoration(
                                  color: model.editMode
                                      ? Colors.teal
                                      : Colors.green[800],
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(50))),
                              child: Center(
                                child: model.viewState == ViewState.Idle
                                    ? Text(
                                        'Modo crear',
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
                        ),
                      ),
                      Container(
                        width: _width / 1.2,
                        height: 45,
                        padding: EdgeInsets.only(
                            top: 4, left: 16, right: 16, bottom: 4),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: model.nameTextController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Nombre',
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
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: model.descriptionTextController,
                          textCapitalization: TextCapitalization.words,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Descripción',
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
                            borderRadius: BorderRadius.all(Radius.circular(50)),
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(color: Colors.black12, blurRadius: 5)
                            ]),
                        child: TextField(
                          controller: model.priceTextController,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            hintText: 'Precio',
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      InkWell(
                        onTap: model.viewState == ViewState.Idle
                            ? () async {
                                if (model.createMode) {
                                  await model.createMenuItem(context);
                                }
                                if (model.editMode) {
                                  await model.editMenuItem(context);
                                }
                              }
                            : null,
                        child: Container(
                          height: 45,
                          width: _width / 1.2,
                          decoration: BoxDecoration(
                              color: model.editMode
                                  ? Colors.teal
                                  : Colors.green[800],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: model.viewState == ViewState.Idle
                                ? Text(
                                    model.editMode ? 'EDITAR' : 'CREAR',
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
                        height: 40,
                        color: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ),
              Divider(
                color: Colors.transparent,
              ),
              Container(
                width: _width,
                color: Colors.teal,
                child: Row(
                  children: [
                    Expanded(
                      child: Align(
                        alignment: Alignment.center,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              bottom: 20, top: 20, left: 65),
                          child: Text(
                            'Comidas/Bebidas',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        List args = [model.orderItems];
                        Navigator.of(context)
                            .pushNamed('/previewOrderView', arguments: args);
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15),
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Icon(
                                Icons.shopping_cart,
                                size: 40,
                              ),
                            ),
                            Positioned(
                                right: 7,
                                child: Container(
                                  width: 20,
                                  decoration: BoxDecoration(
                                      color: Colors.red,
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(15))),
                                  child: Center(
                                    child: Text(
                                      model.orderItems.length.toString(),
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 15,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ),
                                ))
                          ],
                        ),
                      ),
                    )
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
              Visibility(
                visible: model.viewState == ViewState.Idle,
                child: Expanded(
                  child: ListView.builder(
                      padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                      itemCount: model.allMenuItems.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        MenuItem menuItem = model.allMenuItems[index];
                        return Padding(
                            padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                            child: Card(
                              child: Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(0, 10, 8, 10),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Row(
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              setState(() {
                                                model.orderItems.add(menuItem);
                                                Toast.show("Agregado al pedido",
                                                    context,
                                                    duration:
                                                        Toast.LENGTH_SHORT,
                                                    gravity: Toast.TOP);
                                              });
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 20,
                                                  right: 20,
                                                  top: 20,
                                                  bottom: 20),
                                              child: Text(
                                                "AGREGAR\nA PEDIDO",
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.teal,
                                                    fontSize: 12),
                                              ),
                                            ),
                                          ),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  menuItem.name,
                                                  style: TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold),
                                                ),
                                                Text(
                                                  "Descripción: " +
                                                      menuItem.description,
                                                  maxLines: 2,
                                                ),
                                                Divider(
                                                  height: 10,
                                                  color: Colors.transparent,
                                                ),
                                                Text("Precio: " +
                                                    menuItem.price
                                                        .toStringAsFixed(1)),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Column(
                                      children: [
                                        Visibility(
                                          visible:
                                              Configs.currentUser.isAdmin(),
                                          child: InkWell(
                                            onTap: () {
                                              model.switchEditMode(
                                                  menuItem: menuItem);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.edit,
                                                color: Colors.teal,
                                              ),
                                            ),
                                          ),
                                        ),
                                        Visibility(
                                          visible:
                                              Configs.currentUser.isAdmin(),
                                          child: InkWell(
                                            onTap: () async {
                                              await model.deleteMenuItem(
                                                  menuItem: menuItem);
                                              Toast.show(
                                                  "Comida eliminada con éxito",
                                                  _scaffoldHomeViewKey
                                                      .currentContext,
                                                  duration: Toast.LENGTH_LONG,
                                                  gravity: Toast.TOP);
                                            },
                                            child: Padding(
                                              padding: const EdgeInsets.all(5),
                                              child: Icon(
                                                Icons.close,
                                                color: Colors.red[800],
                                              ),
                                            ),
                                          ),
                                        )
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ));
                      }),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
