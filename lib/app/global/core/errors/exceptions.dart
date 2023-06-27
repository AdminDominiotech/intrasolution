class ServerException implements Exception {
  final String? message;
  final int? statusCode;
  ServerException({this.message, this.statusCode});
}

class LocalException implements Exception {
  final String? message;
  LocalException({this.message});
}
