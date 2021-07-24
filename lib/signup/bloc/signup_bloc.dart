import 'dart:async';
import 'package:astegni/repo/model/user.dart';
import 'package:astegni/repo/userRepo.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:astegni/models/models.dart';
part 'signup_event.dart';
part 'signup_state.dart';

class SignupBloc extends Bloc<SignupEvent, SignupState> {
  final AuthRepository authRepository;

  SignupBloc({required this.authRepository}) : super(const SignupState());

  @override
  void onTransition(Transition<SignupEvent, SignupState> transition) {
    print(transition);
    super.onTransition(transition);
  }

  @override
  Stream<SignupState> mapEventToState(SignupEvent event) async* {
    if (event is NameChanged) {
      final name = Name.dirty(event.name);
      yield state.copyWith(
        name: name.valid ? name : Name.pure(event.name),
        status: Formz.validate(
            [name, state.email, state.password, state.confirmPassword]),
      );
    } else if (event is EmailChanged) {
      final email = Email.dirty(event.email);
      yield state.copyWith(
        email: email.valid ? email : Email.pure(event.email),
        status: Formz.validate(
            [state.name, email, state.password, state.confirmPassword]),
      );
    } else if (event is PasswordChanged) {
      final password = Password.dirty(event.password);
      yield state.copyWith(
        password: password.valid ? password : Password.pure(event.password),
        status: Formz.validate(
            [state.name, state.email, password, state.confirmPassword]),
      );
    } else if (event is ConfirmPasswordChanged) {
      final confirmPassword = ConfirmPassword.dirty(
          password: state.password.value, value: event.confirmPassword);
      yield state.copyWith(
        confirmPassword:
            confirmPassword.valid ? confirmPassword : ConfirmPassword.pure(),
        status: Formz.validate([
          state.name,
          state.email,
          state.password,
          confirmPassword,
        ]),
      );
    } else if (event is NameUnfocused) {
      final name = Name.dirty(state.name.value);
      yield state.copyWith(
        name: name,
        status: Formz.validate(
            [name, state.email, state.password, state.confirmPassword]),
      );
    } else if (event is EmailUnfocused) {
      final email = Email.dirty(state.email.value);
      yield state.copyWith(
        email: email,
        status: Formz.validate(
            [state.name, email, state.password, state.confirmPassword]),
      );
    } else if (event is PasswordUnfocused) {
      final password = Password.dirty(state.password.value);
      yield state.copyWith(
        password: password,
        status: Formz.validate(
            [state.name, state.email, password, state.confirmPassword]),
      );
    } else if (event is ConfirmPasswordUnfocused) {
      final confirmPassword = ConfirmPassword.dirty(
          password: state.password.value, value: state.confirmPassword.value);
      yield state.copyWith(
        confirmPassword: confirmPassword,
        status: Formz.validate(
            [state.name, state.email, state.password, confirmPassword]),
      );
    } else if (event is SignupFormSubmitted) {
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

          User re = await authRepository.registerUser(state.getFormValue);
          //await authRepository.loginUser('gadisa@gmail.com', 'atr4136');
          print('_______________________');
          print(re.name);
          print('_______________________');
          yield state.copyWith(status: FormzStatus.submissionSuccess);
        } catch (e) {
          yield state.copyWith(status: FormzStatus.submissionFailure);
        }
      }
    }
  }
}
