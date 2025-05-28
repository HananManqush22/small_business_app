import 'package:dio/dio.dart';
import 'package:small_business_app/core/errors/error_model.dart';

class ServerException implements Exception {
  final ErrorModel error;

  ServerException({required this.error});
}

void handelDioException(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));

    case DioExceptionType.sendTimeout:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));
    case DioExceptionType.receiveTimeout:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));
    case DioExceptionType.badCertificate:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));
    case DioExceptionType.badResponse:
      switch (e.response?.statusCode) {
        case 400: //bad request
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
        case 401: //unauthorized
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
        case 403: //forbidden
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
        case 404: //not found
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
        case 409: //cofficient
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
        case 422: //Unprocessable Entity
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
        case 504: //server exception
          throw ServerException(error: ErrorModel.formJson(e.response!.data));
      }
    case DioExceptionType.cancel:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));
    case DioExceptionType.connectionError:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));
    case DioExceptionType.unknown:
      throw ServerException(error: ErrorModel.formJson(e.response!.data));
  }
}
