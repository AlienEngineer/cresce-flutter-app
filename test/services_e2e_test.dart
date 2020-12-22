import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organization.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'monitor.dart';

main() {
  EquatableConfig.stringify = true;
  var locator = makeServiceLocator(override: (locator) {});

  group('integration', () {
    test('login in with valid credentials returns auth token', () async {
      var monitor = _makeMonitor();
      var services = locator.get<LoginServices>();

      Token loginResult;
      services.login(
        Credentials(user: 'myUser', password: 'myPass'),
        onSuccess: (result) {
          loginResult = result;
          monitor.signal();
        },
        onFailure: () => monitor.signal(),
      );
      await monitor.wait();

      expect(loginResult, isNotNull);
      expect(loginResult.token, isNotNull);
      expect(loginResult.token, isNotEmpty);
    });

    test('fetching employees for a given organization returns employees',
        () async {
      var monitor = _makeMonitor();
      var services = locator.get<EmployeeServices>();

      await login(locator);
      List<Employee> employees;
      services.fetchEmployees(
        Organization(name: 'myOrganization'),
        onSuccess: (result) {
          employees = result;
          monitor.signal();
        },
        onFailure: () => monitor.signal(),
      );

      await monitor.wait();

      expect(employees, [Employee(name: 'Ricardo Nunes')]);
    });
  });
}

Future login(ServiceLocator locator) async {
  var monitor = _makeMonitor();
  var services = locator.get<LoginServices>();

  services.login(
    Credentials(user: 'myUser', password: 'myPass'),
    onSuccess: (_) => monitor.signal(),
    onFailure: () => monitor.signal(),
  );
  await monitor.wait();
}

Monitor _makeMonitor() {
  return Monitor(
    waitTime: const Duration(milliseconds: 10),
    tries: 1000,
  );
}
