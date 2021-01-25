import 'dart:io';
import 'package:cresce_flutter_app/core/core.dart';

class HttpModule implements ServiceModule {
  String _authority;

  HttpModule(this._authority);

  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton<Formatters>(JsonFormatter());
    locator.registerSingleton<HttpClientFactory>(HttpClientFactory());
    locator.registerFactory(
      () => HttpPipeline(
        locator.get<HttpClientFactory>(),
        locator.get<Formatters>(),
        responseFilters: [
          PrintHttpFilter(),
        ],
        requestFilters: [
          SetAuthorityRequestFilter(_authority),
          SetContentTypeRequestFilter(locator.get<Formatters>()),
          SetAuthorizationHeader(locator.get<TokenRepository>()),
          PrintHttpFilter(),
        ],
      ),
    );
    locator.registerFactory<HttpPost>(() {
      return HttpPost(locator.get<HttpPipeline>());
    });
    locator.registerFactory<HttpGet>(() {
      return HttpGet(locator.get<HttpPipeline>());
    });
  }
}

class SetAuthorizationHeader implements HttpRequestFilter {
  final TokenRepository _tokenRepository;

  SetAuthorizationHeader(this._tokenRepository);

  @override
  HttpRequest filterRequest(HttpRequest request) {
    var token = _tokenRepository.getToken();

    if (token != null) {
      request.headers[HttpHeaders.authorizationHeader] = token.toBearer();
    }

    return request;
  }
}

class PrintHttpFilter implements HttpResponseFilter, HttpRequestFilter {
  @override
  HttpResponse filterResponse(HttpResponse response) {
    print('StatusCode: ${response.statusCode}');
    print('Content: ${response.content}');
    return response;
  }

  @override
  HttpRequest filterRequest(HttpRequest request) {
    print('Url: ${request.url}');
    print('Headers: ${request.headers}');
    return request;
  }
}
