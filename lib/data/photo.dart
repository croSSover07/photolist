class Photo {
  final String id;
  final String url;

  const Photo({this.id, this.url});

  Photo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        url = map['urls']['small'];
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  String toString() {
    return "Exception: $message";
  }
}
