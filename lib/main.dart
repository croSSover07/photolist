import 'package:flutter/material.dart';
import 'photo_list.dart';
import 'data/photo_data_mock.dart';

void main() => runApp(MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.blueAccent,
        appBar: AppBar(
          title: Text("Title"),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.add), onPressed: null),
            IconButton(icon: Icon(Icons.delete), onPressed: null)
          ],
        ),
        body: Container(
          color: Colors.red,
          child: new PhotoList(photos),
        ),
        drawer: Drawer(
          child: ListView(
            children: <Widget>[
              DrawerHeader(
                child: Text("Drawer Header", textAlign: TextAlign.center),
                decoration: BoxDecoration(color: Colors.yellow),
              ),
              Text(
                "1111111",
                textAlign: TextAlign.center,
              ),
              Text("2222222")
            ],
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), title: Text("Home")),
          BottomNavigationBarItem(
              icon: Icon(Icons.skip_next), title: Text("Next"))
        ]),
      ),
    ));
