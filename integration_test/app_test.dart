import 'package:flutter_test/flutter_test.dart';
import 'package:mpn_lookup_flutter/main.dart';

void main() {
  group('Testing App', () {
    testWidgets('Favorites operations test', (tester) async {
      await tester.pumpWidget(const MPNLApp());

      expect(find.text('MPN Lookup'), findsOneWidget);
    });
  });
}
