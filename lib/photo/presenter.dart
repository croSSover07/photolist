import 'dart:convert';

import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/net/http_client.dart';
import 'package:http/http.dart' as http;

import 'contract.dart';

class PhotoPageViewPresenter extends PhotoContractPresenter {
  final PhotoContractView view;

  PhotoPageViewPresenter(this.view);

  var httpClient = UserHttpClient(http.Client());
  var url = "https://api.unsplash.com/photos";
  final JsonDecoder decoder = new JsonDecoder();

  @override
  void loadPhoto() {
    assert(view != null);

    httpClient.get("$url/${view.photoId}").then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while getting contacts [StatusCode:$statusCode, Error:${response}]");
      }
      final photoContainer = decoder.convert(jsonBody);
      return new Photo.fromMap(photoContainer);
    }).then((Photo onValue) {
      return view.onLoadComplete(onValue);
    });
  }
}
