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
    showModalBottomSheet(
        context: context,
        builder: (builder) {
          return new Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            new ListTile(
              leading: new Text("Instagram"),
              title: new Text("dfadfadf"),
            ),
            new ListTile(
              leading: new Text("Width"),
              title: new Text('Music1'),
            ),
            new ListTile(
              leading: new Text("Height"),
              title: new Text('Music2'),
            ),
            new ListTile(
              leading: new Text("Location"),
              title: new Text('Music3'),
            ),
            new ListTile(
              leading: new Text("Views"),
              title: new Text('Music3'),
            ),
            new ListTile(
              leading: new Text("Downloads"),
              title: new Text('Music3'),
            ),
            new Row(
              children: <Widget>[
                new Expanded(
                    child: new Column(children: <Widget>[
                  new IconButton(icon: new Icon(Icons.image), onPressed: () {}),
                  new Text(
                    "Set As",
                  )
                ])),
                new Expanded(
                    child: new Column(children: <Widget>[
                  new IconButton(
                      icon: new Icon(Icons.file_download), onPressed: () {}),
                  new Text("Download")
                ])),
              ],
            )
          ]);
        });
  }
}
