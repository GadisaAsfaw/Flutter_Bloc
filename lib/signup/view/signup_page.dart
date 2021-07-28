import 'package:astegni/repo/userService.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:astegni/signup/signup.dart';

class SignupPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Sign Up'),
          actions: [
            PopupMenuButton<String>(
              onSelected: (item) => handleClick(context, item),
              icon: Icon(Icons.more_horiz),
              itemBuilder: (BuildContext context) {
                return {'Login', 'Settings'}.map((String choice) {
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
              SignupBloc(authRepository: context.read<AuthRepository>()),
          child: SignupForm(),
        ),
        resizeToAvoidBottomInset: false,
      ),
    );
  }

  void handleClick(BuildContext context, String value) {
    switch (value) {
      case 'Login':
        Navigator.of(context).pop();
        //Navigator.pop(context);

        break;
      case 'Settings':
        break;
    }
  }
}
