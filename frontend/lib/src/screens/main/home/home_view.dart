import 'package:flutter/material.dart';
import 'package:frontend/src/core/base_view.dart';
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
    return BaseView<HomeModel>(
      onModelReady: (model) => model.onModelReady(),
      builder: (context, model, child) => Scaffold(
        backgroundColor: Colors.white,
        appBar: AppBar(
          iconTheme: IconThemeData(
            color: Colors.pink[800], //change your color here
          ),
          backgroundColor: Colors.white,
          elevation: 0,
          centerTitle: true,
          title: Text("Cookbook",
              style: TextStyle(
                  color: Colors.grey[900],
                  fontSize: 35,
                  fontFamily: 'BebasNeue')),
        ),
        body: Container(
          width: MediaQuery.of(context).size.width,
          child: Padding(
            padding: const EdgeInsets.all(24.0),
            child: Column(
              children: [Text("Hello mundo")],
            ),
          ),
        ),
      ),
    );
  }
}
