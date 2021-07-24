part of 'signup_bloc.dart';

abstract class SignupEvent extends Equatable {
  const SignupEvent();

  @override
  List<Object> get props => [];
}

class NameUnfocused extends SignupEvent {}

class EmailUnfocused extends SignupEvent {}

class PasswordUnfocused extends SignupEvent {}

class ConfirmPasswordUnfocused extends SignupEvent {}

class SignupFormSubmitted extends SignupEvent {}

class NameChanged extends SignupEvent {
  const NameChanged({required this.name});

  final String name;

  @override
  List<Object> get props => [name];
}

class EmailChanged extends SignupEvent {
  const EmailChanged({required this.email});
  final String email;
  @override
  List<Object> get props => [email];
}

class PasswordChanged extends SignupEvent {
  const PasswordChanged({required this.password});
  final String password;
  @override
  List<Object> get props => [password];
}

class ConfirmPasswordChanged extends SignupEvent {
  const ConfirmPasswordChanged({
    required this.confirmPassword,
  });
  final String confirmPassword;
  @override
  List<Object> get props => [confirmPassword];
}
