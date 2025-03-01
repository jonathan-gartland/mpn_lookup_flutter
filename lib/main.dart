import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'screens/qt.dart';
import 'screens/qt2k.dart';
import 'screens/home.dart';
import 'screens/about.dart';
import 'screens/legiolert.dart';

void main() {
  runApp(const MPNLApp());
}

final _router = GoRouter(
  routes: [
    GoRoute(
      path: HomePage.routeName,
      builder: (context, state) {
        return const HomePage();
      },
      routes: [
        GoRoute(
          path: QuantiTrayPage.routeName,
          builder: (context, state) {
            return const QuantiTrayPage();
          },
        ),
        GoRoute(
          path: QuantiTray2000Page.routeName,
          builder: (context, state) {
            return const QuantiTray2000Page();
          },
        ),
        GoRoute(
            path: LegiolertPage.routeName,
            builder: (context, state) {
              return const LegiolertPage();
            }),
        GoRoute(
            path: AboutPage.routeName,
            builder: (context, state) {
              return const AboutPage();
            }),
      ],
    ),
  ],
);

class MPNLApp extends StatelessWidget {
  const MPNLApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Testing Sample',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      routerConfig: _router,
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:trash_themes/themes.dart';
// import './graphql_bloc/main.dart' show GraphQLBlocPatternScreen;
// import './graphql_widget/main.dart' show GraphQLWidgetScreen;
// import 'fetchmore/main.dart';
//
// void main() => runApp(MyApp());
//
// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'GraphQL Flutter Demo',
//       theme: DraculaTheme().makeDarkTheme(context: context),
//       home: Builder(
//         builder: (BuildContext context) => Scaffold(
//           appBar: AppBar(
//             title: const Text('GraphQL Demo App'),
//           ),
//           body: Center(
//             child: Column(
//               children: <Widget>[
//                 Spacer(),
//                 Flexible(
//                     child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute<GraphQLWidgetScreen>(
//                         builder: (BuildContext context) =>
//                             GraphQLBlocPatternScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text('GraphQL BloC pattern'),
//                 )),
//                 Spacer(),
//                 Flexible(
//                     child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute<GraphQLWidgetScreen>(
//                         builder: (BuildContext context) =>
//                             const GraphQLWidgetScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text('GraphQL Widget'),
//                 )),
//                 Spacer(),
//                 Flexible(
//                     child: ElevatedButton(
//                   onPressed: () {
//                     Navigator.push(
//                       context,
//                       MaterialPageRoute<FetchMoreWidgetScreen>(
//                         builder: (BuildContext context) =>
//                             const FetchMoreWidgetScreen(),
//                       ),
//                     );
//                   },
//                   child: const Text('Fetchmore (Pagination) Example'),
//                 )),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
