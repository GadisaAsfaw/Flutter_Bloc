part of 'signup_bloc.dart';

class SignupState extends Equatable {
  const SignupState({
    this.name = const Name.pure(),
    this.email = const Email.pure(),
    this.password = const Password.pure(),
    this.confirmPassword = const ConfirmPassword.pure(),
    this.status = FormzStatus.pure,
  });

  final Name name;
  final Email email;
  final Password password;
  final ConfirmPassword confirmPassword;
  final FormzStatus status;

  SignupState copyWith({
    Name? name,
    Email? email,
    Password? password,
    ConfirmPassword? confirmPassword,
    FormzStatus? status,
  }) {
    return SignupState(
      name: name ?? this.name,
      email: email ?? this.email,
      password: password ?? this.password,
      confirmPassword: confirmPassword ?? this.confirmPassword,
      status: status ?? this.status,
    );
  }

  @override
  List<Object> get props => [name, email, password, confirmPassword, status];

  List<String> get getFormValue => [name.value, email.value, password.value];
}
