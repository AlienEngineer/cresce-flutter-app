import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:http/http.dart' as http;

class HttpPost implements HttpMethod {
  HttpPipeline _pipeline;

  HttpPost(this._pipeline);

  Future<HttpResponse> post(String url, [Serializable body]) {
    return _pipeline.send(
      HttpRequest(
        method: this,
        body: body,
        uri: url,
      ),
    );
  }

  @override
  Future<http.Response> send(
    http.Client client,
    HttpRequest httpRequest,
    Encoder encoder,
  ) {
    return client.post(
      httpRequest.url,
      headers: httpRequest.headers,
      body: httpRequest.body?.serialize(encoder),
    );
  }
}

extension HttpPostExtensions on HttpPost {
  void postElement<T extends Deserialize>({
    String url,
    Serializable body,
    void Function(T data) onSuccess,
    void Function() onFailure,
    Deserialize deserialize,
  }) {
    this.post(url, body).then((value) {
      if (value.wasSuccess()) {
        onSuccess(value.deserialize<T>(deserialize));
      } else {
        onFailure();
      }
    });
  }
}
