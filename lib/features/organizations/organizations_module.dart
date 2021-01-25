import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';

class OrganizationsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory(
      () => OrganizationServices(
        locator.get<HttpGet>(),
      ),
    );
  }
}
