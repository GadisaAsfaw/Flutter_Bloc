import 'package:astegni/Authentication/authentication_bloc.dart';

import 'package:astegni/config/routes.dart';
import 'package:astegni/home/home_page.dart';
import 'package:astegni/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'login/view/view.dart';
import 'repo/userService.dart';
import 'signup/view/view.dart';
import 'Authentication/authentication_bloc.dart';

void main() {
  runApp(BlocProvider<AuthenticationBloc>(
      create: (context) => AuthenticationBloc()..add(AppStarted()),
      child: MyApp()));
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
      // initialRoute: '/',
      routes: _registerRoutes(),
      /*{
        '/': (context) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: LoginPage(),
            ),
        '/signup': (context) => RepositoryProvider(
              create: (context) => AuthRepository(),
              child: SignupPage(),
            ),
      }*/
    );
  }

  Map<String, WidgetBuilder> _registerRoutes() {
    return <String, WidgetBuilder>{
      AstegniRoutes.login: (context) => LoginPage(),
      AstegniRoutes.signup: (context) => _buildSignUpRepo(),
      AstegniRoutes.profile: (context) =>
          BlocBuilder<AuthenticationBloc, AuthenticationState>(
              builder: (context, state) {
            if (state is Authenticated) {
              return HomePage();
            } else if (state is Unauthenticated) {
              return _buildLoginInRepo(context);
            } else {
              context.read<AuthenticationBloc>().add(AppStarted());
              BlocProvider.value(
                  value: BlocProvider.of<AuthenticationBloc>(context),
                  child: LoginPage());
              return SplashScreen();
            }
          }),
    };
  }

  RepositoryProvider<AuthRepository> _buildLoginInRepo(BuildContext context) {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: BlocProvider.value(
        value: BlocProvider.of<AuthenticationBloc>(context),
        child: LoginPage(),
      ),
      // LoginPage(),
    );
  }

  RepositoryProvider<AuthRepository> _buildSignUpRepo() {
    return RepositoryProvider(
      create: (context) => AuthRepository(),
      child: SignupPage(),
    );
  }
}
