import 'package:http/http.dart' as http;

class UserHttpClient extends http.BaseClient {
  final String API_KEY =
      "8fff53d2a95e4748487afe13bb8d52cee104cddb6004119b61bfc141bb674500";
  final http.Client client;

  UserHttpClient(this.client);

  @override
  Future<http.StreamedResponse> send(http.BaseRequest request) {
    request.headers["Authorization"] = "Client-ID $API_KEY";
    request.headers["Accept-Version"] = "v1";
    return client.send(request);
  }
}