import 'package:equatable/equatable.dart';

abstract class Setting extends Equatable {
  const Setting({required this.ip, required this.nameCompany});
  final String ip;
  final String nameCompany;

  @override
  List<Object?> get props => [
        ip,
        nameCompany,
      ];
}
