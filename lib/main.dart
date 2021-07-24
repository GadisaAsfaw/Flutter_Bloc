import 'package:astegni/brandColors.dart';
import 'package:astegni/home/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/view/view.dart';
import 'repo/userRepo.dart';
import 'signup/view/view.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      //theme: _kShrineTheme,
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      // home: HomePage(),
      initialRoute: '/',
      routes: {
        '/': (context) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: LoginPage(),
            ),
        '/signup': (context) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: SignupPage(),
            ),
        '/home': (context) => HomePage()
      },
    );
  }
}

final ThemeData _kShrineTheme = _buildShrineTheme();
ThemeData _buildShrineTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kShrinePink100,
      onPrimary: kShrineBrown900,
      secondary: kShrineBrown900,
      error: kShrineErrorRed,
    ),
    appBarTheme: base.appBarTheme.copyWith(
      backwardsCompatibility: false,
    ),
    // TODO: Add the text themes (103)
    // TODO: Add the icon themes (103)
    // TODO: Decorate the inputs (103)
  );
}
