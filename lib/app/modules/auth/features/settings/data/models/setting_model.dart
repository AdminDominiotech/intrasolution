import 'package:safe2biz/app/modules/auth/features/settings/domain/entities/entities.dart';

class SettingModel extends Setting {
  SettingModel({
    required String ip,
    required String nameCompany,
  }) : super(
          ip: ip,
          nameCompany: nameCompany,
        );

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        ip: json['ip'] ?? '',
        nameCompany: json['name_company'] ?? '',
      );

  Map<String, dynamic> toJson() => {
        'ip': ip,
        'name_company': nameCompany,
      };

  SettingModel copyWith({
    String? ip,
    String? nameCompany,
  }) =>
      SettingModel(
        ip: ip ?? this.ip,
        nameCompany: nameCompany ?? this.nameCompany,
      );
}
