import 'dart:async';

import 'photo.dart';
import 'photo_repository.dart';

class MockPhotoRepository extends PhotoRepository {
  @override
  Future<List<Photo>> fetch() {
    return new Future.value(photos);
  }
}

const photos = const <Photo>[
  const Photo(
      id: "0",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "1",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "2",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "3",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "4",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "5",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "6",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "7",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "9",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "A",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "B",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "C",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg"),
  const Photo(
      id: "D",
      url: "https://amayei.nyc3.digitaloceanspaces.com/2018/09/wea.jpg")
];
