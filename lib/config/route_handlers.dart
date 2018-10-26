import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/screens/photos/photo_list_view.dart';
import 'package:flutter_app/screens/photo/photo_page_view.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PhotoList();
    });

var photoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String photoId = params["photoId"]?.first;
      return new PhotoPage(photoId);
    });