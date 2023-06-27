// part of 'auth_bloc.dart';

// abstract class AuthState extends Equatable {
//   const AuthState([this._val]);

//   final Object? _val;

//   @override
//   List<Object?> get props => [_val];
// }

// class AuthIdle extends AuthState {
//   const AuthIdle();
// }

// class AuthUnregistered extends AuthState {
//   const AuthUnregistered();
// }

// class AuthData extends AuthState {
//   const AuthData(User user) : super(user);

//   User get user => _val! as User;
// }

// class AuthError extends AuthState {
//   const AuthError(String error) : super(error);

//   String get error => _val! as String;
// }
