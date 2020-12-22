import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/http_requests/http_requests.dart';
import 'package:cresce_flutter_app/services_locator.dart';

class AuthenticationModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<LoginServices>(() {
      return LoginServices(
        locator.get<HttpPost>(),
        locator.get<TokenRepository>(),
      );
    });
  }
}
