class Photo {
  final String id;
  final String url;

  const Photo({this.id, this.url});
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  String toString() {
    return "Exception: $message";
  }
}
