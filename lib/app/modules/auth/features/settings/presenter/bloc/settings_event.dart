part of 'settings_bloc.dart';

abstract class SettingsEvent extends Equatable {
  const SettingsEvent();

  @override
  List<Object> get props => [];
}

class InitEv extends SettingsEvent {}

class SaveSettingEv extends SettingsEvent {
  const SaveSettingEv({required this.setting});
  final Setting setting;
  @override
  List<Object> get props => [];
}
