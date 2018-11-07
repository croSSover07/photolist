import 'package:flutter/material.dart';
import 'package:flutter_app/config/routes.dart';
import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/utils/constants.dart' as Constant;

class PhotoListItem extends StatelessWidget {
  final Photo photo;

  PhotoListItem(this.photo);

  @override
  Widget build(BuildContext context) {
    return new AspectRatio(
      aspectRatio: photo.width / photo.height,
      child: new Stack(
        children: <Widget>[
          new Positioned.fill(
            child: Container(
              padding: new EdgeInsets.all(8.0),
              child: new Image.network(
                photo.url,
                fit: BoxFit.cover,
              ),
            ),
          ),
          new Positioned.fill(
              child: Material(
            color: Colors.transparent,
            child: new InkWell(
              splashColor: Color(photo.color).withOpacity(0.5),
              onTap: () {
                Navigator.pushNamed(context,
                    Routes.photo + "?${Constant.Router.photoId}=${photo.id}");
              },
            ),
          ))
        ],
      ),
    );
  }
}
