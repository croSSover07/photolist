import 'dart:async';
import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_app/data/photo.dart';
import 'package:flutter_app/net/http_client.dart';
import 'package:flutter_app/utils/common.dart';
import 'package:flutter_downloader/flutter_downloader.dart';
import 'package:http/http.dart' as http;

import 'contract.dart';

class PhotoPageViewPresenter extends PhotoContractPresenter {
  static const platform = const MethodChannel('flutter/app');

  var httpClient = UserHttpClient(http.Client());
  var url = "https://api.unsplash.com/photos";
  final JsonDecoder decoder = new JsonDecoder();

  Photo photo;
  final PhotoContractView view;

  PhotoPageViewPresenter(this.view);

  @override
  void loadPhoto() {
    assert(view != null);

    httpClient.get("$url/${view.photoId}").then((http.Response response) {
      final String jsonBody = response.body;
      final statusCode = response.statusCode;

      if (statusCode < 200 || statusCode >= 300 || jsonBody == null) {
        throw new FetchDataException(
            "Error while getting photo [StatusCode:$statusCode, Error:${response}]");
      }
      final photoContainer = decoder.convert(jsonBody);
      return new Photo.fromMap(photoContainer);
    }).then((Photo onValue) {
      photo = onValue;
      return view.onLoadComplete(photo);
    });
  }

  @override
  void downloadPhoto() {
    findLocalPath().then((onValue) {
      var saveDir = onValue + '/Download';
      FlutterDownloader.enqueue(
          url: photo.downloadLink,
          savedDir: saveDir,
          fileName: "${photo.id}.jpg",
          showNotification: true,
          openFileFromNotification: false);
    });
  }

  @override
  void setWallPaper() async {
    platform.invokeMethod('setWallByUrl', photo.downloadLink);
  }

  @override
  void openInstaProfile(){
    platform.invokeMethod('showInstaProfile', photo.instagramName);
  }
}
