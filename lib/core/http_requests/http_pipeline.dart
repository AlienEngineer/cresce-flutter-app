import 'package:cresce_flutter_app/core/http_requests/formaters/decoders.dart';
import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;

class HttpPipeline {
  final HttpClientFactory factory;
  final Formatters formatters;

  final List<HttpResponseFilter> responseFilters;
  final List<HttpRequestFilter> requestFilters;

  HttpPipeline(
    this.factory,
    this.formatters, {
    this.responseFilters,
    this.requestFilters,
  });

  Future<HttpResponse> send(HttpRequest request) async {
    var client = factory.makeClient();
    try {
      var httpRequest = _applyRequestFilters(request);

      var response = await httpRequest._send(client, formatters.encoder);

      var httpResponse = _convertToHttpResponse(httpRequest, response);

      httpResponse = _applyResponseFilters(httpResponse);

      return httpResponse;
    } finally {
      client.close();
    }
  }

  HttpRequest _applyRequestFilters(HttpRequest httpRequest) {
    if (requestFilters != null) {
      for (var filter in requestFilters) {
        httpRequest = filter.filterRequest(httpRequest);
      }
    }
    return httpRequest;
  }

  HttpResponse _applyResponseFilters(HttpResponse httpResponse) {
    if (responseFilters != null) {
      for (var filter in responseFilters) {
        httpResponse = filter.filterResponse(httpResponse);
      }
    }
    return httpResponse;
  }

  HttpResponse _convertToHttpResponse(
    HttpRequest request,
    http.Response response,
  ) {
    return HttpResponse(
      formatters.decoder,
      request: request,
      statusCode: response.statusCode,
      content: response.body,
    );
  }
}

class HttpRequest {
  String authority;
  final String uri;
  final Serializable body;
  final Map<String, String> headers;
  final HttpMethod method;

  HttpRequest({
    this.authority,
    this.method,
    this.uri,
    this.body,
  }) : headers = {};

  String get url => _makeUrl(uri);

  Future<http.Response> _send(http.Client client, Encoder encoder) {
    return method.send(
      client,
      this,
      encoder,
    );
  }

  String _makeUrl(String uri) => _combine([authority, uri]);

  String _combine(List<String> list) {
    return list.map((part) {
      return part.endsWith('/') ? part.substring(0, part.length - 1) : part;
    }).join('/');
  }
}

abstract class HttpMethod {
  Future<http.Response> send(
    http.Client client,
    HttpRequest httpRequest,
    Encoder encoder,
  );
}

class HttpResponse extends Equatable {
  final Decoder decoder;
  final HttpRequest request;
  final int statusCode;
  final String content;

  HttpResponse(
    this.decoder, {
    this.request,
    this.statusCode,
    this.content,
  });

  @override
  List<Object> get props => [statusCode, content];

  bool wasSuccess() => [200, 201].contains(statusCode);

  T deserialize<T>(Deserialize obj) => _cast<T>(
      shouldDeserialize() ? obj.deserialize(decoder.decode(content)) : obj);

  bool shouldDeserialize() => wasSuccess() && content != null;

  List<T> deserializeList<T>(Deserialize obj) {
    var mapped = decoder.decodeList(content);

    final casting = mapped.cast<Map<String, dynamic>>();

    return casting.map<T>((f) => obj.deserialize(f) as T).toList();
  }

  T _cast<T>(Object obj) => obj as T;
}

class HttpClientFactory {
  http.Client makeClient() => http.Client();
}

abstract class Serializable {
  String serialize(Encoder encoder);
}

abstract class Deserialize {
  Object deserialize(Map<String, dynamic> data);
}

abstract class DeserializeList {
  List<Object> deserialize(List data);
}
