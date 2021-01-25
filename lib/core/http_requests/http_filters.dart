import 'http_requests.dart';

abstract class HttpRequestFilter {
  HttpRequest filterRequest(HttpRequest request);
}

abstract class HttpResponseFilter {
  HttpResponse filterResponse(HttpResponse response);
}

class SetAuthorityRequestFilter implements HttpRequestFilter {
  final String authority;

  SetAuthorityRequestFilter(this.authority);

  @override
  HttpRequest filterRequest(HttpRequest request) {
    request.authority = authority;
    return request;
  }
}

class SetContentTypeRequestFilter implements HttpRequestFilter {
  final Formatters formatters;

  SetContentTypeRequestFilter(this.formatters);

  @override
  HttpRequest filterRequest(HttpRequest request) {
    request.headers['content-type'] = formatters.getContentType();
    return request;
  }
}
