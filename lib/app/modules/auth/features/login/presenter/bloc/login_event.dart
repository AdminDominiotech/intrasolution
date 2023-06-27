part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();

  @override
  List<Object> get props => [];
}

class InitEv extends LoginEvent {}

class LoginEv extends LoginEvent {
  const LoginEv({
    required this.user,
    required this.password,
  });
  final String user;
  final String password;

  @override
  List<Object> get props => [
        user,
        password,
      ];
}
