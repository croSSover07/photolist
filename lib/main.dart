import 'package:flutter/material.dart';
import 'package:flutter_app/screens/app/app_component.dart';
import 'package:flutter_downloader/flutter_downloader.dart';

void main() {
  FlutterDownloader.initialize(maxConcurrentTasks: 3);
  runApp(new AppComponent());
}
