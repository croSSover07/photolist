import 'package:flutter_app/ext/common.dart';
import 'package:flutter_app/utils/constants.dart' as Constants;

class Photo {
  final String id;
  final String url;
  final String urlFull;
  final String createdAt;
  final int width;
  final int height;
  final int likes;
  final String description;
  final String downloadLink;
  final int views;
  final int downloads;
  final String instagramName;
  final String location;
  final int color;

  const Photo(
      {this.id,
      this.url,
      this.urlFull,
      this.createdAt,
      this.width,
      this.height,
      this.likes,
      this.description,
      this.downloadLink,
      this.views,
      this.downloads,
      this.instagramName,
      this.location,
      this.color});

  Photo.fromMap(Map<String, dynamic> map)
      : id = map[Constants.API.ID],
        url = map[Constants.API.URLS][Constants.API.SMALL],
        urlFull = map[Constants.API.URLS][Constants.API.FULL],
        createdAt = map[Constants.API.CREATED_AT],
        width = map[Constants.API.WIDTH],
        height = map[Constants.API.HEIGHT],
        likes = map[Constants.API.LIKES],
        description = map[Constants.API.DESCRIPTION],
        downloadLink = map[Constants.API.LINKS][Constants.API.DOWNLOAD],
        views = map[Constants.API.VIEWS],
        downloads = map[Constants.API.DOWNLOADS],
        instagramName =
            map[Constants.API.USER][Constants.API.INSTAGRAM_USERNAME],
        location = map.containsKey(Constants.API.LOCATION)
            ? map[Constants.API.LOCATION][Constants.API.TITLE]
            : null,
        color = hexToIntColor(map[Constants.API.COLOR]);
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  String toString() {
    return "Exception: $message";
  }
}
