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

  PhotoPageViewState(this.photoId) {
    presenter = PhotoPageViewPresenter(this);
  }

  @override
  void initState() {
    super.initState();

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
      widget = new PhotoView(
          imageProvider: NetworkImage(photo.url, headers: http.headers));
    }
    return widget;
  }
}
