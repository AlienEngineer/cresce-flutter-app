import 'package:cresce_flutter_app/core/core.dart';
import 'package:cresce_flutter_app/pages/employee_page_widget.dart';
import 'package:cresce_flutter_app/pages/login_page_widget.dart';

class PageWidgetsModule implements ServiceModule {
  @override
  void register(ServiceLocator locator) {
    locator.registerSingleton<EmployeePageWidget>(EmployeePageWidget(
      title: '',
    ));

    locator.registerSingleton<LoginPageWidget>(LoginPageWidget(
      title: '',
    ));
  }
}
