import 'package:cresce_flutter_app/features/features.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:ui_bits/ui_bits.dart';
import '../tester_extensions.dart';

void main() {
  group(EmployeeCarouselWidget, () {
    testWidgets('pump page builds page', (tester) async {
      await _pumpWidget(tester);

      expect(find.byType(EmployeeCarouselWidget), findsOneWidget);
    });
    testWidgets('on page build fetch employees', (tester) async {
      await _pumpWidget(tester);
      await tester.pumpAndSettle();

      expect(find.byType(BitCarousel), findsOneWidget);
      expect(find.byType(BitThumbnail), findsOneWidget);
    });
  });
}

Future _pumpWidget(WidgetTester tester) {
  return tester.pumpWidgetInApp(
    EmployeeCarouselWidget(),
  );
}
