import 'package:cresce_flutter_app/features/features.dart';
import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

main() {
  EquatableConfig.stringify = true;

  group(EmployeeServices, () {
    test(
        'fetching employees for the given organization returns list of employees',
        () async {
      var service = makeService<EmployeeServices>();

      var employees = await service.getEmployees(
        Organization(name: 'myOrganization'),
      );

      expect(employees, [
        Employee(
          name: 'test employee',
          title: 'test title',
        )
      ]);
    });
    test('fetching employees for unknown organization calls failure callback',
        () async {
      var service = makeService<EmployeeServices>();

      var employees = await service.getEmployees(
        Organization(name: 'unknown'),
      );

      expect(employees, []);
    });
  });
}
