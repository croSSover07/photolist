import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/net/http_client.dart';
import 'package:http/http.dart' as http;

import 'photo.dart';
import 'photo_repository.dart';

class ServerPhotoRepository extends PhotoRepository {
  var url = "https://api.unsplash.com/photos";
  final JsonDecoder decoder = new JsonDecoder();

  var httpClient = UserHttpClient(http.Client());

  static const int PER_PAGE = 10;
  int page = 1;

  Future<List<Photo>> fetch() {
    return httpClient.get(request()).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while getting photos [StatusCode:$statusCode, Error:${response}]");
      }
      final photosContainer = decoder.convert(jsonBody) as List;
      return photosContainer.map((row) => new Photo.fromMap(row)).toList();
    });
  }

  @override
  Future<List<Photo>> init() {
    page = 1;
    return fetch();
  }

  @override
  Future<List<Photo>> loadMore() {
    page++;
    return fetch();
  }

  String request() {
    return "$url?page=$page&&per_page=$PER_PAGE";
  }
}
