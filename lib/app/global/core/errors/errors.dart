import 'package:equatable/equatable.dart';
import 'package:safe2biz/app/ui/module_ui.dart';

abstract class Failure extends Equatable {
  final String message;
  final int? statusCode;

  const Failure({
    required this.message,
    this.statusCode = 0,
  });

  @override
  List<Object?> get props => [message];
}

class ServerFailure extends Failure {
  const ServerFailure({
    required String message,
    int? statusCode,
  }) : super(message: message, statusCode: statusCode);
}

class LocalFailure extends Failure {
  const LocalFailure({
    required String message,
  }) : super(message: message);
}

class AppException extends Failure {
  const AppException({
    String message = UiValues.appError,
  }) : super(message: message);
}
