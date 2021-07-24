import 'package:astegni/repo/userRepo.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astegni/login/login.dart';

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Login'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (item) => handleClick(context, item),
              icon: Icon(Icons.more_horiz),
              itemBuilder: (BuildContext context) {
                return {'Sign Up', 'Settings'}.map((String choice) {
                  return PopupMenuItem<String>(
                    value: choice,
                    child: Text(choice),
                  );
                }).toList();
              },
            ),
          ],
        ),
        body: BlocProvider(
          create: (context) =>
              LoginBloc(authRepository: context.read<AuthRepository>()),
          child: LoginForm(),
        ),
      ),
    );
  }

  void handleClick(BuildContext context, String value) {
    switch (value) {
      case 'Sign Up':
        Navigator.pushNamed(context, '/signup');

        break;
      case 'Settings':
        break;
    }
  }
}
