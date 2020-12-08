import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organization.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import 'monitor.dart';

main() {
  EquatableConfig.stringify = true;

  group('integration', () {
    test('login in with valid credentials returns auth token', () async {
      var monitor = _makeMonitor();
      var services = get<LoginServices>();

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

    test('login in with valid credentials returns auth token', () async {
      var monitor = _makeMonitor();
      var services = get<EmployeeServices>();

      var token = await login();
      List<Employee> employees;
      services.fetchEmployees(
        Organization(name: 'myOrganization'),
        token,
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

Future<Token> login() async {
  var monitor = _makeMonitor();
  var services = get<LoginServices>();
  Token token;

  services.login(
    Credentials(user: 'myUser', password: 'myPass'),
    onSuccess: (result) {
      token = result;
      monitor.signal();
    },
    onFailure: () => monitor.signal(),
  );
  await monitor.wait();

  return token;
}

Monitor _makeMonitor() {
  return Monitor(
    waitTime: const Duration(milliseconds: 10),
    tries: 1000,
  );
}
