import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/config/application.dart';
import 'package:flutter_app/config/routes.dart';

class MainComponent extends StatefulWidget {
  @override
  State createState() {
    return new MainComponentState();
  }
}

class MainComponentState extends State<MainComponent> {
  MainComponentState() {
    final router = new Router();
    Routes.configureRoutes(router);
    Application.router = router;
  }

  @override
  Widget build(BuildContext context) {
    final app = new MaterialApp(
      home: Scaffold(
          appBar: AppBar(
        title: Text("Photos"),
      )),
      theme: new ThemeData.dark(),
      onGenerateRoute: Application.router.generator,
    );
    print("initial route = ${app.initialRoute}");
    return app;
  }
}
