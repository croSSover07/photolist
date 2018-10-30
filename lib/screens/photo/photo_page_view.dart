import 'package:flutter/material.dart';
import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/net/http_client.dart' as http;
import 'package:photo_view/photo_view.dart';

import 'contract.dart';
import 'presenter.dart';

class PhotoPage extends StatelessWidget {
  final String photoId;

  PhotoPage(this.photoId);

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      body: new PhotoPageView(photoId),
    );
  }
}

class PhotoPageView extends StatefulWidget {
  final String photoId;

  PhotoPageView(this.photoId);

  @override
  State createState() => new PhotoPageViewState(photoId);
}

class PhotoPageViewState extends State<PhotoPageView>
    implements PhotoContractView {
  bool isLoad = false;
  PhotoContractPresenter presenter;
  String photoId;
  Photo photo;
  VoidCallback showModalBottomSheetCallback;
  final scaffoldKey = new GlobalKey<ScaffoldState>();

  PhotoPageViewState(this.photoId) {
    presenter = PhotoPageViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();

    showModalBottomSheetCallback = showBottomSheet;
    isLoad = true;
    presenter.loadPhoto();
  }

  @override
  void onLoadError() {}

  @override
  void onLoadComplete(Photo item) {
    setState(() {
      isLoad = false;
      photo = item;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget widget;

    if (isLoad) {
      widget = new Center(
          child: new Padding(
              padding: const EdgeInsets.only(left: 16.0, right: 16.0),
              child: new CircularProgressIndicator()));
    } else {
      widget = new Scaffold(
        key: scaffoldKey,
        body: new PhotoView(
            imageProvider: NetworkImage(photo.url, headers: http.headers)),
        floatingActionButton: new IconButton(
          icon: new Icon(Icons.info_outline),
          onPressed: showModalBottomSheetCallback,
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
      );
    }
    return widget;
  }

  void showBottomSheet() {
    List<Widget> list = [];

    photo.instagramName != null
        ? list.add(new ListTile(
            leading: new Text("Instagram"),
            title: new Text(photo.instagramName )))
        : {};

    list.add(new ListTile(
      leading: new Text("Width"),
      title: new Text(photo.width.toString()),
    ));

    list.add(new ListTile(
      leading: new Text("Height"),
      title: new Text(photo.height.toString()),
    ));

    photo.location != null
        ? list.add(new ListTile(
            leading: new Text("Location"),
            title: new Text(photo.location),
          ))
        : {};

    list.add(new ListTile(
      leading: new Text("Downloads"),
      title: new Text(photo.downloads.toString()),
    ));

    list.add(new Row(children: <Widget>[
      new Expanded(
          child: new Column(children: <Widget>[
        new IconButton(icon: new Icon(Icons.image), onPressed: () {}),
        new Text(
          "Set As",
        )
      ])),
      new Expanded(
          child: new Column(children: <Widget>[
        new IconButton(icon: new Icon(Icons.file_download), onPressed: () {}),
        new Text("Download")
      ])),
    ]));

    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Column(mainAxisSize: MainAxisSize.min, children: list);
        });
  }
}
