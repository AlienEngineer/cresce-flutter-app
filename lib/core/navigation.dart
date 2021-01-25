import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:cresce_flutter_app/service_configuration.dart';

class NavigationManager {
  void navigateToPage<TPage extends Widget>(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (_) => context.get<TPage>()),
    );
  }
}
