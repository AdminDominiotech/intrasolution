import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safe2biz/app/global/controllers/auth_controller.dart';
import 'package:safe2biz/app/modules/auth/features/login/data/data.dart';
import 'package:safe2biz/app/modules/auth/features/login/domain/domain.dart';
import 'package:safe2biz/app/global/core/errors/errors.dart';

part 'login_event.dart';
part 'login_state.dart';

typedef LoginEmitter = Emitter<LoginState>;

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  LoginBloc({
    required LoginCheckUcImpl loginCheckUc,
    // required LocalLoginUcImpl localLoginUc,
    required AuthController authController,
    // required GetAccesosLocalUcImpl getAccesosLocalUc,
    // required SaveAccesosLocalUcImpl saveAccesosLocalUc,
  })  : _loginCheckUc = loginCheckUc,
        // _getAccesosLocalUc = getAccesosLocalUc,
        // _saveAccesosLocalUc = saveAccesosLocalUc,
        // _localLoginUc = localLoginUc,
        _auth = authController,
        super(LoginInit()) {
    on<InitEv>(_onInitEv);
    on<LoginEv>(_onLoginEv);
  }

  final LoginCheckUcImpl _loginCheckUc;
  // final GetAccesosLocalUcImpl _getAccesosLocalUc;
  // final SaveAccesosLocalUcImpl _saveAccesosLocalUc;
  final AuthController _auth;
  // final LocalLoginUcImpl _localLoginUc;

  Future<void> _onInitEv(
    InitEv ev,
    LoginEmitter emit,
  ) async {
    emit(Loaded());
  }

  Future<void> _onLoginEv(
    LoginEv ev,
    LoginEmitter emit,
  ) async {
    emit(Loading());

    final failureOrUser = await _loginCheckUc(
      ev.user,
    );

    final result = failureOrUser.fold((failure) => failure, (user) => user);

    if (result is Failure) {
      emit(
        FailureLogin(
          error: result.message,
          lastState: state,
        ),
      );
      return;
    }

    UserModel user = UserModel.castEntity(result as User);

    // List<Acceso> access = [
    //   AccesoModel(
    //       codigo: 'COOPER',
    //       fbUeaPeId: '3',
    //       modulos:
    //           'INC,AYC,PLAN_ACCION,REPORT_INC,REPORT_PLAN_ACCION,GRAF_RENDIMIENTO,GRAF_INC'),
    //   AccesoModel(
    //       codigo: 'SILVER',
    //       fbUeaPeId: '2',
    //       modulos:
    //           'INC,AYC,PLAN_ACCION,REPORT_INC,REPORT_PLAN_ACCION,GRAF_RENDIMIENTO,GRAF_INC'),
    // ];

    // print('Paso okis ${user.accesos.length}');
    // final failureOrAccesos = await _saveAccesosLocalUc(user.accesos);

    // failureOrAccesos.fold((failure) => failure, (ok) => ok);
    // final list = await _getAccesosLocalUc();
    // list.fold(
    //     (failure) => print('😊 $failure'), (ok) => print('😊okismodulos: $ok'));

    user = user.copyWith(password: ev.password);
    print('${user.uuid} ${user.name} ${user.password}');

    await _auth.login(user);

    emit(Successful(user: user));
  }
}
