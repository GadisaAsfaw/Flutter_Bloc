import 'dart:async';
import 'dart:convert';
import 'package:astegni/Authentication/authentication_bloc.dart';
//import 'package:astegni/repo/model/user.dart';
import 'package:astegni/repo/userService.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';

import 'package:astegni/models/models.dart';

part 'login_event.dart';
part 'login_state.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final AuthRepository authRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({required this.authRepository, required this.authenticationBloc})
      : super(const LoginState());

  @override
  void onTransition(Transition<LoginEvent, LoginState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate([state.email, password]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate([email, state.password]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate([state.email, password]),
      );
    } else if (event is FormSubmitted) {
      final email = Email.dirty(state.email.value);
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        email: email,
        password: password,
        status: Formz.validate([email, password]),
      );
      if (state.status.isValidated) {
        yield state.copyWith(status: FormzStatus.submissionInProgress);
        try {
          //await Future<void>.delayed(const Duration(seconds: 1));
          // User re = await authRepository.loginUser(state.email.value, state.password.value);
          final response = await authRepository.authenticateUser(
              state.email.value, state.password.value);
          var _response = jsonDecode(response.body);
          authenticationBloc.add(LoggedIn(_response['token']));
          //await authRepository.loginUser('gadisa@gmail.com', 'atr4136');
          print('_______________________');
          print(_response['user'].toString());
          print('_______________________');
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } catch (e) {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }
    }
  }
}
