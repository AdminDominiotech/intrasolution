import 'package:dio/dio.dart';

class DioErrorCustom extends DioError {
  DioErrorCustom({
    required RequestOptions requestOptions,
    Response? response,
    DioErrorType type = DioErrorType.other,
    dynamic error,
  }) : super(
          requestOptions: requestOptions,
          response: response,
          type: type,
          error: error,
        );

  @override
  String toString() {
    var msg = message;
    if (error is Error) {
      msg += '\n${error.stackTrace}';
    }
    return msg;
  }
}

String? format422Errors(DioError error) {
  var formatedErrors = <String>[];

  if (error.response != null &&
      error.response!.data is Map &&
      error.response!.data.isNotEmpty) {
    if (error.response!.data.containsKey('errors')) {
      error.response!.data['errors'].forEach((key, value) {
        formatedErrors.add('- ${value[0]}');
      });
    }

    if (error.response != null && error.response!.data.containsKey('message')) {
      formatedErrors.add('- ${error.response!.data['message']}');
    }
  }

  if (formatedErrors.isEmpty) {
    return null;
  }

  return formatedErrors.join('\n');
}

class DioErrorHandler {
  static String dioErrorToString(DioError dioError) {
    String errorText;
    switch (dioError.type) {
      case DioErrorType.connectTimeout:
        errorText =
            'El tiempo de conexión expiro. Compruebe su conexión a Internet o póngase en contacto con el administrador del servidor';
        break;
      case DioErrorType.receiveTimeout:
      case DioErrorType.sendTimeout:
        errorText =
            'Se perdió la conexión, verifique su conexión a Internet y vuelva a intentarlo.';
        break;
      case DioErrorType.response:
        errorText = _errorBaseOnHttpStatusCode(dioError);
        break;
      case DioErrorType.cancel:
        errorText =
            'Se perdió la conexión, verifique su conexión a Internet y vuelva a intentarlo.';
        break;
      case DioErrorType.other:
        errorText =
            'Se perdió la conexión, verifique su conexión a Internet y vuelva a intentarlo.';
        break;
    }
    return errorText;
  }

  static String _errorBaseOnHttpStatusCode(DioError dioError) {
    String errorText = '';
    if (dioError.response != null) {
      if (dioError.response!.statusCode == 401) {
        errorText =
            'Algo salió mal, cierre la aplicación y vuelva a iniciar sesión.';
      } else if (dioError.response!.statusCode == 404) {
        errorText =
            'Se perdió la conexión o el recurso no existe, verifique su conexión a Internet y vuelva a intentarlo.';
      } else if (dioError.response!.statusCode == 410) {
        final errors = dioError.response!.data['errors'];
        if (errors != null) {
          final error = List.from(errors).map((item) => item).toList().first;
          errorText = error;
        } else {
          errorText =
              'Error Desconocido - ${dioError.response?.statusCode ?? ''}.';
        }
      } else if (dioError.response!.statusCode == 500) {
        errorText = 'Contacte al administrador';
      } else if (dioError.response!.statusCode == 422) {
        errorText = format422Errors(dioError) ?? '';
      } else {
        errorText =
            'Error Desconocido - ${dioError.response?.statusCode ?? ''}.';
      }
    }

    return errorText;
  }
}
