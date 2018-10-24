import 'data/photo.dart';
import 'view_item_photo.dart';
import 'package:flutter/material.dart';

class PhotoList extends StatelessWidget {

  final List<Photo> photoList;

  PhotoList(this.photoList);

  @override
  Widget build(BuildContext context) {
    return new ListView(
        padding: new EdgeInsets.symmetric(vertical: 8.0),
        children: buildPhotoList()
    );
  }

  List<PhotoListItem> buildPhotoList() {
    return photoList.map((contact) => new PhotoListItem(contact))
        .toList();
  }

}