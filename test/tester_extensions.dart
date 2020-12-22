import 'package:cresce_flutter_app/main.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';

import 'fake_http_layer.dart';

extension TesterExtensions on WidgetTester {
  Future waitForAnimationsToSettle() =>
      this.pumpAndSettle(const Duration(minutes: 1));

  Future pumpApp() async {
    await this.pumpWidget(makeApp(
      overrideDependencies: (locator) {
        useFakeHttpLayer(locator);
      },
    ));
    await this.waitForAnimationsToSettle();
  }

  Future pumpWidgetInApp(Widget widget) async {
    await this.pumpWidget(
      makeApp(
        overrideDependencies: (locator) {
          useFakeHttpLayer(locator);
        },
        home: Scaffold(body: widget),
      ),
    );

    await this.waitForAnimationsToSettle();
  }
}
