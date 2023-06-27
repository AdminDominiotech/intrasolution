part of 'splash_bloc.dart';

abstract class SplashState extends Equatable {
  const SplashState();

  @override
  List<Object> get props => [];
}

class Init extends SplashState {}

class Loading extends SplashState {}

class Successful extends SplashState {
  const Successful({required this.user});
  final User user;

  @override
  List<Object> get props => [user];
}

class FailureHasSession extends SplashState {
  const FailureHasSession({
    required this.error,
    required this.lastState,
  });
  final String error;
  final SplashState lastState;
  @override
  List<Object> get props => [
        error,
        lastState,
      ];
}

class FailureNotHaveSetting extends SplashState {
  const FailureNotHaveSetting({
    required this.error,
    required this.lastState,
  });
  final String error;
  final SplashState lastState;
  @override
  List<Object> get props => [
        error,
        lastState,
      ];
}
