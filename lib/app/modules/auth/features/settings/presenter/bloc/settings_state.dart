part of 'settings_bloc.dart';

abstract class SettingsState extends Equatable {
  const SettingsState();

  @override
  List<Object?> get props => [];
}

class Init extends SettingsState {}

class Loading extends SettingsState {}

class Loaded extends SettingsState {
  const Loaded(this.setting);
  final SettingModel? setting;

  @override
  List<Object?> get props => [setting];
}

class SavingSetting extends SettingsState {}

class SavedSetting extends SettingsState {}

class FailureSaveSetting extends SettingsState {
  const FailureSaveSetting({
    required this.error,
    required this.lastState,
  });
  final String error;
  final SettingsState lastState;
  @override
  List<Object> get props => [
        error,
        lastState,
      ];
}
