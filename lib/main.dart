import 'package:cresce_flutter_app/pages/login_page_widget.dart';
import 'package:cresce_flutter_app/services_locator.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:ui_bits/ui_bits.dart';

void main() {
  runApp(makeApp());
}

Widget makeApp({
  Widget home,
  void Function(ServiceLocator) overrideDependencies,
}) {
  return wrapWithProvider(
    app: MyApp(
      home: home,
    ),
    override: overrideDependencies,
  );
}

class MyApp extends StatelessWidget {
  final Widget home;

  MyApp({this.home});

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    var themeFactory = ThemeFactory();
    return MaterialApp(
      title: 'Flutter Demo',
      theme: themeFactory.makeBlueTheme(),
      home: themeFactory.makeHome(
        child: home ?? LoginPageWidget(title: 'Flutter Demo Home Page'),
      ),
    );
  }
}
