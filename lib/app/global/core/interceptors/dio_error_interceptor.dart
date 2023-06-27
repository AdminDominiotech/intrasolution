import 'package:dio/dio.dart';
import 'package:safe2biz/app/global/core/errors/dio_error.helper.dart';

class DioErrorInterceptor extends Interceptor {
  DioErrorInterceptor();

  @override
  void onError(DioError err, ErrorInterceptorHandler handler) async {
    final error = DioErrorCustom(
      requestOptions: err.requestOptions,
      response: err.response,
      type: err.type,
      error: err.error,
    );
    error.error = DioErrorHandler.dioErrorToString(error);
    return super.onError(error, handler);
  }
}
