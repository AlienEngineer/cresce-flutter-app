import 'package:cresce_flutter_app/core/http_requests/http_requests.dart';
import 'package:http/http.dart';
import 'package:http/testing.dart';

class HttpClientMock extends MockClient implements HttpClientFactory {
  bool wasClosed;

  HttpClientMock(fn) : super(fn);

  @override
  void close() {
    super.close();
    wasClosed = true;
  }

  @override
  Client makeClient() => this;
}
