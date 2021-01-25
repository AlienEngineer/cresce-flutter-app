import 'package:cresce_flutter_app/core/core.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:cresce_flutter_app/pages/login_page_widget.dart';
import 'package:cresce_flutter_app/service_configuration.dart';
import 'package:ui_bits/ui_bits.dart';


void main() {
  runApp(makeApp());
}

Widget makeApp({
  Widget home,
  void Function(ServiceLocator) overrideDependencies,
}) {
  return MyApp(
    home: home,
    overrideDependencies: overrideDependencies,
  );
}

class MyApp extends StatelessWidget {
  final Widget home;
  final void Function(ServiceLocator) overrideDependencies;

  const MyApp({
    this.home,
    this.overrideDependencies,
  });

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.landscapeRight,
      DeviceOrientation.landscapeLeft,
    ]);

    var themeFactory = ThemeFactory();
    return wrapWithProvider(
      override: overrideDependencies,
      app: Builder(
        builder: (context) {
          return MaterialApp(
            localizationsDelegates: [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            debugShowCheckedModeBanner: false,
            theme: themeFactory.makeBlueTheme(),
            home: themeFactory.makeHome(
              child: home ?? context.get<LoginPageWidget>(),
            ),
          );
        },
      ),
    );
  }
}
