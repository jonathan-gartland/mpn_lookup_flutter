import 'package:flutter_test/flutter_test.dart';
import 'package:mpn_lookup_flutter/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const MyApp());

      expect(find.text('You have pushed the button this many times:'),
          findsOneWidget);
    });
  });
}
