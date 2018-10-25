import 'package:flutter/material.dart';
import 'photo/photo_page_view.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Photos"),
        ),
        body: Container(
          child: new PhotoPage(),
        ),
      ),
      theme: new ThemeData.dark(),
    ));
