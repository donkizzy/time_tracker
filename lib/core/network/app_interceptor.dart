
import 'package:dio/dio.dart';

class AppInterceptor extends Interceptor {
  AppInterceptor();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async{

      options.headers.addAll({"Content-Type":  'application/json',});

    return super.onRequest(options, handler);
  }

    @override
    void onResponse(Response response, ResponseInterceptorHandler handler) {
      if (response.statusCode! >= 200 &&
          response.statusCode! < 400) {
        response.statusCode = 200;
      }
      return super.onResponse(response, handler);
    }
  }
