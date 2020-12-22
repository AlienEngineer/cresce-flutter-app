import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';

import '../fake_http_layer.dart';

void main() {
  EquatableConfig.stringify = true;
  group(LoginServices, () {
    test('on successful login calls given callback function', () async {
      final loginServices = makeService<LoginServices>();
      Token token;

      loginServices.login(
        Credentials(user: 'myUser', password: 'myPass'),
        onSuccess: (result) => token = result,
      );

      expect(token, Token(token: 'myAuthToken'));
    });

    test('on failure login calls given callback function', () async {
      final loginServices = makeService<LoginServices>();
      bool failed = false;

      loginServices.login(
        Credentials(user: 'myUser1', password: 'myPass'),
        onFailure: () => failed = true,
      );

      expect(failed, isTrue);
    });
  });
}
