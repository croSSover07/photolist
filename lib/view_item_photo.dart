import 'package:flutter/material.dart';

import 'data/photo.dart';

class PhotoListItem extends StatelessWidget {
  final Photo photo;

  PhotoListItem(this.photo);

  @override
  Widget build(BuildContext context) {
    return new ListTile(
      leading: new CircleAvatar(child: new Text(photo.id[0])),
      title: Container(
        child: new Text(photo.url),
        color: Colors.black26,
      )
    );
  }
}
