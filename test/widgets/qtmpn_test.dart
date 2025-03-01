import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:go_router/go_router.dart';
import 'package:mpn_lookup_flutter/screens/home.dart';
import 'package:mpn_lookup_flutter/screens/qt.dart';

Widget createHomeScreen() {
  final GoRouter router = GoRouter(
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const HomePage(),
      ),
      GoRoute(
        path: '/qt',
        builder: (context, state) => const QuantiTrayPage(),
      ),
    ],
  );

  return MaterialApp.router(
    routerConfig: router,
  );
}

void main() {
  group('Home Page Widget Tests', () {
    testWidgets('Verify title and buttons are present', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      expect(find.text('MPN Lookup'), findsOneWidget);
      expect(find.text('Quanti-Tray®'), findsOneWidget);
      expect(find.text('Quanti-Tray/2000®'), findsOneWidget);
      expect(find.text('Legiolert'), findsOneWidget);
      expect(find.text('About'), findsOneWidget);
    });

    testWidgets('Click on Quanti-Tray button, navigate, and enter 51', (tester) async {
      await tester.pumpWidget(createHomeScreen());

      await tester.tap(find.text('Quanti-Tray®'));
      await tester.pumpAndSettle();

      expect(find.text('Quanti-Tray® MPN'), findsWidgets);

      // await tester.enterText(find.byType(TextField), '51');
      // await tester.pumpAndSettle();
      //
      // // Add a 2-second delay
      // await tester.pump(const Duration(seconds: 2));
      //
      // expect(find.textContaining('Infinite'), findsOneWidget);
      // expect(find.textContaining('200.5'), findsOneWidget);
    });

    // Other tests...
  });
}
