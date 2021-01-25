import 'package:cresce_flutter_app/features/organizations/organizations.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

main() {
  EquatableConfig.stringify = true;

  group(OrganizationServices, () {
    test('on successful login calls given callback function', () async {
      final service = makeService<OrganizationServices>();

      var organizations = await service.getOrganizations('myUser');

      expect(organizations, [Organization(name: 'myOrg')]);
    });

    test('fetching organizations for unknown user calls failure callback', () async{
      var service = makeService<OrganizationServices>();

      var organizations = await service.getOrganizations('unknownUser');

      expect(organizations, []);
    });
  });
}
