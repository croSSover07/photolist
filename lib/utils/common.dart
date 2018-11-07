import 'dart:async';
import 'dart:io' show Platform;

import 'package:path_provider/path_provider.dart';

Future<String> findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}
