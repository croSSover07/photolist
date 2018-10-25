import 'package:flutter/material.dart';
import 'package:flutter_app/data/photo.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;

  PhotoListItem(this.photo);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      title: Container(
        child: new Image.network(photo.url),
        color: Colors.black26,
      )
    );
  }
}
