import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/features.dart';

class AuthenticationModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<LoginServices>(() {
      return LoginServices(
        locator.get<HttpPost>(),
        locator.get<TokenRepository>(),
      );
    });

    locator.registerSingleton(TokenRepository());
  }
}
