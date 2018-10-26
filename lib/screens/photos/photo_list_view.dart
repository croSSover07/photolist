import 'package:flutter/material.dart';
import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/screens/photos/contract.dart';
import 'package:flutter_app/screens/photos/presenter.dart';
import 'package:flutter_app/screens/photos/view_item_photo.dart';

class PhotoList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new PhotoListState();
}

class PhotoListState extends State<PhotoList> implements PhotoListView {
  PhotoListPresenter presenter;

  List<Photo> contactList;

  bool isLoading;

  PhotoListState() {
    presenter = new PhotoPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    isLoading = true;
    presenter.loadPhotos();
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoading) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Scaffold(
        appBar: AppBar(
          title: Text("Photos"),
        ),
        body: new ListView(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            children: buildPhotoList()),
      );
    }
    return widget;
  }

  List<PhotoListItem> buildPhotoList() {
    return contactList.map((item) => new PhotoListItem(item)).toList();
  }

  @override
  void onLoadComplete(List<Photo> items) {
    setState(() {
      contactList = items;
      isLoading = false;
    });
  }

  @override
  void onLoadError() {}
}
