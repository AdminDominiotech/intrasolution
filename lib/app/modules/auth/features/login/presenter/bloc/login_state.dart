part of 'login_bloc.dart';

abstract class LoginState extends Equatable {
  const LoginState();

  @override
  List<Object> get props => [];
}

class LoginInit extends LoginState {}

class Loading extends LoginState {}

class Loaded extends LoginState {}

class Successful extends LoginState {
  const Successful({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class FailureLogin extends LoginState {
  const FailureLogin({
    required this.error,
    required this.lastState,
  });
  final String error;
  final LoginState lastState;
  @override
  List<Object> get props => [
        error,
        lastState,
      ];
}

class FailureLocalLogin extends LoginState {
  const FailureLocalLogin({
    required this.error,
    required this.lastState,
  });
  final String error;
  final LoginState lastState;
  @override
  List<Object> get props => [
        error,
        lastState,
      ];
}
