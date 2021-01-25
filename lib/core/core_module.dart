import 'package:cresce_flutter_app/core/core.dart';

class CoreModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton(NavigationManager());
  }
}
