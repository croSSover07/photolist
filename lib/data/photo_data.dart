import 'dart:async';
import 'dart:convert';

import 'package:flutter_app/net/http_client.dart';
import 'package:flutter_app/utils/constants.dart' as Constants;
import 'package:http/http.dart' as http;

import 'photo.dart';
import 'photo_repository.dart';

class ServerPhotoRepository extends PhotoRepository {
  var url = "https://api.unsplash.com/photos";
  var searchUrl = "https://api.unsplash.com/search/photos";
  final JsonDecoder decoder = new JsonDecoder();

  var httpClient = UserHttpClient(http.Client());

  static const int PER_PAGE = 10;
  int page = 1;

  @override
  String query;

  Future<List<Photo>> fetch() {
    return httpClient.get(request()).then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while getting photos [StatusCode:$statusCode, Error:${response}]");
      }

      final photosContainer = query == null
          ? decoder.convert(jsonBody) as List
          : (decoder.convert(jsonBody)
              as Map<String, dynamic>)[Constants.API.RESULTS] as List;

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
    return (query != null
            ? "$searchUrl?${Constants.API.QUERY}=$query&&"
            : "$url?") +
        "${Constants.API.PAGE}=$page&&${Constants.API.PER_PAGE}=$PER_PAGE";
  }
}
