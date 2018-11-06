import 'dart:async';
import 'dart:io' show Platform;

import 'package:path_provider/path_provider.dart';

Future<String> findLocalPath() async {
  final directory = Platform.isAndroid
      ? await getExternalStorageDirectory()
      : await getApplicationDocumentsDirectory();
  return directory.path;
}

Future<bool> checkPermission() async {
//  if (Platform.isAndroid) {
//    PermissionHandler()
//        .checkPermissionStatus(PermissionGroup.storage)
//        .then((onValue) {
//      if (onValue != PermissionStatus.granted) {
//        PermissionHandler()
//            .requestPermissions([PermissionGroup.storage]).then((onValue) {
//          if (onValue[PermissionGroup.storage] == PermissionStatus.granted) {
//            return true;
//          }
//        });
//      } else {
//        return true;
//      }
//    });
//  } else {
//    return true;
//  }
  return false;
}
