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
  ScrollController scrollController = new ScrollController();

  bool isLoading;
  bool isInit;

  PhotoListState() {
    presenter = new PhotoPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    isLoading = true;
    isInit = true;

    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        isLoading = true;
        presenter.loadPhotos(false);
      }
    });
    presenter.loadPhotos(isInit);
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isInit) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Scaffold(
          appBar: AppBar(
            title: Text("Photos"),
          ),
          body: ListView.builder(
            padding: new EdgeInsets.symmetric(vertical: 8.0),
            controller: scrollController,
            itemCount: contactList.length + 1,
            itemBuilder: (context, index) {
              return index == contactList.length
                  ? buildProgressIndicator()
                  : buildItem(index);
            },
          ));
    }
    return widget;
  }

  PhotoListItem buildItem(int index) {
    return PhotoListItem(contactList[index]);
  }

  @override
  void onLoadComplete(List<Photo> items) {
    setState(() {
      if (items.isEmpty) {
        double edge = 56.0;
        double offsetBottom = scrollController.position.maxScrollExtent -
            scrollController.position.pixels;
        if (offsetBottom < edge) {
          scrollController.animateTo(
              scrollController.offset - (edge - offsetBottom),
              duration: Duration(milliseconds: 500),
              curve: Curves.easeOut);
        }
      }
      isInit ? contactList = items : contactList.addAll(items);
      isLoading = false;
      isInit = false;
    });
  }

  @override
  void onLoadError() {}

  Widget buildProgressIndicator() {
    return new Padding(
      padding: const EdgeInsets.all(8.0),
      child: new Center(
        child: new Opacity(
          opacity: !isLoading ? 1.0 : 0.0,
          child: new CircularProgressIndicator(),
        ),
      ),
    );
  }
}
