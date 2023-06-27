// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:safe2biz/app/modules/auth/features/login/data/models/models.dart';
// import 'package:safe2biz/app/modules/auth/features/login/domain/entities/entities.dart';

// part 'auth_event.dart';
// part 'auth_state.dart';

// typedef AuthEmitter = Emitter<AuthState>;

// class AuthBloc extends Bloc<AuthEvent, AuthState> {
//   AuthBloc() : super(const AuthIdle()) {
//     print('Holissssss');
//     on<AuthLoad>(_onAuthLoad);
//     on<AuthSet>(_onAuthSet);
//     on<AuthSignOut>(_onAuthSignOut);
//   }

//   Future<void> _onAuthLoad(AuthLoad ev, AuthEmitter emit) async {
//     // final session = await _database.getSession();
//     // await Future.delayed(const Duration(seconds: 2), () {});
//     // if (session != null) {
//     //   // add(AuthSet(session));
//     //   add(AuthSet(UserSession(userId: '123', userToken: '112ksks')));
//     // } else {
//     emit(const AuthUnregistered());
//     // }
//   }

//   Future<void> _onAuthSet(AuthSet ev, AuthEmitter emit) async {
//     // await _database.deleteSession();
//     // final userIdEv = ev.newSession.userId;
//     // final userData = await _services.user.fetchUser(ev.newSession.userToken);
//     // final userId = userIdEv.isEmpty ? userData.id : userIdEv;
//     // final session = UserSession(
//     //   userId: userId,
//     //   userToken: ev.newSession.userToken,
//     // );
//     // await _database.saveSession(session);
//     // final newUser = User(
//     //   firstName: userData.firstName,
//     //   lastName: userData.lastName,
//     //   email: userData.email,
//     //   phone: userData.email,
//     //   session: session,
//     // );
//     // emit(AuthData(newUser));
//   }

//   Future<void> _onAuthSignOut(AuthSignOut ev, AuthEmitter emit) async {
//     // await _database.deleteSession();
//     emit(const AuthUnregistered());
//   }
// }
