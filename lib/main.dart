import 'package:flutter/material.dart';

import 'photo_list.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text("Photos"),
        ),
        body: Container(
          child: new PhotoList(),
        ),
      ),
      theme: new ThemeData.dark(),
    ));
