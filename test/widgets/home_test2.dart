import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mpn_lookup_flutter/screens/home.dart';

Widget createHomeScreen() => MaterialApp(
      home: const HomePage(),
    );

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Verify title and buttons are present', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.text('MPN Lookup'), findsOneWidget);
      expect(find.text('Quanti-TrayT'), findsOneWidget);
      expect(find.text('Quanti-Tray/2000'), findsOneWidget);
      expect(find.text('Legiolert'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('Click on QT button and navigate', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.text('Quanti-Tray'));
      await tester.pumpAndSettle();

      expect(find.text('Quanti-Tray® MPN'), findsOneWidget);
    });

    testWidgets('Click on QT2000 button and navigate', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.text('Quanti-Tray/2000'));
      await tester.pumpAndSettle();

      expect(find.text('Quanti-Tray/2000® MPN'), findsOneWidget);
    });

    testWidgets('Click on Legiolert button and navigate', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.text('Legiolert'));
      await tester.pumpAndSettle();

      expect(find.text('Legiolert® MPN'), findsOneWidget);
    });

    testWidgets('Click on About button and navigate', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.text('About'));
      await tester.pumpAndSettle();

      expect(find.text('Why is this a Thing?'), findsOneWidget);
    });
  });
}
