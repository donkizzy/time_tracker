import 'package:dio/dio.dart';

class ApiError {
  late String errorDescription;
  ApiError? apiErrorModel;

  ApiError({required this.errorDescription});

  ApiError.fromDio(Object dioError) {
    _handleError(dioError);
  }

  void _handleError(Object error) {
    if (error is DioException) {
      var dioError = error;
      switch (dioError.type) {
        case DioExceptionType.cancel:
          errorDescription = "Request was cancelled";
          break;
        case DioExceptionType.connectionTimeout:
          errorDescription = "Connection timeout";
          break;
        case DioExceptionType.badResponse:
          errorDescription = "Connection failed due to internet connection";
          break;
        case DioExceptionType.receiveTimeout:
          errorDescription = "Connection timeout";
          break;
        case DioExceptionType.unknown:
          if (dioError.response!.statusCode == 401) {
            errorDescription = 'Session timeout';
          }
          break;
        case DioExceptionType.sendTimeout:
          errorDescription = "Send timeout in connection";
          break;
        case DioExceptionType.badCertificate:
          errorDescription = "Bad Certificate";
          break;

        case DioExceptionType.connectionError:
          errorDescription = "Unable to connect";
          break;
      }
    } else {
      errorDescription = "An unexpected error occurred";
    }
  }

  @override
  String toString() => errorDescription;
}
