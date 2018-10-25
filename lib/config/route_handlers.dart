import 'package:fluro/fluro.dart';
import 'package:flutter/material.dart';
import 'package:flutter_app/photos/photo_list_view.dart';
import 'package:flutter_app/photo/photo_page_view.dart';
import 'package:flutter_app/main/main_component.dart';

var rootHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new MainComponent();
    });

var mainHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      return new PhotoList();
    });


var photoHandler = new Handler(
    handlerFunc: (BuildContext context, Map<String, List<String>> params) {
      String photoId = params["photoId"]?.first;
      return new PhotoPage(photoId);
    });