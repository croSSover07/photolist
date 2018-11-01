import 'dart:async';
import 'photo.dart';

abstract class PhotoRepository {
  Future<List<Photo>> init();
  Future<List<Photo>> loadMore();
}