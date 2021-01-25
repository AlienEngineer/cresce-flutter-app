import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:http/http.dart' as http;

class HttpGet implements HttpMethod {
  HttpPipeline _pipeline;

  HttpGet(this._pipeline);

  Future<HttpResponse> get(String url) {
    return _pipeline.send(
      HttpRequest(
        method: this,
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
    return client.get(
      httpRequest.url,
      headers: httpRequest.headers,
    );
  }
}

extension HttpGetExtensions on HttpGet {
  Future<List<T>> getList<T extends Deserialize>({
    String url,
    Deserialize deserialize,
  }) async {
    var value = await this.get(url);
    if (value.wasSuccess()) {
      return value.deserializeList(deserialize);
    }
    return [];
  }

  void fetchList<T extends Deserialize>({
    String url,
    void Function(List<T> data) onSuccess,
    void Function() onFailure,
    Deserialize deserialize,
  }) async {
    var value = await this.get(url);
    if (value.wasSuccess()) {
      onSuccess(value.deserializeList(deserialize));
    } else {
      onFailure();
    }
  }
}
