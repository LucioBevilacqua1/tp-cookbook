import 'package:flutter/material.dart';
import 'package:frontend/src/config/configs.dart';
import 'package:frontend/src/core/base_view.dart';
import 'package:frontend/src/core/view_state.dart';
import 'package:frontend/src/model/menu_item.dart';
import 'package:frontend/src/model/user_data.dart';
import 'package:frontend/src/screens/main/home/home_model.dart';

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
    double _width = MediaQuery.of(context).size.width;
    return BaseView<HomeModel>(
      onModelReady: (model) => model.onModelReady(context),
      builder: (context, model, child) => Scaffold(
        body: Container(
          child: ListView(
            children: <Widget>[
              Visibility(
                visible: Configs.currentUser.role == UserData.ADMIN,
                child: Padding(
                  padding:
                      EdgeInsets.fromLTRB(_width * .1, 15, _width * .1, 15),
                  child: InkWell(
                    onTap: () {
                      setState(() async {
                        model.switchCreateMode();
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.green,
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
                visible: model.createMode,
                child: Container(
                  width: _width,
                  padding: EdgeInsets.only(top: 50),
                  child: Column(
                    children: <Widget>[
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
                                await model.createMenuItem(context);
                              }
                            : null,
                        child: Container(
                          height: 45,
                          width: _width / 1.2,
                          decoration: BoxDecoration(
                              color: Colors.green[600],
                              borderRadius:
                                  BorderRadius.all(Radius.circular(50))),
                          child: Center(
                            child: model.viewState == ViewState.Idle
                                ? Text(
                                    'Crear'.toUpperCase(),
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
                        height: 50,
                        color: Colors.transparent,
                      )
                    ],
                  ),
                ),
              ),
              Divider(),
              Container(
                width: _width,
                color: Colors.orange,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.center,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 20, top: 20),
                        child: Text(
                          'Comidas/Bebidas',
                          style: TextStyle(color: Colors.white, fontSize: 18),
                        ),
                      ),
                    ),
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
              ListView.builder(
                  padding: EdgeInsets.fromLTRB(0, 0, 0, 0),
                  itemCount: model.allMenuItems.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    MenuItem menuItem = model.allMenuItems[index];
                    return Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                        child: Card(
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              children: [
                                Text(menuItem.name),
                                Text("Descripción: " + menuItem.description),
                                Text("Precio: " +
                                    menuItem.price.toStringAsFixed(1))
                              ],
                            ),
                          ),
                        ));
                  })
            ],
          ),
        ),
      ),
    );
  }
}
