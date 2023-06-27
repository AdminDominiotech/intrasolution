import 'package:dio/dio.dart';
import 'package:safe2biz/app/global/core/env/env.dart';
import 'dart:io';

import 'package:safe2biz/app/global/core/interceptors/dio_error_interceptor.dart';

class DioMicroServices {
  static final DioMicroServices _singleton = DioMicroServices._internal();
  late Dio msDio;
  late DioHeaders? _headers;

  DioHeaders get headers =>
      _headers ?? DioHeaders(company: '', userLogin: '', userPassword: '');

  factory DioMicroServices() {
    // final head = _singleton.headers;

    _singleton.msDio = Dio()
      ..options.connectTimeout = 9000000
      ..options.receiveTimeout = 70000
      ..options.baseUrl = Env.host
      ..options.followRedirects = false
      ..options.headers = {
        Headers.contentTypeHeader: Headers.jsonContentType,
        Headers.acceptHeader: Headers.jsonContentType,
        HttpHeaders.acceptEncodingHeader: 'gzip',
        'App-name': 'Safe2App',
        'App-version': 'v0.1',
        // 'userLogin': head!.userLogin,
        // 'userPassword': '', //_singleton.headers.userPassword,
        // 'systemRoot': 'safe2biz',
      }
      ..interceptors.add(LogInterceptor(requestBody: true, responseBody: true))
      ..interceptors.add(DioErrorInterceptor());
    // _singleton.msDio.options = BaseOptions(
    //   headers: {
    //     'userLogin': head.userLogin,
    //     'userPassword': '', //_singleton.headers.userPassword,
    //     'systemRoot': 'safe2biz',
    //   },
    // );
    return _singleton;
  }

  DioMicroServices._internal();
}

class DioHeaders {
  DioHeaders({
    required this.userLogin,
    required this.userPassword,
    required this.company,
  });
  String userLogin;
  String userPassword;
  String company;

  DioHeaders copyWith({
    String? userLogin,
    String? userPassword,
    String? company,
  }) =>
      DioHeaders(
        userLogin: userLogin ?? this.userLogin,
        userPassword: userPassword ?? this.userPassword,
        company: company ?? this.company,
      );
}
