class Photo {
  final String id;
  final String url;
  final String urlFull;
  final String createdAt;
  final int width;
  final int height;
  final int likes;
  final String description;
  final String downloadLink;
  final int views;
  final int downloads;
  final String instagramName;
  final String location;

  const Photo({
    this.id,
    this.url,
    this.urlFull,
    this.createdAt,
    this.width,
    this.height,
    this.likes,
    this.description,
    this.downloadLink,
    this.views,
    this.downloads,
    this.instagramName,
    this.location,
  });

  Photo.fromMap(Map<String, dynamic> map)
      : id = map['id'],
        url = map['urls']['small'],
        urlFull = map['urls']['full'],
        createdAt = map['created_at'],
        width = map['width'],
        height = map['height'],
        likes = map['likes'],
        description = map['description'],
        downloadLink = map['links']['download'],
        views = map['views'],
        downloads = map['downloads'],
        instagramName = map['user']['instagram_username'],
        location = map.containsKey('location') ? map['location']['title'] : null;
}

class FetchDataException implements Exception {
  String message;

  FetchDataException(this.message);

  String toString() {
    return "Exception: $message";
  }
}
