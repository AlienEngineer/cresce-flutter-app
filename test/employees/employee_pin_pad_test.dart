import 'package:cresce_flutter_app/features/features.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';

import '../tester_extensions.dart';

main() {
  EquatableConfig.stringify = true;

  group(EmployeePinPadWidget, () {
    testWidgets('entering 4 digit pin logs in', (tester) async {
      var _wasLoggedIn = false;
      await tester.pumpWidgetInApp(
        EmployeePinPadWidget(
          employee: Field.as<Employee>()..setValue(Employee(id: 1)),
          onSuccess: () => _wasLoggedIn = true,
        ),
      );

      await enterValidPin(tester);

      expect(_wasLoggedIn, isTrue);
      expect(find.text('wrong pin, make sure this is your account.'),
          findsNothing);
    });
    testWidgets('wrong pin prompts a new pin', (tester) async {
      var _wasLoggedIn = false;
      await tester.pumpWidgetInApp(
        EmployeePinPadWidget(
          employee: Field.as<Employee>()..setValue(Employee(id: 1)),
          onSuccess: () => _wasLoggedIn = true,
        ),
      );

      await enterInvalidPin(tester);

      expect(_wasLoggedIn, isFalse);
      expect(find.text('wrong pin, make sure this is your account.'),
          findsOneWidget);
    });
  });
}

Future enterInvalidPin(WidgetTester tester) async {
  await tester.tap(find.text('1'));
  await tester.tap(find.text('2'));
  await tester.tap(find.text('3'));
  await tester.tap(find.text('5'));
  await tester.pumpAndSettle();
}

Future enterValidPin(WidgetTester tester) async {
  await tester.tap(find.text('1'));
  await tester.tap(find.text('2'));
  await tester.tap(find.text('3'));
  await tester.tap(find.text('4'));
  await tester.pumpAndSettle();
}
