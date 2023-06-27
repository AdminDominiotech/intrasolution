import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:safe2biz/app/global/controllers/settings_controller.dart';
import 'package:safe2biz/app/modules/auth/features/settings/data/models/models.dart';
import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';

part 'settings_event.dart';
part 'settings_state.dart';

typedef SettingsEmitter = Emitter<SettingsState>;

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc({required SettingsController settingsController})
      : _settingsController = settingsController,
        super(Init()) {
    on<InitEv>(_onInitEv);
    on<SaveSettingEv>(_onSaveSettingEv);
  }

  final SettingsController _settingsController;

  Future<void> _onInitEv(InitEv ev, SettingsEmitter emit) async {
    emit(Loading());
    final setting = await _settingsController.getSettingFromStorage();
    emit(Loaded(setting));
  }

  Future<void> _onSaveSettingEv(SaveSettingEv ev, SettingsEmitter emit) async {
    emit(SavingSetting());
    await Future.delayed(const Duration(milliseconds: 500));
    final result = await _settingsController.save(ev.setting);
    if (result) {
      emit(SavedSetting());
    } else {
      emit(FailureSaveSetting(
          error: 'No se pudo guardar la configuración', lastState: state));
    }
    // print(
    //     '${_settingsController.setting.value.ip}   ${_settingsController.setting.value.nameCompany}');
  }
}
