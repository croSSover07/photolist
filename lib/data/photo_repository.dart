import 'dart:async';
import 'photo.dart';

abstract class PhotoRepository {
  String query;
  Future<List<Photo>> init();
  Future<List<Photo>> loadMore();
}