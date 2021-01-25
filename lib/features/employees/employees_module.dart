import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/features/employees/employees.dart';

class EmployeesModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerFactory<EmployeeServices>(() {
      return EmployeeServices(locator.get<HttpGet>());
    });
  }
}
